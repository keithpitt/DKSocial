//
//  DKFacebook.h
//  DiscoKit
//
//  Created by Keith Pitt on 23/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "FBConnect.h"

#define FB_ACCESS_TOKEN_KEY @"fb_access_token"
#define FB_EXPIRATION_DATE_KEY @"fb_expiration_date"
#define FB_ENABLED @"fb_enabled"

typedef void (^DKFacebookCallback)(void);
typedef void (^DKFacebookErrorCallback)(void);
typedef void (^DKFacebookToggleBlock)(BOOL enabled);

@interface DKFacebook : NSObject <FBSessionDelegate, FBRequestDelegate>

@property (nonatomic, copy) DKFacebookCallback loginCallback;
@property (nonatomic, copy) DKFacebookCallback logoutCallback;
@property (nonatomic, copy) DKFacebookCallback postSuccessCallback;
@property (nonatomic, copy) DKFacebookErrorCallback postFailCallback;
@property (nonatomic, retain) NSArray * permissions;
@property (nonatomic, retain) Facebook * facebook;
@property (nonatomic, retain) NSString * appId;
@property (nonatomic) BOOL enabled;

+ (DKFacebook *)shared;

- (id)initWithAppId:(NSString *)facebookAppId;
- (void)authorize;
- (void)logout;
- (BOOL)isSessionValid;
- (BOOL)isEnabled;
- (void)postLink: (NSString *)link success:(DKFacebookCallback)successCallback error:(DKFacebookErrorCallback)errorCallback;
- (void)toggle:(DKFacebookToggleBlock)block;

// Success and error handing methods for facebook
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error;
- (void)request:(FBRequest *)request didLoad:(id)result;

@end