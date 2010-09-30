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
- (CreateAccountViewController*)showCreateAccountView:(UIView*)containeView {
    if (self.createAccountViewController == nil) {
        self.createAccountViewController = [CreateAccountViewController inView:containeView];
    }
    return self.createAccountViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
//- (InventoryViewController*)showInventoryView:(UIView*)containeView {
//    if (self.inventoryViewController == nil) {
//        self.inventoryViewController = [InventoryViewController inView:containeView];
//    }
//    return self.inventoryViewController;
//}

@end
