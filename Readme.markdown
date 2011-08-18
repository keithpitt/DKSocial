# DKSocial

DKSocial makes it easy to post to Twitter and Facebook using Objective-C blocks.
It is used in the apps written by [Mostly Disco](http://www.mostlydisco.com)

## Classes

### DKFacebook

* [DKFacebook][] - wrapper around FBConnect with block callbacks

### DKTwitter

* [DKTwitter][] - wrapper around the MGTwitterEngine with block
  callbackks

## Installation

Copy the files into to your project folder, and add them to your Xcode project.

Then define the following in your project somewhere:

    #define FB_ACCESS_TOKEN_KEY @"ID_GOES_HERE"
    #define TWITTER_CONSUMER_KEY @"CONSUMER_KEY_HERE"
    #define TWITTER_CONSIMER_SECRET @"CONSUMER_SECRET_HERE"

## Usage

### DKFacebook

1. Follow the "Authentication and Authorization" instructions found at
   [here](https://github.com/facebook/facebook-ios-sdk)

2. Include "DKFacebook.h" into your controller

3. Create a button on your interface that will enable posting to Facebook.

4. Once you've done that, paste the following code into your controller.
   Obviously you'll need to change some of the variable names to match what
   is in your controller.

        - (void)updateFacebookButtonStatus {

          // Update the facebook button
          self.facebookButton.selected = [[DKFacebook shared] isEnabled];

        }

        - (IBAction)facebookButtonPressed:(id)sender {

          // If posting to Facebook is enabled, disable it and update
          // the button.
          if ([[DKFacebook shared] isEnabled]) {

            // Disable Facebook posting
            [[DKFacebook shared] setEnabled:NO];

            // Update the facebook button
            [self updateFacebookButtonStatus];

          } else {

            if ([[DKFacebook shared] isSessionValid]) {

              // Enable Facebook posting
              [[DKFacebook shared] setEnabled:YES];

              // Update the facebook button
              [self updateFacebookButtonStatus];

            } else {

              // After we've successfully authenticated with Facebook
              [DKFacebook shared].loginCallback = ^{

                // Update the facebook button
                [self updateFacebookButtonStatus];

                // Set the login callback back to nil
                [DKFacebook shared].loginCallback = nil;

              };

              [[DKFacebook shared] authorize];

            }

          }

        }

### DKTwitter

1. Include "DKTwitter.h" into your controller

2. Create a button on your interface that will enable posting to Twitter.

3. Once you've done that, paste the following code into your controller.
   Obviously you'll need to change some of the variable names to match what
   is in your controller.

    - (void)updateTwitterButtonStatus {

      // Update the twitter button
      self.twitterButton.selected = [[DKTwitter shared] isEnabled];

    }

    - (IBAction)twitterButtonPressed:(id)sender {

      // Dismiss the keyboards
      [self.textViewCounter dismissKeyboard];

      if ([[DKTwitter shared] isEnabled]) {

        // Disable Twitter posting
        [[DKTwitter shared] setEnabled:NO];

        // Update the twitter button
        [self updateTwitterButtonStatus];

      } else {

        // Use the current controller for opening a dialog
        [[DKTwitter shared] setController:self];

        if ([[DKTwitter shared] isSessionValid]) {

          // Enable Twitter posting
          [[DKTwitter shared] setEnabled:YES];

          // Update the twitter button
          [self updateTwitterButtonStatus];

        } else {

          [DKTwitter shared].loginCallback = ^{

            // Update the twitter button
            [self updateTwitterButtonStatus];

            // Set the login callback back to nil
            [DKTwitter shared].loginCallback = nil;

          };

          [[DKTwitter shared] authorize];

        }

      }
    }

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.

[DKFacebook]: https://github.com/keithpitt/DiscoKit/blob/master/DiscoKit/Classes/DKFacebook/DKFacebook.h
[DKTwitter]: https://github.com/keithpitt/DiscoKit/tree/master/DiscoKit/Classes/DKTwitter

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
