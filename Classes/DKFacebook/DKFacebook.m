//
//  DKFacebook.m
//  DiscoKit
//
//  Created by Keith Pitt on 23/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKFacebook.h"

@implementation DKFacebook

@synthesize appId, facebook, permissions, loginCallback, logoutCallback, enabled, postSuccessCallback, postFailCallback;

static DKFacebook * sharedFacebookHelper = nil;

+ (DKFacebook *)shared {
    
    if (sharedFacebookHelper == nil) {
        sharedFacebookHelper = [[DKFacebook alloc] initWithAppId:FB_APP_ID];
    }
    
    return sharedFacebookHelper;
    
}

- (id)initWithAppId:(NSString *)facebookAppId {
    
    if ((self = [super init])) {
        
        // Setup the app ID
        self.appId = facebookAppId;
        
        // What we want the facebook authorization for
        self.permissions = [NSArray arrayWithObjects:@"publish_stream",nil];
        
    }
    
    return self;
    
}

- (Facebook *)facebook {
    
    if (!facebook) {
        
        // Create an instance of the facebook object
        facebook = [[Facebook alloc] initWithAppId:appId];
        
        // Load in the credentials
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        facebook.accessToken = [defaults objectForKey:FB_ACCESS_TOKEN_KEY];
        facebook.expirationDate = [defaults objectForKey:FB_EXPIRATION_DATE_KEY];
    }
    
    return facebook;
    
}

- (void)authorize {
    
    // Do we even need to authorize again?
    if ([self isSessionValid]) {
        
        // Call the login callback if we have one
        if (loginCallback) {
            loginCallback();
        }
        
    } else {
        
        // Autorize facebook
        [self.facebook authorize:self.permissions delegate:self];
        
    }
    
}

- (void)logout {
    
    // Logout of facebook
    [self.facebook logout:self];
    
}

- (BOOL)isSessionValid {
    
    return [self.facebook isSessionValid];
    
}

- (BOOL)isEnabled {
    
    return self.enabled && [self isSessionValid];
    
}

- (BOOL)enabled {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:FB_ENABLED] ? true : false;
    
}

- (void)setEnabled:(BOOL)value {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if (value) {
        [defaults setValue:[NSNumber numberWithBool:YES] forKey:FB_ENABLED];
    } else {
        [defaults removeObjectForKey:FB_ENABLED];
    }
    
}

- (void)fbDidLogin {
    
    // Store the facebook credentials
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.facebook.accessToken forKey:FB_ACCESS_TOKEN_KEY];
    [defaults setObject:self.facebook.expirationDate forKey:FB_EXPIRATION_DATE_KEY];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:FB_ENABLED];
    
    [defaults synchronize];
    
    // Call the login callback
    if (loginCallback) {
        loginCallback();
    }
    
}

- (void)fbDidLogout {
    
    // Remove the facebook credentials
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:FB_ACCESS_TOKEN_KEY];
    [defaults removeObjectForKey:FB_EXPIRATION_DATE_KEY];
    
    [defaults synchronize];
    
    // Call the logout callback
    if (logoutCallback) {
        logoutCallback();
    }
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
    if (postFailCallback)
        postFailCallback();
    
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    if (postSuccessCallback)
        postSuccessCallback();
    
}

- (void)postLink:(NSString *)link success:(DKFacebookCallback)successCallback error:(DKFacebookErrorCallback)errorCallback {

    [facebook requestWithGraphPath:@"me/feed"
                         andParams:[NSMutableDictionary dictionaryWithObject:link forKey:@"link"]
                     andHttpMethod:@"POST"
                       andDelegate:self];
    
}

- (void)dealloc {
    
    if(loginCallback) {
        Block_release(loginCallback);
    }
    
    if(logoutCallback) {
        Block_release(logoutCallback);
    }
    
    self.facebook = nil;
    self.permissions = nil;
    self.appId = nil;
    
    [super dealloc];
    
}

@end
