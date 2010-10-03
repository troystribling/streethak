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

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)containedWindow {
    return [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil inWindow:containedWindow];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inWindow:(UIWindow*)containedWindow {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.view.frame = containedWindow.frame;
        [containedWindow addSubview:self.view];
    }
    return self;
}

//===================================================================================================================================
#pragma mark NavigationLauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedConfig {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchedContacts {
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
    [MapTopLauncherView inView:self.mapView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidUnload {
    [super viewDidLoad];
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