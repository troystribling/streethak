//
//  SendMessageViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/25/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendMessageViewController : UIViewController <UITextViewDelegate> {
    IBOutlet UITextView* messageView;
	IBOutlet UIBarButtonItem* sendMessageButton;
    AccountModel* account;
    UserModel* rosterItem;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextView* messageView;
@property (nonatomic, retain) UIBarButtonItem* sendMessageButton;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) UserModel* rosterItem;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendMessageButtonWasPressed:(id)sender;

@end
