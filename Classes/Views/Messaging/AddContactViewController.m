//
//  AddContactViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 1/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "AddContactViewController.h"
#import "ContactModel.h"
#import "AccountModel.h"
#import "AlertViewManager.h"
#import "AddContactTopLauncherView.h"
#import "XMPPJID.h"
#import "XMPPRosterItem.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPMessageDelegate.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AddContactViewController (PrivateAPI)

- (void)failureAlert:(NSString*)title message:(NSString*)message;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AddContactViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize jidTextField;
@synthesize containerView;
@synthesize account;
@synthesize newContactJidString;

//===================================================================================================================================
#pragma mark AddContactViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil inView:_containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerView = _containerView;
        self.view.frame = self.containerView.frame;
    }
    return self;
}

//===================================================================================================================================
#pragma mark AddContactViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)failureAlert:(NSString*)title message:(NSString*)message { 
    [AlertViewManager showAlert:title withMessage:message];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didAddToRoster:(XMPPRosterItem*)item {
    [AlertViewManager dismissActivityIndicator];
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceiveRosterError:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark TopLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)name {
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [self.containerView addSubview:self.view];
    [AddContactTopLauncherView inView:self.view andDelegate:self];
	self.account = [AccountModel findFirstDisplayed];
	self.jidTextField.returnKeyType = UIReturnKeyDone;
    self.jidTextField.delegate = self;
	self.jidTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
    [self.jidTextField becomeFirstResponder]; 
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//===================================================================================================================================
#pragma mark UITextFieldDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	self.newContactJidString = self.jidTextField.text;
	NSArray* splitJid = [self.newContactJidString componentsSeparatedByString:@"@"];
    [self.jidTextField resignFirstResponder]; 
	if ([splitJid count] == 2) {
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        XMPPJID* contactJID = [XMPPJID jidWithString:self.newContactJidString];
        [XMPPMessageDelegate addBuddy:xmppClient JID:contactJID];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Adding"];
	} else {
		[self failureAlert:@"JID is Invalid" message:@""];
	}
	return NO; 
}

//===================================================================================================================================
#pragma mark NSObject

@end
