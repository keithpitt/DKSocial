//
//  SMTwitterHelper.m
//  DiscoKit
//
//  Created by Mario Visic on 23/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKTwitter.h"
#import "SA_OAuthTwitterEngine.h"

@implementation DKTwitter

@synthesize controller, loginCallback, logoutCallback, messageSuccessCallback, messageFailCallback, enabled, engine;

static DKTwitter * sharedTwitter = nil;

+ (DKTwitter *)shared {
    
    if (sharedTwitter == nil) {
        sharedTwitter = [[DKTwitter alloc] initWithConsumerKey:TWITTER_CONSUMER_KEY
                                             andConsumerSecret:TWITTER_CONSUMER_SECRET];

    }
    
    return sharedTwitter;
    
}


- (id)initWithConsumerKey: (NSString *)consumerKey andConsumerSecret: (NSString *)consumerSecret {
    
    if ((self = [super init])) {        
        
        // Create a twitter engine with the consumer key + secret
        engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];  
        engine.consumerKey    = consumerKey;
        engine.consumerSecret = consumerSecret;
    }
    
    return self;
    
}


- (BOOL)isSessionValid {

    return self.engine && [self.engine isAuthorized];
    
}

- (BOOL)isEnabled {
    
    return self.enabled && [self isSessionValid];
    
}


- (BOOL)enabled {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:TWITTER_ENABLED] ? true : false;
    
}

- (void)setEnabled:(BOOL)value {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if (value) {
        [defaults setValue:[NSNumber numberWithBool:YES] forKey:TWITTER_ENABLED];
    } else {
        [defaults removeObjectForKey:TWITTER_ENABLED];
    }
    
}

- (void)logout {

    // Remove access for the current engine
    [self.engine clearAccessToken];
    
    // Remove the stored twitter credentials
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:TWITTER_OAUTH_DATA];
    
    [defaults synchronize];
    
    // Call the logout callback
    if (logoutCallback) {
        logoutCallback();
    }
    
}

- (void)authorize {
    
    // Do we even need to authorize again?
    if ([self isSessionValid]) {
        
        // Call the login callback if we have one
        if (loginCallback) {
            loginCallback();
        }
        
    } else {
        // Autorize twitter
        UIViewController *twitterController = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:engine delegate:self];  
        [self.controller presentModalViewController: twitterController animated: YES];     
    }

}

- (void)toggle:(UIViewController *)viewController block:(DKTwitterToggleBlock)block {
    
    if ([self isEnabled]) {
        
        // Disable Twitter posting
        [self setEnabled:NO];
        
        block(NO);
        
    } else {
        
        self.controller = viewController;
        
        if ([self isSessionValid]) {
            
            // Enable Twitter posting
            [self setEnabled:YES];
            
            block(YES);
            
        } else {
            
            self.loginCallback = ^{
                
                // Update the twitter button
                block([self isEnabled]);
                
                // Set the login callback back to nil
                [DKTwitter shared].loginCallback = nil;
                
            };
            
            [self authorize];
            
        }
        
    }
    
}

- (void)postMessage: (NSString *)message link:(NSString *)link success:(DKTwitterCallback)successCallback error:(DKTwitterErrorCallback)errorCallback {
    
    self.messageSuccessCallback = successCallback;
    self.messageFailCallback = errorCallback;
    
    [self.engine sendUpdate:[NSString stringWithFormat:@"%@ %@", message, link]];
    
}

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
        
    // Call the login callback
    if (loginCallback) {
        loginCallback();
    }
    
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {

    if (messageSuccessCallback) {
        messageSuccessCallback();
    }
    
}


- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
        
    // Store the twitter credentials
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:TWITTER_OAUTH_DATA];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:TWITTER_ENABLED];
    
    [defaults synchronize];
    
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
    
    // Return the last stored auth data (we don't care about username)
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:TWITTER_OAUTH_DATA];
}

- (void) twitterOAuthConnectionFailedWithData: (NSData *) data {
    NSLog(@"Twitter connection failed");
}

- (void)dealloc {
    
    if(loginCallback) {
        Block_release(loginCallback);
    }
    
    if(logoutCallback) {
        Block_release(logoutCallback);
    }
    
    if(messageSuccessCallback) {
        Block_release(messageSuccessCallback);
    }
    
    if(messageFailCallback) {
        Block_release(messageFailCallback);
    }
                        
    self.engine = nil;
    
    [super dealloc];
    
}


@end
