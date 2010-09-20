//
//  EditAccountViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/6/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class AccountManagerViewController;
@class AccountsViewController;
@class SegmentedListPicker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface EditAccountViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* passwordTextField;
 	IBOutlet UITextField* confirmPasswordTextField;
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* deleteButton;
    IBOutlet UISwitch* trackingSwitch;   
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* confirmPasswordTextField;
@property (nonatomic, retain) UIButton* doneButton;
@property (nonatomic, retain) UIButton* deleteButton;
@property (nonatomic, retain) UISwitch* trackingSwitch;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)containedView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inView:(UIView*)containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)sendPassword:(id)sender;

//-----------------------------------------------------------------------------------------------------------------------------------
- (AccountModel*)account;
    
@end
