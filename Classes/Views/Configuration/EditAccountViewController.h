//
//  EditAccountViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/6/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class SegmentedListPicker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface EditAccountViewController : UIViewController <UITextFieldDelegate, NavigationLauncherViewDelegate> {
	IBOutlet UITextField* passwordTextField;
 	IBOutlet UITextField* confirmPasswordTextField;
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* deleteButton;
    IBOutlet UISwitch* trackingSwitch;   
    UIWindow* containerWindow;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* confirmPasswordTextField;
@property (nonatomic, retain) UIButton* doneButton;
@property (nonatomic, retain) UIButton* deleteButton;
@property (nonatomic, retain) UISwitch* trackingSwitch;
@property (nonatomic, retain) UIWindow* containerWindow;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)_containerWindow;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inWindow:(UIWindow*)_containerWindow;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)sendPassword:(id)sender;

//-----------------------------------------------------------------------------------------------------------------------------------
- (AccountModel*)account;
    
@end
