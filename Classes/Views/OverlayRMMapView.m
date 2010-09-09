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

-(CGImageRef)maskTile:(UIImage*)img;
-(CGImageRef)createBitmap:(UIImage*)img;

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

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)drawTileLayer:(CALayer*)aLayer inContext:(CGContextRef)aContext {
    UIImage* layerImage = [aLayer valueForKey:@"image"];
    CGRect boundBox = CGContextGetClipBoundingBox(aContext);
    CGContextTranslateCTM(aContext, 0.0, boundBox.size.height);
    CGContextScaleCTM(aContext, 1.0, -1.0);
    CGContextDrawImage(aContext, boundBox, self.mapTileBackgroundImage.CGImage);
    CGContextSetBlendMode(aContext, kCGBlendModeOverlay);
    CGContextDrawImage(aContext, boundBox, [self maskTile:layerImage]);
}

//-----------------------------------------------------------------------------------------------------------------------------------
-(CGImageRef)maskTile:(UIImage*)img {
    CGImageRef ref1 = [self createBitmap:img];
    const float colorMasking[6] = {0xBA, 0xBA, 0xBA, 0xBA, 0xBA, 0xBA};
    return CGImageCreateWithMaskingColors(ref1, colorMasking);
}

//-----------------------------------------------------------------------------------------------------------------------------------
-(CGImageRef)createBitmap:(UIImage*)img {
    CGImageRef imgRef = img.CGImage;
    int imgWidth = CGImageGetWidth(imgRef);
    int imgHeight = CGImageGetHeight(imgRef);
    int bytes = imgWidth*imgHeight*4;
    void* bufferData = malloc(bytes);    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapCtx = CGBitmapContextCreate(bufferData, imgWidth, imgHeight, 8, imgWidth*4, colorSpaceRef, kCGImageAlphaPremultipliedFirst);     
    CGRect rect = CGRectMake(0.0, 0.0, imgWidth, imgHeight);    
    CGContextDrawImage(bitmapCtx, rect, imgRef); 
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, CGBitmapContextGetData(bitmapCtx), imgWidth*imgHeight*4, NULL);
    CGImageRef bitmapImgRef = CGImageCreate(imgWidth, imgHeight, 8, 32, imgWidth*4, colorSpaceRef, kCGBitmapByteOrder32Little, provider , NULL, NO, kCGRenderingIntentDefault);
    CFRelease(colorSpaceRef);
    return bitmapImgRef;
}

@end
