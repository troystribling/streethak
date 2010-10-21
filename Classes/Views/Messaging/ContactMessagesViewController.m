//
//  ContactMessagesViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/28/09.
//  Copyright 2009 Plan-B Research. All rights reserved.fullJID
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactMessagesViewController.h"
#import "ContactMessagesTopLauncherView.h"
#import "NavigationLauncherView.h"
#import "ViewControllerManager.h"
#import "SendMessageViewController.h"
#import "MessageModel.h"
#import "UserModel.h"
#import "ContactModel.h"
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

- (void)loadChatMessages;
- (void)loadAccount;
- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactMessagesViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize messagesView;
@synthesize chatMessages;
@synthesize containerView;
@synthesize topLauncher;
@synthesize account;
@synthesize contact;

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

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setContactName:(ContactModel*)_contact {
    self.contact = _contact;
    self.topLauncher.contactNameLabel.text = [[self.contact toJID] user];
    [self loadChatMessages];
}

//===================================================================================================================================
#pragma mark ContactMessagesViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadChatMessages {
    if (self.contact) {
        self.chatMessages = [[ChatMessageCache alloc] initWithJid:[self.contact fullJID] andAccount:self.account];
        [self.messagesView reloadData];
    }
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
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)name {
    if ([name isEqualToString:@"send-message"]) {
        SendMessageViewController* sendController = [[ViewControllerManager instance] showSendMessageView:self.view];
        sendController.contact = self.contact;
    }
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
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceivePresence:(XMPPPresence*)presence {
    [self loadChatMessages];
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
    self.messagesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"display-background.png"]];
    self.messagesView.separatorColor = [UIColor blackColor];
    [NavigationLauncherView inView:self.view withImageNamed:@"contacts-navigation-launcher.png" andDelegate:self];
    self.topLauncher = [ContactMessagesTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self loadChatMessages];
    [self addXMPPClientDelgate];
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

