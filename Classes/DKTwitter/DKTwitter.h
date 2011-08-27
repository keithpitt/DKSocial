//
//  SMTwitterHelper.h
//  DiscoKit
//
//  Created by Mario Visic on 23/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"

#define TWITTER_ENABLED @"twitter_enabled"
#define TWITTER_OAUTH_DATA @"twitter_oauth_data"

typedef void (^DKTwitterCallback)(void);
typedef void (^DKTwitterErrorCallback)(void);
typedef void (^DKTwitterToggleBlock)(BOOL enabled);

@interface DKTwitter : NSObject <SA_OAuthTwitterControllerDelegate, SA_OAuthTwitterEngineDelegate>

@property (nonatomic, copy) DKTwitterCallback loginCallback;
@property (nonatomic, copy) DKTwitterCallback logoutCallback;
@property (nonatomic, copy) DKTwitterCallback messageSuccessCallback;
@property (nonatomic, copy) DKTwitterErrorCallback messageFailCallback;

@property (nonatomic, retain) UIViewController * controller;
@property (nonatomic, retain) SA_OAuthTwitterEngine * engine;

@property (nonatomic) BOOL enabled;

+ (DKTwitter *)shared;

- (id)initWithConsumerKey: (NSString *)consumerKey andConsumerSecret: (NSString *)consumerSecret;
- (void)authorize;
- (void)logout;
- (BOOL)isSessionValid;
- (BOOL)isEnabled;
- (void)postMessage: (NSString *)message link:(NSString *)link success:(DKTwitterCallback)successCallback error:(DKTwitterErrorCallback)errorCallback;
- (void)toggle:(UIViewController *)viewController block:(DKTwitterToggleBlock)block;

@end