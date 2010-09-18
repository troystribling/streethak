//
//  BottomLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/17/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "BottomLauncherView.h"
#import "TouchImageView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BottomLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BottomLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark BottomLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view {
    return [[[BottomLauncherView alloc] initInView:_view] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view {
    CGRect viewFrame = CGRectMake(0.0, 0.8958*_view.frame.size.height, _view.frame.size.width, 0.1042*_view.frame.size.height);
    if ((self = [self initWithFrame:viewFrame])) {
        self.image = [UIImage imageNamed:@"bottom-launcher.png"];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark TopLauncherView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)imageTouched:(TouchImageView*)_laucnhImageView {
}

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

@end
