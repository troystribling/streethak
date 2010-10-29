    //
//  StoreViewController.m
//  streethak
//
//  Created by Troy Stribling on 10/28/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "StoreViewController.h"
#import "ViewControllerManager.h"
#import "StoreTopLauncherView.h"
#import "NavigationLauncherView.h"
#import "AccountModel.h"
#import "XMPPClientManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreViewController (PrivateAPI)

- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;
- (void)loadAccount;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StoreViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize containerView;
@synthesize account;

//===================================================================================================================================
#pragma mark StoreViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil inView:_containerView];
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

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
    if ([_name isEqualToString:@"back"]) {
        [self.view removeFromSuperview];
    }
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
    [self.view removeFromSuperview];
    [[ViewControllerManager instance] showConfigurationView:self.containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedNotifications {
    [self.view removeFromSuperview];
    [[ViewControllerManager instance] showNotificationsView:self.containerView];
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
    [NavigationLauncherView inView:self.view withImageNamed:@"map-navigation-launcher.png" andDelegate:self];
    [StoreTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self addXMPPClientDelgate];
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
#pragma mark NSObject

@end
