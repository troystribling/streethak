//
//  TopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/8/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol TopLauncherViewDelegate <NSObject>

- (void)viewTouchedNamed:(NSString*)name;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TopLauncherView : UIImageView {
	id<TopLauncherViewDelegate> delegate;
    UIView* containedView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (assign) id<TopLauncherViewDelegate> delegate;
@property (nonatomic, retain) UIView* containedView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)_frame image:(NSString*)_image andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
