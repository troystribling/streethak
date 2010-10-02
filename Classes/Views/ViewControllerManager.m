//
//  ViewControllerManager.m
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ViewControllerManager.h"
#import "CreateAccountViewController.h"
#import "InventoryViewController.h"
#import "MapViewController.h"

//-----------------------------------------------------------------------------------------------------------------------------------
static ViewControllerManager* thisViewControllerManager = nil;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ViewControllerManager

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize createAccountViewController;
@synthesize inventoryViewController;
@synthesize mapViewController;

//===================================================================================================================================
#pragma mark ViewControllerManager PrivateApi

//===================================================================================================================================
#pragma mark ViewControllerManager

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance {	
    @synchronized(self) {
        if (thisViewControllerManager == nil) {
            thisViewControllerManager = [[self alloc] init]; 
        }
    }
    return thisViewControllerManager;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CreateAccountViewController*)showCreateAccountView:(UIView*)containerView {
    if (self.createAccountViewController == nil) {
        self.createAccountViewController = [CreateAccountViewController inView:containerView];
    }
    return self.createAccountViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (InventoryViewController*)showInventoryView:(UIView*)containerView {
    if (self.inventoryViewController == nil) {
        self.inventoryViewController = [InventoryViewController inView:containerView];
    }
    return self.inventoryViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (MapViewController*)showMapView:(UIView*)containerView {
    if (self.mapViewController == nil) {
        self.mapViewController = [MapViewController inView:containerView];
    }
    return self.mapViewController;
}

@end
