//
//  CreateAccountViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 1/1/09.
//  Copyright planBresearch 2010. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "CreateAccountViewController.h"
#import "AccountModel.h"
#import "ServiceItemModel.h"
#import "AlertViewManager.h"
#import "GeoLocManager.h"

#import "XMPPGeoLocUpdate.h"
#import "XMPPPubSub.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CreateAccountViewController (PrivateAPI)

- (void)accountConnectionFailed;
- (BOOL)saveAccount;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CreateAccountViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize jidTextField;
@synthesize passwordTextField;
@synthesize confirmedPasswordTextField;
@synthesize account;
@synthesize viewLabel;
@synthesize containerWindow;

//===================================================================================================================================
#pragma mark CreateAccountViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)_containerWindow {
    return [[CreateAccountViewController alloc] initWithNibName:@"CreateAccountViewController" bundle:nil inWindow:_containerWindow];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle inWindow:(UIWindow*)_containerWindow { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
        self.containerWindow = _containerWindow;
        self.view.frame = self.containerWindow.frame;
        [self.containerWindow addSubview:self.view];
	} 
	return self; 
} 

//===================================================================================================================================
#pragma mark CreateAccountViewController PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)accountConnectionFailed:(NSString*)title {
    [self.account destroy];
    [AlertViewManager dismissActivityIndicator]; 
    [AlertViewManager showAlert:title];
    [[XMPPClientManager instance] removeXMPPClientForAccount:self.account];
    [self becomeFirstResponder];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)saveAccount {
    BOOL saveStatus = YES;
	NSString* enteredJid = self.jidTextField.text;
	NSString* enteredPassword = self.passwordTextField.text;
	NSString* confirmedPassword = self.confirmedPasswordTextField.text;
	NSArray* splitJid = [enteredJid componentsSeparatedByString:@"@"];
    AccountModel* oldAccount = [AccountModel findByJID:enteredJid];
	if ([splitJid count] == 2 && oldAccount == nil && [enteredPassword isEqualToString:confirmedPassword]) {
        [AccountModel setAllNotDisplayed];
		self.account.jid = enteredJid;
		self.account.password = enteredPassword;
        self.account.activated = YES;
        self.account.connectionState = AccountNotConnected;
        self.account.host = [splitJid objectAtIndex:1];
        self.account.resource = [[UIDevice currentDevice] name];
        self.account.nickname = [NSString stringWithFormat:@"%@", [self.account bareJID]];
        self.account.port = 5222;
        self.account.displayed = YES;
        [[XMPPClientManager instance] connectXmppClientForAccount:self.account];
        [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Connecting"];
        [self.account insert];
        [self.account load];
        [[[XMPPClientManager instance] accountUpdateDelegate] didAddAccount];
	} else {
        saveStatus = NO;
        if (oldAccount) {
            [AlertViewManager showAlert:@"Account Exists"];
        } else {
            if ([splitJid count] != 2) {
                [AlertViewManager showAlert:@"JID is Invalid"];
            } else {
                [AlertViewManager showAlert:@"Passwords do not Match"];
            }
        }
	}
	return saveStatus; 
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    self.jidTextField.font = [UIFont fontWithName:@"Washington Text" size:22.0];
    self.passwordTextField.font = [UIFont fontWithName:@"Washington Text" size:22.0];
    self.confirmedPasswordTextField.font = [UIFont fontWithName:@"Washington Text" size:22.0];
	self.account = [[AccountModel alloc] init];
    self.jidTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmedPasswordTextField.delegate = self;
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
	self.jidTextField.text = nil;
	self.passwordTextField.text = nil;
	self.confirmedPasswordTextField.text = nil;
    [self.jidTextField becomeFirstResponder]; 
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
	[super viewWillDisappear:animated];
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
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClientDidNotConnect:(XMPPClient*)sender {
	[self accountConnectionFailed:@"Connection Failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient *)sender didNotAuthenticate:(NSXMLElement*)error {
	[self accountConnectionFailed:@"Authentication Failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClientDidAuthenticate:(XMPPClient *)sender {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didDiscoverAllUserPubSubNodes:(XMPPJID*)targetJID {
    [AlertViewManager dismissActivityIndicator]; 
    GeoLocManager* geoLoc = [GeoLocManager instance];
    NSString* geoLocNode = [[self account] geoLocPubSubNode];
    [geoLoc addUpdateDelegate:[[[XMPPGeoLocUpdate alloc] init:[self account]] autorelease] forAccount:[self account]];
    if (![ServiceItemModel findByNode:geoLocNode]) {
        XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        [XMPPPubSub create:client JID:[self.account pubSubService] node:geoLocNode];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Adding Node"];
    } else {
        [geoLoc start];
    }
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark UITextFieldDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.jidTextField.text == nil || [self.jidTextField.text isEqualToString:@""]) {
        return NO;
    }
    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        return NO;
    }
    if (self.confirmedPasswordTextField.text == nil || [self.confirmedPasswordTextField.text isEqualToString:@""]) {
        return NO;
    }
    BOOL shouldReturn = [self saveAccount];
    if (shouldReturn) {
        [textField resignFirstResponder];
    }
    return shouldReturn;
}

@end

