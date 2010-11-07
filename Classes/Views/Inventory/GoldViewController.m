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
- (void)setMsg;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation GoldViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize buyButton;
@synthesize cancelButton;
@synthesize msgLabel;
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
        self.msgLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
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

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setMsg {
    self.msgLabel.text = @"Buy 100p Gold for $1";
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self setMsg];
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
