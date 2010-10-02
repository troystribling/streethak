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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CreateAccountViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* jidTextField;
	IBOutlet UITextField* passwordTextField;
	IBOutlet UITextField* confirmedPasswordTextField;
    IBOutlet UILabel* viewLabel;
    AccountModel* account;
    UIWindow* containerWindow;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* jidTextField;
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* confirmedPasswordTextField;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) UILabel* viewLabel;
@property (nonatomic, retain) UIWindow* containerWindow;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)_containerWindow;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inWindow:(UIWindow*)_containerWindow;

@end
