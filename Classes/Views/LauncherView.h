//
//  LauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/8/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol LauncherViewDelegate <NSObject>

- (void)viewTouchedNamed:(NSString*)name;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface LauncherView : UIImageView {
	id<LauncherViewDelegate> delegate;
    UIView* containedView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (assign) id<LauncherViewDelegate> delegate;
@property (nonatomic, retain) UIView* containedView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)_frame image:(NSString*)_image andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
