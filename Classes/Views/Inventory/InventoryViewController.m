    //
//  InventoryViewController.m
//  streethak
//
//  Created by Troy Stribling on 9/19/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "InventoryViewController.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation InventoryViewController

//===================================================================================================================================
#pragma mark InventoryViewController PrivateAPI

//===================================================================================================================================
#pragma mark InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)containerView {
    return [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:nil inView:containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.view.frame = containerView.frame;
        [containerView addSubview:self.view];
    }
    return self;
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
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

@end
