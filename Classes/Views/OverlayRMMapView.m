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
-(CGImageRef)removeAlpha:(UIImage*)img;

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
    CGContextTranslateCTM(aContext, 0.0, boundBox.size.height);
    CGContextScaleCTM(aContext, 1.0, -1.0);
    CGContextDrawImage(aContext, boundBox, overlayImage.CGImage);
    CGContextSetBlendMode(aContext, kCGBlendModeOverlay);
    CGContextDrawImage(aContext, boundBox, [self maskTile:layerImage]);
}

//-----------------------------------------------------------------------------------------------------------------------------------
-(CGImageRef)maskTile:(UIImage*)img {
    CGImageRef ref1 = [self removeAlpha:img];
    const float colorMasking[6] = {50, 255, 50, 255, 50, 255};
    return CGImageCreateWithMaskingColors(ref1, colorMasking);
}

//-----------------------------------------------------------------------------------------------------------------------------------
-(CGImageRef)removeAlpha:(UIImage*)img {
    CGImageRef imgRef = img.CGImage;
    int imgWidth = CGImageGetWidth(imgRef);
    int imgHeight = CGImageGetHeight(imgRef);
    int bytes = imgWidth*imgHeight*4;
    void* bufferData = malloc(bytes);    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef cgctx = CGBitmapContextCreate (bufferData, imgWidth, imgHeight, 8, imgWidth*4, colorSpaceRef, kCGImageAlphaPremultipliedFirst);     
    CGRect rect = CGRectMake(0.0, 0.0, imgWidth, imgHeight);    
    CGContextDrawImage(cgctx, rect, imgRef); 
    bufferData = CGBitmapContextGetData(cgctx);    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bufferData, imgWidth*imgHeight*4, NULL);
    CGImageRef noAlphaImgRef = CGImageCreate(imgWidth, imgHeight, 8, 32, imgWidth*4, colorSpaceRef, kCGBitmapByteOrderDefault ,provider , NULL, NO, kCGRenderingIntentDefault);
    CFRelease(colorSpaceRef);
    return noAlphaImgRef;
}

@end
