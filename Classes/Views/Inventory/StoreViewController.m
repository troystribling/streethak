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
#import "TouchImageView.h"
#import "TouchAreaView.h"
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
@synthesize sellImage;
@synthesize buyImage;
@synthesize modeView;
@synthesize goldView;
@synthesize buyGoldView;
@synthesize goldLabel;
@synthesize containerView;
@synthesize storeTopLauncherView;
@synthesize storeMode;
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
        CGFloat viewWidth =  self.view.frame.size.width;
        CGFloat viewHeight = self.view.frame.size.height;
        self.containerView = _containerView;
        self.buyImage = [UIImage imageNamed:@"store-buy-button.png"];
        self.sellImage = [UIImage imageNamed:@"store-sell-button.png"];
        self.storeMode = StoreModeBuy;
        self.goldLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:20.0];
        CGRect goldFrame = CGRectMake(0.0, 0.0969*viewHeight, 0.3125*viewWidth, 0.1406*viewHeight);
        self.goldView = [TouchAreaView createWithFrame:goldFrame name:@"gold" andDelegate:self];
        [self.view addSubview:self.goldView];
        CGRect buyGoldFrame = CGRectMake(0.6641*viewWidth, 0.0969*viewHeight, 0.3281*viewWidth, 0.1406*viewHeight);
        self.buyGoldView = [TouchAreaView createWithFrame:buyGoldFrame name:@"buy-gold" andDelegate:self];
        [self.view addSubview:self.buyGoldView];
        CGRect modeFrame = CGRectMake(0.3312*viewWidth, 0.1250*viewHeight, 0.3123*viewWidth, 0.0885*viewHeight);
        self.modeView = [TouchImageView createWithFrame:modeFrame name:@"mode" andDelegate:self];
        self.modeView.contentMode = UIViewContentModeScaleAspectFit; 
        self.modeView.image = self.buyImage;
        [self.view addSubview:self.modeView];
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
        if (self.storeMode == StoreModeBuy) {
        } else {
        }
        [self.itemsView reloadData];
    } 
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
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"gold"]) {
        [[ViewControllerManager instance] showGoldView:self.view];
    } else if ([touchedView.viewName isEqualToString:@"buy-gold"]) {
        [[ViewControllerManager instance] showGoldView:self.view];
    }
}

//===================================================================================================================================
#pragma mark TouchImageView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)imageTouched:(TouchImageView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"mode"]) {
        if (self.storeMode == StoreModeBuy) {
            self.storeMode = StoreModeSell;
            self.modeView.image = self.sellImage;
        } else {
            self.storeMode = StoreModeBuy;
            self.modeView.image = self.buyImage;
        }
    }
}

//===================================================================================================================================
#pragma mark GoldViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setGoldValue {
    self.goldLabel.text = @"999p";
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
    self.storeTopLauncherView = [StoreTopLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self loadItems];
    [self setGoldValue];
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
    cell.itemLabel.text = @"Plate Armor";
    cell.itemLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
    cell.itemPriceLabel.text = @"500p";
    cell.itemPriceLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:28.0];
    cell.itemImage.image = [UIImage imageNamed:@"armor-plate-1.png"];
    return cell;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

//===================================================================================================================================
#pragma mark NSObject

@end
