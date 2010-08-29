//
//  streethakViewController.h
//  streethak
//
//  Created by Troy Stribling on 1/1/09.
//  Copyright Plan-B Research 2009. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "RMMapViewDelegate.h" 

//-----------------------------------------------------------------------------------------------------------------------------------
@class RMMapView;
@class MapGeoLocUpdateDelegate;
@class RMMarker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StreethakViewController : UIViewController<RMMapViewDelegate> {
	IBOutlet RMMapView* mapView;
    MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
    RMMarker* userMarker;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) RMMapView* mapView;
@property (nonatomic, retain) MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
@property (nonatomic, retain) RMMarker* userMarker;

//-----------------------------------------------------------------------------------------------------------------------------------

@end

