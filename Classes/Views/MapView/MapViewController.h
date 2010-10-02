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

//-----------------------------------------------------------------------------------------------------------------------------------
@class RMMapView;
@class RMMarker;
@class MapGeoLocUpdateDelegate;
@class OverlayRMMapView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapViewController : UIViewController <NavigationLauncherViewDelegate> {
	IBOutlet OverlayRMMapView* mapView;
    MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
    RMMarker* userMarker;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) RMMapView* mapView;
@property (nonatomic, retain) MapGeoLocUpdateDelegate* mapGeoLocUpdateDelegate;
@property (nonatomic, retain) RMMarker* userMarker;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)containedView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)containedView;

@end

