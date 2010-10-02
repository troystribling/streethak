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

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize containerWindow;

//===================================================================================================================================
#pragma mark InventoryViewController PrivateAPI

//===================================================================================================================================
#pragma mark InventoryViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)_containerWindow {
    return [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:nil inWindow:_containerWindow];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inWindow:(UIWindow*)_containerWindow {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerWindow = _containerWindow;
        self.view.frame = self.containerWindow.frame;
        [self.containerWindow addSubview:self.view];
    }
    return self;
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
}

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
