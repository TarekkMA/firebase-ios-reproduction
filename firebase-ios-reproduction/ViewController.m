//
//  ViewController.m
//  firebase-ios-reproduction
//
//  Created by Russell Wheatley on 24/01/2024.
//
#import <Firebase.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (IBAction)reproduceexception:(id)sender {
  GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:[FIRApp defaultApp].options.clientID];
  [GIDSignIn.sharedInstance setConfiguration:config];
  
  __weak __auto_type weakSelf = self;
  [GIDSignIn.sharedInstance signInWithPresentingViewController:self
        completion:^(GIDSignInResult * _Nullable result, NSError * _Nullable error) {
    __auto_type strongSelf = weakSelf;
    if (strongSelf == nil) { return; }

    if (error == nil) {
      FIRAuthCredential *credential =
      [FIRGoogleAuthProvider credentialWithIDToken:result.user.idToken.tokenString
                                       accessToken:result.user.accessToken.tokenString];
      
      [[FIRAuth auth] signInWithCredential:credential
                                completion:^(FIRAuthDataResult * _Nullable authResult,
                                             NSError * _Nullable error) {
        if(error){
          NSLog(@"Exception: %@", error);
        } else {
          NSString *email = @"USE SAME EMAIL ADDRESS AS GOOGLE AUTH PROVIDER";
          NSString *password = @"some-password";
          
          FIRAuthCredential *credential =
              [FIREmailAuthProvider credentialWithEmail:email
                                                       password:password];
          
          FIRUser *user = [FIRAuth auth].currentUser;
          
          [user linkWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if(error){
              NSLog(@"failed to link account: %@", error);
            } else {
              NSLog(@"successfully linked accounts: %@", authResult);
            }
          }];
        }
      }];
    } else {
      // ...
    }
  }];
}

@end
