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
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (assign) id<TopLauncherViewDelegate> delegate;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)_frame andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
