//
//  OverlayRMMapView.h
//  streethak
//
//  Created by Troy Stribling on 8/29/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "RMMapView.h" 
#import "RMMapViewDelegate.h" 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface OverlayRMMapView : RMMapView <RMMapViewDelegate> {
    UIImage* mapTileBackgroundImage;

}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIImage* mapTileBackgroundImage;

//-----------------------------------------------------------------------------------------------------------------------------------

@end
