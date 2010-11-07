//
//  GoldViewController.h
//  streethak
//
//  Created by Troy Stribling on 11/7/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol GoldViewDelegate <NSObject>

- (void)setGoldValue;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface GoldViewController : UIViewController {
    IBOutlet UIButton* buyButton;
    IBOutlet UIButton* cancelButton;
    AccountModel* account;
    UIView* containerView;
    id<GoldViewDelegate> delegate;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIButton* buyButton;
@property (nonatomic, retain) UIButton* cancelButton;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) UIView* containerView;
@property (assign) id<GoldViewDelegate> delegate;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inView:(UIView*)_containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)buyButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
