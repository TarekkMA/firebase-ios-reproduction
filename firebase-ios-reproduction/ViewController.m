//
//  ViewController.m
//  firebase-ios-reproduction
//
//  Created by Russell Wheatley on 24/01/2024.
//
#import <Firebase.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (IBAction)reproduceexception:(id)sender {
  FIRFirestore *db = [FIRFirestore firestore];
  
  FIRCollectionReference *collectionRef = [db collectionWithPath:@"test_10153"];
  
  id listener = ^(FIRQuerySnapshot *_Nullable snapshot, NSError *_Nullable error) {
    if (error) {
      NSLog(@"Error: %@", error);
    } else {
      NSLog(@"snapshot: isFromCache: %d", snapshot.metadata.isFromCache);
    }
  };
  
  
  FIRSnapshotListenOptions *options = [[FIRSnapshotListenOptions alloc] init];
  FIRSnapshotListenOptions *optionsWithSourceAndMetadata = [[options
      optionsWithIncludeMetadataChanges:YES] optionsWithSource:FIRListenSourceDefault];
  [collectionRef addSnapshotListenerWithOptions:options listener: listener];
}

@end
