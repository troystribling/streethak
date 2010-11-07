//
//  GoldViewController.h
//  streethak
//
//  Created by Troy Stribling on 11/6/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class SegmentedListPicker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface GoldViewController : UIViewController <UITextFieldDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate, UIAlertViewDelegate> {
	IBOutlet UITextField* passwordTextField;
 	IBOutlet UITextField* confirmPasswordTextField;
    IBOutlet UIButton* updatePasswordButton;
    IBOutlet UIButton* deleteButton;
}

@end
