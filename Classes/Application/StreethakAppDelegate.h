//
//  MapViewController.h
//  streethak
//
//  Created by Troy Stribling on 8/23/10.
//  Copyright planBresearch 2010. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class MapViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StreethakAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> {
    UIWindow *window;
    MapViewController *viewController;
    BOOL creatingAccount;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapViewController *viewController;
@property (nonatomic, assign) BOOL creatingAccount;

//-----------------------------------------------------------------------------------------------------------------------------------


@end

