//
//  MapViewController.h
//  streethak
//
//  Created by Troy Stribling on 1/1/09.
//  Copyright Plan-B Research 2009. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class RMMapView;
@class RMMarker;
@class MapGeoLocUpdateDelegate;
@class OverlayRMMapView;
@class MapTopLauncherView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapViewController : UIViewController <NavigationLauncherViewDelegate, LauncherViewDelegate> {
	IBOutlet OverlayRMMapView* mapView;
    MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
    MapTopLauncherView* mapTopLauncherView;
    RMMarker* userMarker;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) RMMapView* mapView;
@property (nonatomic, retain) MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
@property (nonatomic, retain) MapTopLauncherView* mapTopLauncherView;
@property (nonatomic, retain) RMMarker* userMarker;

//-----------------------------------------------------------------------------------------------------------------------------------

@end

