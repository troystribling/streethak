//
//  streethakAppDelegate.h
//  streethak
//
//  Created by Troy Stribling on 8/23/10.
//  Copyright planBresearch 2010. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class StreethakViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StreethakAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> {
    UIWindow *window;
    StreethakViewController *viewController;
    BOOL creatingAccount;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StreethakViewController *viewController;
@property (nonatomic, assign) BOOL creatingAccount;

//-----------------------------------------------------------------------------------------------------------------------------------


@end

