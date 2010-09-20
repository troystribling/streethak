//
//  CreateAccountViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 1/1/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class AccountManagerViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CreateAccountViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* jidTextField;
	IBOutlet UITextField* passwordTextField;
	IBOutlet UITextField* confirmedPasswordTextField;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* jidTextField;
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* confirmedPasswordTextField;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)containedView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inView:(UIView*)containerView;

@end
