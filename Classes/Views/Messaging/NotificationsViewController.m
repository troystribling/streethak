//
//  NotificationsViewController.m
//  streethak
//
//  Created by Troy Stribling on 10/24/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "NotificationsViewController.h"
#import "NotificationsTopLauncherView.h"
#import "ViewControllerManager.h"
#import "AccountModel.h"
#import "EventsMessageCache.h"
#import "XMPPClientManager.h"
#import "XMPPClient.h"
#import "XMPPMessage.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NotificationsViewController (PrivateAPI)

- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;
- (void)loadAccount;
- (void)loadNotifications;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NotificationsViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize notificationsView;
@synthesize containerView;
@synthesize notifications;
@synthesize account;

//===================================================================================================================================
#pragma mark ShoutsViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil inView:_containerView];
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
#pragma mark ShoutsViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPClientDelgate {
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPClientDelgate {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirst];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadNotifications {
    self.notifications = [[[EventsMessageCache alloc] initWithNode:@"%ngin%" andAccount:self.account] autorelease];
    [self.notificationsView reloadData];
}

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
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
    [[ViewControllerManager instance] showContactsView:self.containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceiveEvent:(XMPPMessage*)message {
    [self loadNotifications];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle  {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    self.notificationsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"display-background.png"]];
    self.notificationsView.separatorColor = [UIColor blackColor];
    [NavigationLauncherView inView:self.view withImageNamed:@"notifications-navigation-launcher.png" andDelegate:self];
    [NotificationsTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self addXMPPClientDelgate];
    [self loadNotifications];
    [super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    return [self.notifications tableView:tableView heightForRowAtIndexPath:indexPath];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {  
    return [self.notifications tableView:tableView cellForRowAtIndexPath:indexPath];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.notifications tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//===================================================================================================================================
#pragma mark NSObject

@end
