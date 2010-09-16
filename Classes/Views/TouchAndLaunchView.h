//
//  TouchAndLaunchView.h
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchImageView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TouchAndLaunchView : UIView {
    TouchImageView* launchImageView;
    UIImage* launchImage;
    UIView* launchView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchImageView* itemImage;
@property (nonatomic, retain) UIImage* launchImage;
@property (nonatomic, retain) UIView* launchView;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame launchImage:(UIImage*)_launchImage andLaunchView:(UIView*)_launchView;

@end


@end
