//
//  SendEventViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 10/3/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "SendTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;
@class ServiceItemModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SendEventViewDelegate <NSObject>

- (void)eventSent;

@end


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendEventViewController : UIViewController <UITextViewDelegate, LauncherViewDelegate> {
    IBOutlet UITextView* messageView;
    id<SendEventViewDelegate> delegate;
    AccountModel* account;
    NSString* service;
    NSString* node;
    UIView* containerView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextView* messageView;
@property (assign) id<SendEventViewDelegate> delegate;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) NSString* service;
@property (nonatomic, retain) NSString* node;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
