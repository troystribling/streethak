//
//  ConfigurationViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/6/09.
//  Copyright planBresearch 2010. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ConfigurationViewController.h"
#import "UICustomSwitch.h"
#import "AccountModel.h"
#import "ServiceItemModel.h"
#import "AlertViewManager.h"
#import "SegmentedListPicker.h"
#import "AccountModel.h"
#import "GeoLocManager.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPRegisterQuery.h"
#import "XMPPGeoLocUpdate.h"
#import "XMPPPubSub.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigurationViewController (PrivateAPI)

- (void)trackingSwitchChanged:(id)sender;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ConfigurationViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize passwordTextField;
@synthesize confirmPasswordTextField;
@synthesize doneButton;
@synthesize deleteButton;
@synthesize trackingSwitch;
@synthesize containerView;

//===================================================================================================================================
#pragma mark ConfigurationViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[ConfigurationViewController alloc] initWithNibName:@"ConfigurationViewController" bundle:nil inView:_containerView];
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
- (IBAction)doneButtonPressed:(id)sender {
    AccountModel* acct = [self account];
    [AccountModel setAllNotDisplayed];
    acct.displayed = YES;
    [acct update];
    [[[XMPPClientManager instance] accountUpdateDelegate] didUpdateAccount];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)deleteButtonPressed:(id)sender {
    AccountModel* acct = [self account];
    [[XMPPClientManager instance] removeXMPPClientForAccount:acct];
    GeoLocManager* geoLoc = [GeoLocManager instance];
    if ([geoLoc accountUpdatesEnabled:acct]) {
        [geoLoc removeUpdateDelegatesForAccount:acct];
        [geoLoc stopIfNotUpdating];
    }
    [acct destroy];
    if ([AccountModel count] > 0) {    
        [[[XMPPClientManager instance] accountUpdateDelegate] didRemoveAccount];
    }
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendPassword:(id)sender {
	NSString* password = self.passwordTextField.text;
	NSString* reenterPassword = self.confirmPasswordTextField.text;
    [self.confirmPasswordTextField resignFirstResponder]; 
    if (![password isEqualToString:@""] && [password isEqualToString:reenterPassword]) {
        NSString* username = [[[self account] toJID] user];
        XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        [XMPPRegisterQuery set:client user:username withPassword:password];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Changing Password"];
    } else {
        [AlertViewManager showAlert:@"Password is Invalid"];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (AccountModel*)account {
    return [AccountModel findFirst];
}

//===================================================================================================================================
#pragma mark ConfigurationViewController PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)trackingSwitchChanged:(id)sender {
    GeoLocManager* geoLoc = [GeoLocManager instance];
    if (self.trackingSwitch.on) {
        NSString* geoLocNode = [[self account] geoLocPubSubNode];
        [geoLoc addUpdateDelegate:[[[XMPPGeoLocUpdate alloc] init:[self account]] autorelease] forAccount:[self account]];
        if (![ServiceItemModel findByNode:geoLocNode]) {
            XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:self.account];
            [XMPPPubSub create:client JID:[self.account pubSubService] node:geoLocNode];
            [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Adding Node"];
        } else {
            [geoLoc start];
        }
    } else {
        [geoLoc removeUpdateDelegatesForAccount:[self account]];
        [geoLoc stopIfNotUpdating];
    }
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubCreateError:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [self.trackingSwitch setOn:NO animated:YES];
    [AlertViewManager showAlert:@"geoloc node create failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubCreateResult:(XMPPIQ*)iq {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didDiscoverAllUserPubSubNodes:(XMPPJID*)jid {
    [AlertViewManager dismissActivityIndicator];
    GeoLocManager* geoLoc = [GeoLocManager instance];
    [geoLoc start];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceiveRegisterError:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [AlertViewManager showAlert:@"Error Changing Password"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceiveRegisterResult:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [AlertViewManager showAlert:@"Password Changed"];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    [self.trackingSwitch addTarget:self action:@selector(trackingSwitchChanged:) forControlEvents:UIControlEventValueChanged];    
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
    if ([[GeoLocManager instance] accountUpdatesEnabled:[self account]]) {
        self.trackingSwitch.on = YES;
    } else {
        self.trackingSwitch.on = NO;
    }
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
	[super viewWillDisappear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//===================================================================================================================================
#pragma mark UITextFieldDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
	return YES; 
}

@end

