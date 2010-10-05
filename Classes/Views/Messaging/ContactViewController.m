//
//  ContactViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 1/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactViewController.h"
#import "AccountManagerViewController.h"
#import "ContactCell.h"
#import "AddContactViewController.h"
#import "RosterItemViewController.h"
#import "ContactModel.h"
#import "AccountModel.h"
#import "RosterItemModel.h"
#import "MessageModel.h"

#import "CellUtils.h"
#import "AlertViewManager.h"
#import "SegmentedCycleList.h"

#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPMessage.h"
#import "XMPPRosterItem.h"
#import "XMPPRosterQuery.h"
#import "XMPPJID.h"
#import "XMPPMessageDelegate.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactViewController (PrivateAPI)

- (void)createSegementedController;
- (void)onXmppClientConnectionError:(XMPPClient*)sender;
- (void)loadItems;
- (void)loadAccount;
- (void)reloadtems;
- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;
- (void)addXMPPAccountUpdateDelgate;
- (void)removeXMPPAccountUpdateDelgate;
- (void)addMessageCountUpdateDelgate;
- (void)removeMessageCountUpdateDelgate;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize roster;
@synthesize account;
@synthesize displayType;

//===================================================================================================================================
#pragma mark ContactViewController

//===================================================================================================================================
#pragma mark ContactViewController PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)createSegementedController {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)onXmppClientConnectionError:(XMPPClient*)sender {
    AccountModel* errAccount = [XMPPMessageDelegate accountForXMPPClient:sender];
    [[XMPPClientManager instance] removeXMPPClientForAccount:errAccount];
    [AlertViewManager onStartDismissConnectionIndicatorAndShowErrors];
    [self loadAccount];
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadItems {
    if (self.account) {
        self.roster = [ContactModel findAllByAccount:self.account];
    } 
    [self.tableView reloadData];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirst];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)reloadtems {
    [self loadAccount];
    [self removeXMPPClientDelgate];
    [self addXMPPClientDelgate];
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPClientDelgate {
    if (self.account) {
        [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPClientDelgate {
    if (self.account) {
        [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPAccountUpdateDelgate {
    [[XMPPClientManager instance] addAccountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPAccountUpdateDelgate {
    [[XMPPClientManager instance] removeAccountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addMessageCountUpdateDelgate {
    [[XMPPClientManager instance] addMessageCountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeMessageCountUpdateDelgate {
    [[XMPPClientManager instance] removeMessageCountUpdateDelegate:self];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerAccountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didAddAccount {
    [self reloadtems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didRemoveAccount {
    [self reloadtems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didUpdateAccount {
    [self reloadtems];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClientDidConnect:(XMPPClient*)sender {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClientDidAuthenticate:(XMPPClient*)sender {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveAllRosterItems:(XMPPIQ *)iq {
    [self loadAccount];
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClientDidNotConnect:(XMPPClient*)sender {
    [self onXmppClientConnectionError:sender];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient *)sender didNotAuthenticate:(NSXMLElement*)error {
    [self onXmppClientConnectionError:sender];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceivePresence:(XMPPPresence*)presence {
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveErrorPresence:(XMPPPresence*)presence {
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didRemoveFromRoster:(XMPPRosterItem*)item {
    [AlertViewManager dismissActivityIndicator];
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didAddToRoster:(XMPPRosterItem*)item {
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didRejectBuddyRequest:(XMPPJID*)buddyJid {
    [self loadItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didAcceptBuddyRequest:(XMPPJID*)buddyJid {
    [self loadItems];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerMessageCountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)messageCountDidChange {
    [self.tableView reloadData];
}

//===================================================================================================================================
#pragma mark SegmentedCycleList Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)selectedItemChanged:(SegmentedCycleList*)sender {
    self.displayType = sender.selectedItemIndex;
    [self loadAccount];
    [self loadItems];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)coder { 
	if (self = [super initWithCoder:coder]) { 
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAccount];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self addXMPPClientDelgate];
    [self addXMPPAccountUpdateDelgate];
    [self addMessageCountUpdateDelgate];
    [self loadItems];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [self removeXMPPClientDelgate];
    [self removeXMPPAccountUpdateDelgate];
    [self removeMessageCountUpdateDelgate];
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
#pragma mark UITableViewController

//===================================================================================================================================
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (self.selectedRoster == kCONTACTS_MODE) {
        RosterCell* cell = (RosterCell*)[CellUtils createCell:[RosterCell class] forTableView:tableView];
        ContactModel*  cellItem = [self.roster objectAtIndex:indexPath.row]; 
        cell.resourceLabel.text = cellItem.jid;
        cell.activeImage.image = [RosterCell contactImage:[self.items objectAtIndex:indexPath.row]];
        cell.jid = [cellItem toJID];
        [cell setUnreadMessageCount:self.account];
        return cell;
    } 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {    
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
        ContactModel* contact = [self.roster objectAtIndex:indexPath.row]; 
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:account];
		XMPPJID* contactJID = [XMPPJID jidWithString:[contact bareJID]];
        [XMPPRosterQuery remove:xmppClient JID:contactJID];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Deleting"];
	} 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    RosterItemViewController* chatViewController = [self getChatViewControllerForRowAtIndexPath:indexPath];
    if (chatViewController) {
        [self labelBackButton];
        [self.navigationController pushViewController:chatViewController animated:YES];
        [chatViewController release];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canEdit = NO;
    if (self.displayType == kCONTACTS_MODE) {
        canEdit = YES;
    }
    return canEdit;
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end

