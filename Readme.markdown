# DKSocial

DKSocial makes it easy to post to Twitter and Facebook using Objective-C blocks.
It is used in the apps written by [Mostly Disco](http://www.mostlydisco.com)

## Installation

Copy the files from "Classes" and "External" into to your project folder, and add them to your Xcode project.

Then define the following in your project somewhere:

```objective-c
#define FB_ACCESS_TOKEN_KEY @"ID_GOES_HERE"
#define TWITTER_CONSUMER_KEY @"CONSUMER_KEY_HERE"
#define TWITTER_CONSIMER_SECRET @"CONSUMER_SECRET_HERE"
```

## Usage

### DKFacebook

Before using the DKFacebook class, make sure you follow the 
**Authentication and Authorization** instructions found at
[here](https://github.com/facebook/facebook-ios-sdk) to setup
Facebook in your application.

```objective-c
#import "DKFacebook.h"

- (void)authorizeFacebook {

    [[DKFacebook shared] toggle:^(BOOL enabled) {
        NSLog(@"Enabled: %i", enabled);        
    }];

}

- (void)postLink {

    if([[DKFacebook shared] isEnabled]) {

        [[DKFacebook shared] postLink:@"http://www.google.com" success:^{
            NSLog(@"Posting worked!");
        } error:^{
            NSLog(@"Posting to facebook failed.");
        }];

    }
    
}
```

### DKTwitter

```objective-c
#import "DKTwitter.h"

- (void)authorizeTwitter {

    [[DKTwitter shared] toggle:self block:^(BOOL enabled) {
        NSLog(@"Enabled: %i", enabled);
    }];

}

- (void)tweet {

    if([[DKTwitter shared] isEnabled]) {

        [[DKTwitter shared] postMessage:@"Tweeting like a boss" link:@"http://www.google.com" success:^{
            NSLog(@"Posting worked!");
        } error:^{
            NSLog(@"Posting to Twitter failed.");
        }];

    }

}
```

## Libraries Used

* https://github.com/bengottlieb/Twitter-OAuth-iPhone
* https://github.com/facebook/facebook-ios-sdk
* http://code.google.com/p/json-framework

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.

## Contributers

* [Keith Pitt](http://www.keithpitt.com)
* [Mario Visic](http://www.mariovisic.com)

## License

DKSocial is licensed under the MIT License:

  Copyright (c) 2011 Keith Pitt (http://www.keithpitt.com/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

[DKFacebook.h]: https://github.com/keithpitt/DKSocial/blob/master/Classes/DKFacebook/DKFacebook.h
[DKTwitter.h]: https://github.com/keithpitt/DKSocial/blob/master/Classes/DKTwitter/DKTwitter.h
