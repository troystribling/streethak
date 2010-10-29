//
//  ConfigurationViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/6/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"
#import "NavigationLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class SegmentedListPicker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigurationViewController : UIViewController <UITextFieldDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate, UIAlertViewDelegate> {
	IBOutlet UITextField* passwordTextField;
 	IBOutlet UITextField* confirmPasswordTextField;
    IBOutlet UIButton* updatePasswordButton;
    IBOutlet UIButton* deleteButton;
    IBOutlet UILabel* deleteAccountLabel;
    UIView* containerView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* confirmPasswordTextField;
@property (nonatomic, retain) UIButton* updatePasswordButton;
@property (nonatomic, retain) UIButton* deleteButton;
@property (nonatomic, retain) UILabel* deleteAccountLabel;
@property (nonatomic, retain) UIView* containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inView:(UIView*)_containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)updateButtonPressed:(id)sender;

//-----------------------------------------------------------------------------------------------------------------------------------
- (AccountModel*)account;
    
@end
