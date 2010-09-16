//
//  TouchAndLaunchView.m
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "TouchAndLaunchView.h"
#import "TouchImageView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TouchAndLaunchView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TouchAndLaunchView

//===================================================================================================================================
#pragma mark TouchAndLaunchView PrivateAPI

//===================================================================================================================================
#pragma mark TouchAndLaunchView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame launchImage:(UIImage*)_launchImage andLaunchView:(UIView*)_launchView {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchImageView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)imageTouched:(TouchImageView*)_laucnhImageView {
}

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.itemImage];
}

@end
