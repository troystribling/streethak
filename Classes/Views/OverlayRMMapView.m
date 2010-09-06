//
//  OverlayRMMapView.m
//  streethak
//
//  Created by Troy Stribling on 8/29/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "OverlayRMMapView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface OverlayRMMapView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation OverlayRMMapView

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark OverlayRMMapView

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)drawTileLayer:(CALayer*)aLayer inContext:(CGContextRef)aContext {
    UIImage* overlayImage = [UIImage imageNamed:@"parchment.png"];
    UIImage* layerImage = [aLayer valueForKey:@"image"];
    CGRect boundBox = CGContextGetClipBoundingBox(aContext);
    CGContextScaleCTM(aContext, 1.0, -1.0);
    CGContextTranslateCTM(aContext, 0.0, -boundBox.size.height);
    CGContextDrawImage(aContext, boundBox, overlayImage.CGImage);
    CGContextSetBlendMode(aContext, kCGBlendModeOverlay);
    CGContextDrawImage(aContext, boundBox, layerImage.CGImage);
}

@end

