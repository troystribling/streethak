//
//  ContactMessageViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/28/09.
//  Copyright 2009 Plan-B Research. All rights reserved.fullJID
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactMessageViewController.h"
#import "MessageViewController.h"
#import "MessageModel.h"
#import "UserModel.h"
#import "RosterItemModel.h"
#import "AccountModel.h"
#import "ChatMessageCache.h"
#import "ContactCell.h"
#import "XMPPClientManager.h"
#import "XMPPDiscoItemsQuery.h"
#import "XMPPDiscoInfoQuery.h"
#import "XMPPClient.h"
#import "XMPPMessage.h"
#import "XMPPJID.h"
#import "CellUtils.h"
#import "AlertViewManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessageViewController (PrivateAPI)

- (UITableViewCell*)tableView:(UITableView*)tableView cellForResource:(RosterItemModel*)resource;
- (void)sendMessageButtonWasPressed:(id)sender;
- (void)loadItems;
- (void)loadAccount;
- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize items;
@synthesize account;
@synthesize rosterItem;

//===================================================================================================================================
#pragma mark ContactMessageViewController

//===================================================================================================================================
#pragma mark ContactMessageViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView*)tableView cellForResource:(RosterItemModel*)resource {
    RosterCell* cell = (RosterCell*)[CellUtils createCell:[RosterCell class] forTableView:tableView];
    cell.resourceLabel.text = resource.resource;
    cell.activeImage.image = [RosterCell rosterItemImage:resource];
    return cell;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendMessageButtonWasPressed:(id)sender {
    MessageViewController* viewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    viewController.rosterItem = self.rosterItem;
}	

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadItems {
    self.items = [[ChatMessageCache alloc] initWithJid:[self.rosterItem fullJID] andAccount:self.account];
    [self.tableView reloadData];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirst];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPClientDelgate {
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPClientDelgate {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceivePresence:(XMPPPresence*)presence {
    [self.rosterItem load];
    [self.tableView reloadData];
}

//----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient *)sender didReceiveMessage:(XMPPMessage *)message {
    [self loadItems];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerMessageCountUpdateDelegate

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle andTitle:(NSString*)viewTitle { 
	if (self = [self initWithNibName:nibName bundle:nibBundle]) { 
        self.title = viewTitle;
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self addXMPPClientDelgate];
    [self loadAccount];
    [self loadItems];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [self removeXMPPClientDelgate];
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
#pragma mark UITableViewDeligate

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self.items tableView:tableView heightForRowAtIndexPath:indexPath];
}

//===================================================================================================================================
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {   
    return [self.items tableView:tableView cellForRowAtIndexPath:indexPath];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self.items tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//===================================================================================================================================
#pragma mark UITextViewDelegate

//===================================================================================================================================
#pragma mark NSObject

@end

