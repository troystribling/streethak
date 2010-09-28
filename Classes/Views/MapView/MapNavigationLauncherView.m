//
//  MapNavigationLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/17/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MapNavigationLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapNavigationLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MapNavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize configLauncher;
@synthesize contactsLauncher;
@synthesize mapLauncher;

//===================================================================================================================================
#pragma mark MapNavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view {
    return [[[MapNavigationLauncherView alloc] initInView:_view] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGFloat viewPosY = 0.8958*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0,  viewPosY, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.image = [UIImage imageNamed:@"map-navigation-launcher.png"];
        self.userInteractionEnabled = YES;
        CGRect configFrame = CGRectMake(0.7859*viewWidth, 0.0, 0.1797*viewWidth, viewHeight);
        self.configLauncher = [TouchAreaView createWithFrame:configFrame name:@"config" andDelegate:self];
        [self addSubview:self.configLauncher];
        CGRect contactsFrame = CGRectMake(0.2875*viewWidth, 0.0, 0.4531*viewWidth, viewHeight);
        self.contactsLauncher = [TouchAreaView createWithFrame:contactsFrame name:@"contacts" andDelegate:self];
        [self addSubview:self.contactsLauncher];
        CGRect mapFrame = CGRectMake(0.0312*viewWidth, 0.0, 0.2266*viewWidth, viewHeight);
        self.mapLauncher = [TouchAreaView createWithFrame:mapFrame name:@"location" andDelegate:self];
        [self addSubview:self.mapLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark MapTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"config"]) {
    } else if ([touchedView.viewName isEqualToString:@"contacts"]) {
    } else if ([touchedView.viewName isEqualToString:@"location"]) {
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
