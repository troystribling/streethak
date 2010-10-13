//
//  ContactMessagesViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/28/09.
//  Copyright 2009 Plan-B Research. All rights reserved.fullJID
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactMessagesViewController.h"
#import "SendMessageViewController.h"
#import "MessageModel.h"
#import "UserModel.h"
#import "RosterItemModel.h"
#import "AccountModel.h"
#import "ChatMessageCache.h"
#import "MessageCell.h"
#import "XMPPClientManager.h"
#import "XMPPDiscoItemsQuery.h"
#import "XMPPDiscoInfoQuery.h"
#import "XMPPClient.h"
#import "XMPPMessage.h"
#import "XMPPJID.h"
#import "CellUtils.h"
#import "AlertViewManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesViewController (PrivateAPI)

- (UITableViewCell*)tableView:(UITableView*)tableView cellForResource:(RosterItemModel*)resource;
- (void)sendMessageButtonWasPressed:(id)sender;
- (void)loadChatMessages;
- (void)loadAccount;
- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactMessagesViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize chatMessages;
@synthesize containerView;
@synthesize account;
@synthesize rosterItem;

//===================================================================================================================================
#pragma mark ContactMessagesViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[ContactMessagesViewController alloc] initWithNibName:@"ContactMessagesViewController" bundle:nil inView:_containerView];
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
#pragma mark ContactMessagesViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendMessageButtonWasPressed:(id)sender {
    SendMessageViewController* viewController = [[SendMessageViewController alloc] initWithNibName:@"SendMessageViewController" bundle:nil];
    viewController.rosterItem = self.rosterItem;
}	

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadChatMessages {
    self.chatMessages = [[ChatMessageCache alloc] initWithJid:[self.rosterItem fullJID] andAccount:self.account];
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
    [self loadChatMessages];
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
- (void)viewDidLoad {
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self addXMPPClientDelgate];
    [self loadAccount];
    [self loadChatMessages];
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
    return [self.chatMessages tableView:tableView heightForRowAtIndexPath:indexPath];
}

//===================================================================================================================================
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatMessages count];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {   
    return [self.chatMessages tableView:tableView cellForRowAtIndexPath:indexPath];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self.chatMessages tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//===================================================================================================================================
#pragma mark UITextViewDelegate

//===================================================================================================================================
#pragma mark NSObject

@end

