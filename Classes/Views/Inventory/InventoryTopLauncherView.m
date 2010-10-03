//
//  InventoryTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/3/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "InventoryTopLauncherView.h"
#import "TouchAreaView.h"


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation InventoryTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize storeLauncher;
@synthesize statsLauncher;
@synthesize backLauncher;
@synthesize containerView;

//===================================================================================================================================
#pragma mark InventoryTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view {
    return [[[InventoryTopLauncherView alloc] initInView:_view] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.containerView = _view;
        self.image = [UIImage imageNamed:@"inventory-top-launcher.png"];
        self.userInteractionEnabled = YES;
        CGRect backFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:backFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
        CGRect statsFrame = CGRectMake(0.4062*viewWidth, 0.0, 0.1875*viewWidth, viewHeight);
        self.statsLauncher = [TouchAreaView createWithFrame:statsFrame name:@"stats" andDelegate:self];
        [self addSubview:self.statsLauncher];
        CGRect storeFrame = CGRectMake(0.8125*viewWidth, 0.0, 0.1797*viewWidth, viewHeight);
        self.storeLauncher = [TouchAreaView createWithFrame:storeFrame name:@"store" andDelegate:self];
        [self addSubview:self.storeLauncher];
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
    if ([touchedView.viewName isEqualToString:@"back"]) {
        [self.containerView removeFromSuperview];
    } else if ([touchedView.viewName isEqualToString:@"stats"]) {
    } else if ([touchedView.viewName isEqualToString:@"store"]) {
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
