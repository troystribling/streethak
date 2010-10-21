//
//  streethakAppDelegate.m
//  streethak
//
//  Created by Troy Stribling on 8/23/10.
//  Copyright planBresearch 2010. All rights reserved.
//

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "StreethakAppDelegate.h"
#import "CreateAccountViewController.h"
#import "MapViewController.h"
#import "WebgnosusDbi.h"
#import "GeoLocManager.h"
#import "AlertViewManager.h"
#import "AcceptBuddyRequestView.h"
#import "AccountModel.h"
#import "ServiceModel.h"
#import "ServiceItemModel.h"
#import "ServiceFeatureModel.h"
#import "SubscriptionModel.h"
#import "MessageModel.h"
#import "ContactModel.h"
#import "RosterItemModel.h"
#import "XMPPClientManager.h"
#import "XMPPMessageDelegate.h"
#import "XMPPPresence.h"
#import "XMPPGeoLocUpdate.h"
#import "XMPPPubSub.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StreethakAppDelegate (PrivateAPI)

- (void)initAccount;
- (void)createAccountManager;
- (void)setUnreadMessages;
- (NSString*)shoutNodeForAccount:(AccountModel*)account;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StreethakAppDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize window;
@synthesize viewController;
@synthesize creatingAccount;

//===================================================================================================================================
#pragma mark streethakAppDelegate

//===================================================================================================================================
#pragma mark streethakAppDelegate PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)initAccount {
    [AlertViewManager onStartshowConnectingIndicatorInView:self.window];
    [ServiceModel destroyAll];
    [ServiceItemModel destroyAll];
    [ServiceFeatureModel destroyAll];
    [SubscriptionModel destroyAll];
    AccountModel* account = [AccountModel findFirst];
    if (account) {
        account.connectionState = AccountNotConnected;
        [account update];
        [RosterItemModel destroyAllByAccount:account];
        [ContactModel destroyAllByAccount:account];
        [[XMPPClientManager instance] connectXmppClientForAccount:account];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setUnreadMessages {
    AccountModel* account = [AccountModel findFirst];
    NSInteger msgCount = [MessageModel countUnreadMessagesByAccount:account];
    if (msgCount > 0) {
    } else {
    }
    NSInteger eventCount = [MessageModel countUnreadEventsByAccount:account];
    if (eventCount > 0) {
    } else {
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)shoutNodeForAccount:(AccountModel*)account {
    return [NSString stringWithFormat:@"%@/shout", [account pubSubRoot]];
}

//===================================================================================================================================
#pragma mark UIApplicationDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(UIApplication *)application {        
	WebgnosusDbi* dbi = [WebgnosusDbi instance];
	if (![dbi copyDbFile]) {
		NSLog (@"Database inilaization failed");
		return;
	}	
	[dbi open];
	[[XMPPClientManager instance] addDelegate:[[XMPPMessageDelegate alloc] init]];
	[[XMPPClientManager instance] addDelegate:self];
    [[XMPPClientManager instance] addMessageCountUpdateDelegate:self];
    [[XMPPClientManager instance] addAccountUpdateDelegate:self];
    [self setUnreadMessages];
    if ([AccountModel count] == 0) {
        self.creatingAccount = YES;
        [CreateAccountViewController inView:self.window];
    } else {
        self.creatingAccount = NO;
        [self.window addSubview:self.viewController.view];
        [self initAccount];
    }
    [self.window makeKeyAndVisible];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubSubscriptionsResult:(XMPPIQ *)iq {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveErrorPresence:(XMPPPresence*)presence {
    NSString* title = [[presence toJID] full];
    NSString* message = [[NSString alloc] initWithFormat:@"Error with contact '%@'", [[presence fromJID] full]];
    [AlertViewManager showAlert:title withMessage:message];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveBuddyRequest:(XMPPJID*)buddyJid {
    AccountModel* account = [XMPPMessageDelegate accountForXMPPClient:sender];
    if (account) {
        ContactModel* contact = [ContactModel findByJid:[buddyJid bare] andAccount:account];	
        if (contact == nil) {
            AcceptBuddyRequestView* buddyRequestView = [[AcceptBuddyRequestView alloc] initWithClient:sender buddyJid:buddyJid andDelegate:self];
            [buddyRequestView show];	
            [buddyRequestView release];
        }
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didDiscoverAllUserPubSubNodes:(XMPPJID*)targetJID {
    AccountModel* account = [AccountModel findFirst];
    GeoLocManager* geoLoc = [GeoLocManager instance];
    NSString* geoLocNode = [account geoLocPubSubNode];
    NSString* shoutNode = [self shoutNodeForAccount:account];
    [geoLoc addUpdateDelegate:[[[XMPPGeoLocUpdate alloc] init:account] autorelease] forAccount:account];
    if (![ServiceItemModel findByNode:geoLocNode]) {
        XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:account];
        [XMPPPubSub create:client JID:[account pubSubService] node:geoLocNode];
    } else if (![ServiceItemModel findByNode:shoutNode]) {
        XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:account];
        [XMPPPubSub create:client JID:[account pubSubService] node:shoutNode];
    } else {
        [AlertViewManager dismissActivityIndicator];
        [geoLoc start];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubCreateError:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [AlertViewManager showAlert:@"node create failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubCreateResult:(XMPPIQ*)iq {
}

//===================================================================================================================================
#pragma mark UIAlertViewDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AcceptBuddyRequestView* buddyRequestView = (AcceptBuddyRequestView*)alertView;
    if (buttonIndex == 0) {
        [XMPPPresence decline:buddyRequestView.xmppClient JID:buddyRequestView.buddyJid];        
    } else if (buttonIndex == 1) {
        [XMPPMessageDelegate acceptBuddyRequest:buddyRequestView.xmppClient JID:buddyRequestView.buddyJid];
    }
}

//===================================================================================================================================
#pragma mark XMPPClientManagerMessageCountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)messageCountDidChange {
    [self setUnreadMessages];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerAccountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didAddAccount {
    [self.window addSubview:viewController.view];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didRemoveAccount {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didUpdateAccount {
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
