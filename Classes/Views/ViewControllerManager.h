//
//  ViewControllerManager.h
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class CreateAccountViewController;
@class InventoryViewController;
@class MapViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    CreateAccountViewController* createAccountViewController;
    InventoryViewController* inventoryViewController;
    MapViewController* mapViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) CreateAccountViewController* createAccountViewController;
@property (nonatomic, retain) InventoryViewController* inventoryViewController;
@property (nonatomic, retain) MapViewController* mapViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (CreateAccountViewController*)showCreateAccountView:(UIWindow*)containerView;
- (InventoryViewController*)showInventoryView:(UIWindow*)containerView;
- (MapViewController*)showMapView:(UIWindow*)containerView;

@end
