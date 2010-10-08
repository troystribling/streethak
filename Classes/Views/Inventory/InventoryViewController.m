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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize containerView;

//===================================================================================================================================
#pragma mark InventoryViewController PrivateAPI

//===================================================================================================================================
#pragma mark InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:nil inView:_containerView];
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
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedNotifications {
}            

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [self.containerView addSubview:self.view];
    [NavigationLauncherView inView:self.view withImageNamed:@"map-navigation-launcher.png" andDelegate:self];
    [InventoryTopLauncherView inView:self.view];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
