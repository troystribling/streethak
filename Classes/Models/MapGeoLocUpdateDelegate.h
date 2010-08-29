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
@class StreethakViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapGeoLocUpdateDelegate : NSObject <GeoLocUpdateDelegate> {
    StreethakViewController* mapViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) StreethakViewController* mapViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(StreethakViewController*)initView;

@end
