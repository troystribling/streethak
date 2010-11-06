//
//  InventoryViewController.m
//  streethak
//
//  Created by Troy Stribling on 9/19/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "InventoryViewController.h"
#import "NavigationLauncherView.h"
#import "InventoryTopLauncherView.h"
#import "ViewControllerManager.h"
#import "XMPPClientManager.h"
#import "AccountModel.h"
#import "CellUtils.h"
#import "InventoryItemCell.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize itemsView;
@synthesize equippedImage;
@synthesize unequippedImage;
@synthesize equipButtonView;
@synthesize containerView;
@synthesize equipMode;
@synthesize items;
@synthesize account;

//===================================================================================================================================
#pragma mark InventoryViewController PrivateAPI

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
        if (self.equipMode == EquipModeEquipped) {
        } else {
        }
        [self.itemsView reloadData];
    } 
}

//===================================================================================================================================
#pragma mark InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:nil inView:_containerView];;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerView = _containerView;
        self.equippedImage = [UIImage imageNamed:@"inventory-equipped-button.png"];
        self.unequippedImage = [UIImage imageNamed:@"inventory-unequipped-button.png"];
        self.equipMode = EquipModeEquipped;
        self.view.frame = self.containerView.frame;
    }
    return self;
}

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
    if ([_name isEqualToString:@"store"]) {
        [self.view removeFromSuperview];
        [[ViewControllerManager instance] showStoreView:self.containerView];
    } else if ([_name isEqualToString:@"back"]) {
        [self.view removeFromSuperview];
    } else if ([_name isEqualToString:@"mode"]) {
        if (self.equipMode == EquipModeEquipped) {
            self.equipMode = EquipModeUnequipped;
        } else {
            self.equipMode = EquipModeEquipped;
        }
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
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    self.itemsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"display-background.png"]];
    self.itemsView.separatorColor = [UIColor blackColor];
    [NavigationLauncherView inView:self.view withImageNamed:@"map-navigation-launcher.png" andDelegate:self];
    [InventoryTopLauncherView inView:self.view andDelegate:self];
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
    InventoryItemCell* cell = (InventoryItemCell*)[CellUtils createCell:[InventoryItemCell class] forTableView:tableView];
    cell.itemLabel.text = @"Shield";
    cell.itemLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
    cell.itemImage.image = [UIImage imageNamed:@"shield-1.png"];
    return cell;
    return nil;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
