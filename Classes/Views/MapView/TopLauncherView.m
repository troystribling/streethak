//
//  TopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "TopLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize inventoryLauncher;

//===================================================================================================================================
#pragma mark TopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view {
    return [[[TopLauncherView alloc] initInView:_view] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.image = [UIImage imageNamed:@"top-launcher.png"];
        self.userInteractionEnabled = YES;
        CGRect inventoryFrame = CGRectMake(0.8344*viewWidth, 0.0, 0.1297*viewWidth, viewHeight);
        self.inventoryLauncher = [TouchAreaView createWithFrame:inventoryFrame name:@"inventory" andDelegate:self];
        [self addSubview:self.inventoryLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"inventory"]) {
    }
}

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

@end
