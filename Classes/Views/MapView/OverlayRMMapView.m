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

- (CGImageRef)maskTile:(UIImage*)img;
- (CGContextRef)createContextFromImage:(UIImage*)img;
- (CGImageRef)getImageFromContext:(CGContextRef)ctx usingByteOrder:(CGBitmapInfo)bitmapInfo;
- (CGImageRef)createBitmapFromImage:(UIImage*)img;
- (void)drawImageForTile:(UIImage*)img inContext:(CGContextRef)ctx;
- (void)createImageForTile:(UIImage*)tile inContext:(CGContextRef)ctx;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation OverlayRMMapView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize mapTileBackgroundImage;

//===================================================================================================================================
#pragma mark OverlayRMMapView

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)coder { 
	if (self = [super initWithCoder:coder]) { 
        self.mapTileBackgroundImage = [UIImage imageNamed:@"tile-background.png"];
	} 
	return self; 
} 

//===================================================================================================================================
#pragma mark RMMapViewDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)drawTileLayer:(CALayer*)aLayer inContext:(CGContextRef)ctx {
    UIImage* layerImage = [aLayer valueForKey:@"image"];
    CGRect boundBox = CGContextGetClipBoundingBox(ctx);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextTranslateCTM(ctx, 0.0, -boundBox.size.height);
    CGContextDrawImage(ctx, boundBox, layerImage.CGImage);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UIImage*)willSaveTileImage:(UIImage*)tileImage {
    CGContextRef ctx = [self createContextFromImage:tileImage];     
    [self createImageForTile:tileImage inContext:ctx];
    UIImage* newImage = [UIImage imageWithCGImage:[self getImageFromContext:ctx usingByteOrder:kCGBitmapByteOrder32Little]];
    return newImage;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tapOnMarker:(RMMarker*)marker onMap:(RMMapView*)map {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)mapView:(RMMapView*)map shouldDragMarker:(RMMarker*)marker withEvent:(UIEvent*)event {
    return NO;
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)mapView:(RMMapView*)map didDragMarker:(RMMarker*)marker withEvent:(UIEvent*)event {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)afterMapMove:(RMMapView*)map {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)beforeMapMove:(RMMapView*)map {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void) beforeMapZoom:(RMMapView*)map byFactor:(float)zoomFactor near:(CGPoint)center {
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void) afterMapZoom:(RMMapView*)map byFactor:(float)zoomFactor near:(CGPoint)center {
}

//===================================================================================================================================
#pragma mark OverlayRMMapView PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGImageRef)maskTile:(UIImage*)img {
    CGImageRef bitMapRef = [self createBitmapFromImage:img];
    const float colorMasking[6] = {0xBA, 0xBA, 0xBA, 0xBA, 0xBA, 0xBA};
    return CGImageCreateWithMaskingColors(bitMapRef, colorMasking);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGImageRef)createBitmapFromImage:(UIImage*)img {
    CGContextRef bitmapCtx = [self createContextFromImage:img];     
    CGImageRef imgRef = img.CGImage;
    int imgWidth = CGImageGetWidth(imgRef);
    int imgHeight = CGImageGetHeight(imgRef);
    CGRect rect = CGRectMake(0.0, 0.0, imgWidth, imgHeight);    
    CGContextDrawImage(bitmapCtx, rect, imgRef);
    return [self getImageFromContext:bitmapCtx usingByteOrder:kCGBitmapByteOrder32Little];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGContextRef)createContextFromImage:(UIImage*)img {
    CGImageRef imgRef = img.CGImage;
    int imgWidth = CGImageGetWidth(imgRef);
    int imgHeight = CGImageGetHeight(imgRef);
    int bytes = imgWidth*imgHeight*4;
    void* bufferData = malloc(bytes);    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapCtx = CGBitmapContextCreate(bufferData, imgWidth, imgHeight, 8, imgWidth*4, colorSpaceRef, kCGImageAlphaPremultipliedFirst);     
    CFRelease(colorSpaceRef);
    return bitmapCtx;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGImageRef)getImageFromContext:(CGContextRef)ctx usingByteOrder:(CGBitmapInfo)bitmapInfo {
    int imgWidth = CGBitmapContextGetHeight(ctx);
    int imgHeight = CGBitmapContextGetHeight(ctx);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, CGBitmapContextGetData(ctx), imgWidth*imgHeight*4, NULL);
    CGImageRef bitmapImgRef = CGImageCreate(imgWidth, imgHeight, 8, 32, imgWidth*4, colorSpaceRef, bitmapInfo, provider , NULL, NO, kCGRenderingIntentDefault);
    CFRelease(colorSpaceRef);
    return bitmapImgRef;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)createImageForTile:(UIImage*)tile inContext:(CGContextRef)ctx {
    CGRect boundBox = CGContextGetClipBoundingBox(ctx);
    CGContextDrawImage(ctx, boundBox, self.mapTileBackgroundImage.CGImage);
    CGImageRef maskedTileOverlay = [self maskTile:tile];
    CGContextSetBlendMode(ctx, kCGBlendModeOverlay);
    CGContextDrawImage(ctx, boundBox, maskedTileOverlay);
    CFRelease(maskedTileOverlay);
}


@end
