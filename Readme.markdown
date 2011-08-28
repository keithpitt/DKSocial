# DKSocial

DKSocial makes it easy to post to Twitter and Facebook using Objective-C blocks.
It is used in the apps written by [Mostly Disco](http://www.mostlydisco.com)

## Installation

Copy the files from "Classes" and "External" into to your project folder, and add them to your Xcode project.

Then define the following in your project somewhere:

    #define FB_ACCESS_TOKEN_KEY @"ID_GOES_HERE"
    #define TWITTER_CONSUMER_KEY @"CONSUMER_KEY_HERE"
    #define TWITTER_CONSIMER_SECRET @"CONSUMER_SECRET_HERE"

## Usage

### DKFacebook

1. Follow the **Authentication and Authorization** instructions found at
   [here](https://github.com/facebook/facebook-ios-sdk)

2. Include [DKFacebook.h][] into your controller

3. Create a button on your interface that will enable posting to Facebook.

4. Once you've done that, paste the following code into your controller.
   Obviously you'll need to change some of the variable names to match what
   is in your controller.

        - (IBAction)facebookButtonPressed:(id)sender {

            [[DKFacebook shared] toggle:^(BOOL enabled) {
              self.facebookButton.selected = enabled;
            }];

        }

5. Then post a link using:

        // Post to Facebook if enabled
        if([[DKFacebook shared] isEnabled]) {

          [[DKFacebook shared] postLink:@"http://www.google.com" success:^{

            NSLog(@"Posting worked!");

          } error:^{

            NSLog(@"Posting to facebook failed.");

          }];

        }

### DKTwitter

1. Include [DKTwitter.h][] into your controller

2. Create a button on your interface that will enable posting to Twitter.

3. Once you've done that, paste the following code into your controller.
   Obviously you'll need to change some of the variable names to match what
   is in your controller.

        - (IBAction)twitterButtonPressed:(id)sender {

            [[DKTwitter shared] toggle:self block:^(BOOL enabled) {
              self.twitterButton.selected = enabled;
            }];

        }

4. Then post a tweet using:

        // Post to Twitter if enabled
        if([[DKTwitter shared] isEnabled]) {

          [[DKTwitter shared] postMessage:@"Tweeting like a boss" link:@"http://www.google.com" success:^{

            NSLog(@"Posting worked!");

          } error:^{

            NSLog(@"Posting to Twitter failed.");

          }];

        }

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
* [Mario Visico](http://www.mariovisic.com)

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
