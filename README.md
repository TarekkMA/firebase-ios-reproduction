## Recreate auth bug
1. Replace your GoogleService-Info.plist with your own and update the bundle ID in Xcode.
2. Run `pod install` in root and run `xed .` to open the project in Xcode.
3. Update the URL Type with the reverse client ID found in your GoogleService-Info.plist file.
4. Update the email address in the ViewController with the same email address you use to sign in with Google Auth.
5. Run the app and press the button for reproduction.
6. If you want to see it working, see Podfile for lines to comment/uncomment for installing firebase-ios-sdk v10.17.0 when it last previously worked.
