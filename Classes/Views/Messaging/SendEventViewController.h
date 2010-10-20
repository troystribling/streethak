//
//  SendEventViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 10/3/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;
@class ServiceItemModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendEventViewController : UIViewController {
    IBOutlet UITextView* messageView;
    UIView* containerView;
    NSString* service;
    NSString* node;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextView* messageView;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) NSString* service;
@property (nonatomic, retain) NSString* node;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
