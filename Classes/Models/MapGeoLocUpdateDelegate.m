//
//  MapGeoLocUpdateDelegate.m
//  streethak
//
//  Created by Troy Stribling on 8/27/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MapGeoLocUpdateDelegate.h"
#import "MapViewController.h"
#import "RMMarkerManager.h"
#import "RMMapView.h"
#import "RMMapContents.h"
#import "RMLatLong.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapGeoLocUpdateDelegate (PrivateAPI)

- (void)setMapCenter:(RMMapView*)mapView atCorrentLocation:(CLLocationCoordinate2D)loc;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MapGeoLocUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize mapViewController;

//===================================================================================================================================
#pragma mark MapGeoLocUpdateDelegate PrivateApi

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setMapCenter:(RMMapView*)mapView atCorrentLocation:(CLLocationCoordinate2D)loc {
    RMSphericalTrapezium bounds = [mapView.contents latitudeLongitudeBoundingBoxForScreen];
    double bnelat = bounds.northeast.latitude;
    double bnelon = bounds.northeast.longitude;
    double bswlat = bounds.southwest.latitude;
    double bswlon = bounds.southwest.longitude;
    double deltaLat = 0.15*(bnelat-bswlat);
    double deltaLon = 0.15*(bswlon-bnelon);
    if ((bnelat-deltaLat)< loc.latitude || (bswlat+deltaLat) > loc.latitude) {
        [mapView moveToLatLong:loc];
    }
    if ((bnelon+deltaLon) < loc.longitude || (bswlon-deltaLon) > loc.longitude) {
        [mapView moveToLatLong:loc];
    }
}

//===================================================================================================================================
#pragma mark MapGeoLocUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(MapViewController*)initViewController {
	if(self = [super init])  {
        self.mapViewController = initViewController;
	}
	return self;
}

//===================================================================================================================================
#pragma mark LocationManagerDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)geoLocManager:(GeoLocManager*)geoLocMgr didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
    CLLocationCoordinate2D loc;
    loc.latitude = newLocation.coordinate.latitude;
    loc.longitude = newLocation.coordinate.longitude;
    RMMapView* mapView = self.mapViewController.mapView;
    [self setMapCenter:mapView atCorrentLocation:loc];
    RMMarker* userMarker = self.mapViewController.userMarker;
    [mapView.contents.markerManager removeMarker:self.mapViewController.userMarker];
    [mapView.contents.markerManager addMarker:userMarker AtLatLong:loc];
}

@end
