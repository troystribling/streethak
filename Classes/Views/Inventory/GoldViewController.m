//
//  GoldViewController.m
//  streethak
//
//  Created by Troy Stribling on 11/7/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "GoldViewController.h"
#import "ViewControllerManager.h"
#import "AccountModel.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface GoldViewController (PrivateAPI)

- (void)loadAccount;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation GoldViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize buyButton;
@synthesize cancelButton;
@synthesize account;
@synthesize containerView;
@synthesize delegate;

//===================================================================================================================================
#pragma mark GoldViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[GoldViewController alloc] initWithNibName:@"GoldViewController" bundle:nil inView:_containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inView:(UIView*)_containerView { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
        self.containerView = _containerView;
        self.view.frame = self.containerView.frame;
        [self.containerView addSubview:self.view];
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)cancelButtonPressed:(id)sender {
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)buyButtonPressed:(id)sender {
    [self.delegate setGoldValue];
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark GoldViewController PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirst];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

//===================================================================================================================================
#pragma mark UITextFieldDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
	return YES; 
}

@end
