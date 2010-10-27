//
//  MapViewController.m
//  streethak
//
//  Created by Troy Stribling on 11/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MapViewController.h"
#import "MapTopLauncherView.h"
#import "NavigationLauncherView.h"
#import "ViewControllerManager.h"
#import "RMCloudMadeMapSource.h"
#import "RMMarker.h"
#import "RMMarkerManager.h"
#import "OverlayRMMapView.h"
#import "MessageModel.h"
#import "AccountModel.h"
#import "GeoLocManager.h"
#import "MapGeoLocUpdateDelegate.h"
#import "XMPPGeoLoc.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapViewController (PrivateAPI)

- (void)setText:(NSString*)text forMarker:(RMMarker*)marker;
- (void)setLocation;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MapViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize mapView;
@synthesize mapGeoLocUpdateDelegate;
@synthesize userMarker;

//===================================================================================================================================
#pragma mark MapViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setText:(NSString*)text forMarker:(RMMarker*)marker {
    CGSize textSize = [text sizeWithFont:[RMMarker defaultFont]];     
    CGPoint position = CGPointMake(-(textSize.width/2 - marker.bounds.size.width/2), -textSize.height );    
    [marker changeLabelUsingText: text position: position ];    
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setLocation {
    CLLocationCoordinate2D loc;
    MessageModel* geoLocMessage = [MessageModel findLatestGeoLocMessage];
    if (geoLocMessage) {
        XMPPGeoLoc* geoLoc = [geoLocMessage parseGeoLocMessage];
        double lat = [geoLoc lat];
        double lon = [geoLoc lon];
        loc.longitude = lon;
        loc.latitude  = lat;
    } else {
        loc.longitude = kCLOUDMADE_DEFAULT_LON;
        loc.latitude  = kCLOUDMADE_DEAFULT_LAT;
    }
    [self.mapView moveToLatLong:loc];
    [self.mapView.contents.markerManager addMarker:self.userMarker AtLatLong:loc];
}

//===================================================================================================================================
#pragma mark MapViewController

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)name {
    if ([name isEqualToString:@"inventory"]) {
        [[ViewControllerManager instance] showInventoryView:self.mapView];
    } else if ([name isEqualToString:@"stats"]) {
    }
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedNotifications {
    [[ViewControllerManager instance] showNotificationsView:self.mapView];
}            
    
//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
    [[ViewControllerManager instance] showContactsView:self.mapView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedLocation {
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
	id cmTilesource = [[[RMCloudMadeMapSource alloc] initWithAccessKey:kCLOUDMADE_API_KEY styleNumber:kCLOUDMADE_MAP_ID] autorelease];
	[[[RMMapContents alloc] initWithView:mapView tilesource: cmTilesource] autorelease];
	[self.mapView.contents setZoom:kCLOUDMADE_MAP_DEFAULT_ZOOM];
    self.mapView.backgroundColor = [UIColor blackColor];
    self.mapGeoLocUpdateDelegate = [[MapGeoLocUpdateDelegate alloc] init:self];
    UIImage* userLocationMarkerImage = [UIImage imageNamed:@"user-location-marker.png"];
    self.userMarker = [[RMMarker alloc] initWithUIImage:userLocationMarkerImage anchorPoint:CGPointMake(0.5, 1.0)];
    [NavigationLauncherView inView:self.mapView withImageNamed:@"map-navigation-launcher.png" andDelegate:self];
    [MapTopLauncherView inView:self.mapView andDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [[GeoLocManager instance] addUpdateDelegate:self.mapGeoLocUpdateDelegate forAccount:[AccountModel findFirst]];
    [self setLocation];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[GeoLocManager instance] removeUpdateDelegate:self.mapGeoLocUpdateDelegate forAccount:[AccountModel findFirst]];
	[super viewWillDisappear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
