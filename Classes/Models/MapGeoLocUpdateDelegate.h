//
//  MapGeoLocUpdateDelegate.h
//  streethak
//
//  Created by Troy Stribling on 8/27/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "GeoLocManager.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class MapViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapGeoLocUpdateDelegate : NSObject <GeoLocUpdateDelegate> {
    MapViewController* mapViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) MapViewController* mapViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(MapViewController*)initView;

@end
