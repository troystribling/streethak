//
//  NavigationLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 9/30/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol NavigationLauncherViewDelegate <NSObject>

@optional


- (void)touchedConfig;
- (void)touchedContacts;
- (void)touchedLocation;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NavigationLauncherView : UIImageView {
    TouchAreaView* configLauncher;
    TouchAreaView* contactsLauncher;
    TouchAreaView* mapLauncher;
	id<NavigationLauncherViewDelegate> delegate;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* configLauncher;
@property (nonatomic, retain) TouchAreaView* contactsLauncher;
@property (nonatomic, retain) TouchAreaView* mapLauncher;
@property (assign) id<NavigationLauncherViewDelegate> delegate;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate;

@end
