//
//  ContactsViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 1/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactsViewController.h"
#import "ContactCell.h"
#import "AddContactViewController.h"
#import "ContactMessagesViewController.h"
#import "ContactsTopLauncherView.h"
#import "ContactModel.h"
#import "AccountModel.h"
#import "RosterItemModel.h"
#import "MessageModel.h"
#import "CellUtils.h"
#import "AlertViewManager.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPMessage.h"
#import "XMPPRosterItem.h"
#import "XMPPRosterQuery.h"
#import "XMPPJID.h"
#import "XMPPMessageDelegate.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactsViewController (PrivateAPI)

- (void)onXmppClientConnectionError:(XMPPClient*)sender;
- (void)loadContacts;
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
@implementation ContactsViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize contactsView;
@synthesize containerView;
@synthesize contacts;
@synthesize account;

//===================================================================================================================================
#pragma mark ContactsViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil inView:_containerView];
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
#pragma mark ContactsViewController PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)onXmppClientConnectionError:(XMPPClient*)sender {
    AccountModel* errAccount = [XMPPMessageDelegate accountForXMPPClient:sender];
    [[XMPPClientManager instance] removeXMPPClientForAccount:errAccount];
    [AlertViewManager onStartDismissConnectionIndicatorAndShowErrors];
    [self loadAccount];
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadContacts {
    if (self.account) {
        self.contacts = [ContactModel findAllByAccount:self.account];
    } 
    [self.contactsView reloadData];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirst];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)reloadContacts {
    [self loadAccount];
    [self removeXMPPClientDelgate];
    [self addXMPPClientDelgate];
    [self loadContacts];
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
#pragma mark TopLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)name {
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedNotifications {
    [self.view removeFromSuperview];
}            

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerAccountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didAddAccount {
    [self reloadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didRemoveAccount {
    [self reloadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didUpdateAccount {
    [self reloadContacts];
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
    [self loadContacts];
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
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveErrorPresence:(XMPPPresence*)presence {
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didRemoveFromRoster:(XMPPRosterItem*)item {
    [AlertViewManager dismissActivityIndicator];
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didAddToRoster:(XMPPRosterItem*)item {
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didRejectBuddyRequest:(XMPPJID*)buddyJid {
    [self loadContacts];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didAcceptBuddyRequest:(XMPPJID*)buddyJid {
    [self loadContacts];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerMessageCountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)messageCountDidChange {
    [self.contactsView reloadData];
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
    self.contactsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"display-background.png"]];
    self.contactsView.separatorColor = [UIColor blackColor];
    [self.containerView addSubview:self.view];
    [NavigationLauncherView inView:self.view withImageNamed:@"contacts-navigation-launcher.png" andDelegate:self];
    [ContactsTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self loadContacts];
    [self addXMPPClientDelgate];
    [self addXMPPAccountUpdateDelgate];
    [self addMessageCountUpdateDelgate];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [self removeXMPPClientDelgate];
    [self removeXMPPAccountUpdateDelgate];
    [self removeMessageCountUpdateDelgate];
	[super viewWillDisappear:animated];
    [self release];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCONTACTS_CELL_HEIGHT;
}

//===================================================================================================================================
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger contactCount = [self.contacts count];
    return contactCount;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    ContactCell* cell = (ContactCell*)[CellUtils createCell:[ContactCell class] forTableView:tableView];
    ContactModel* cellItem = [self.contacts objectAtIndex:indexPath.row]; 
    cell.contactLabel.text = [[cellItem toJID] user];
    cell.contactLabel.font = [UIFont fontWithName:@"Washington Text" size:28.0];
    cell.activeImage.image = [ContactCell contactImage:[self.contacts objectAtIndex:indexPath.row]];
    [cell setUnreadMessageCount:self.account];
    return cell;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {    
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
        ContactModel* contact = [self.contacts objectAtIndex:indexPath.row]; 
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:account];
		XMPPJID* contactJID = [XMPPJID jidWithString:[contact bareJID]];
        [XMPPRosterQuery remove:xmppClient JID:contactJID];
        [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Deleting"];
	} 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    ContactMessagesViewController* chatViewController = [[ContactMessagesViewController alloc] initWithNibName:@"ContactMessagesViewController" bundle:nil];;
    if (chatViewController) {
        [self.navigationController pushViewController:chatViewController animated:YES];
        [chatViewController release];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end

