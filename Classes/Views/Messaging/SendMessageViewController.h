//
//  SendMessageViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/25/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "SendTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class ContactModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendMessageViewController : UIViewController <UITextViewDelegate, LauncherViewDelegate> {
    IBOutlet UITextView* messageView;
    AccountModel* account;
    ContactModel* contact;
    UIView* containerView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextView* messageView;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) ContactModel* contact;
@property (nonatomic, retain) UIView* containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
