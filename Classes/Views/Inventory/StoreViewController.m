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
#import "CellUtils.h"
#import "StoreItemCell.h"
#import "NavigationLauncherView.h"
#import "AccountModel.h"
#import "XMPPClientManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreViewController (PrivateAPI)

- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;
- (void)loadAccount;
- (void)loadItems;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StoreViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize itemsView;
@synthesize containerView;
@synthesize items;
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

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadItems {
    if (self.account) {
    } 
    [self.itemsView reloadData];
}

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
    if ([_name isEqualToString:@"back"]) {
        [self.view removeFromSuperview];
        [[ViewControllerManager instance] showInventoryView:self.containerView];
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
    self.itemsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"display-background.png"]];
    self.itemsView.separatorColor = [UIColor blackColor];
    [NavigationLauncherView inView:self.view withImageNamed:@"map-navigation-launcher.png" andDelegate:self];
    [StoreTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self loadItems];
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
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSTORE_CELL_HEIGHT;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSInteger itemCount = [self.items count];
    return 2;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    StoreItemCell* cell = (StoreItemCell*)[CellUtils createCell:[StoreItemCell class] forTableView:tableView];
    cell.itemLabel.text = @"Health Potion";
    cell.itemLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
    cell.itemPriceLabel.text = @"10GP";
    cell.itemPriceLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
    cell.itemImage.image = [UIImage imageNamed:@"health-potion-1.png"];
    return cell;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

//===================================================================================================================================
#pragma mark NSObject

@end
