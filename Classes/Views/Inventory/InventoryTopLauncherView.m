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
@synthesize backLauncher;
@synthesize containerView;

//===================================================================================================================================
#pragma mark InventoryTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark InventoryTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate {
    return [[InventoryTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame andDelegate:_delegate])) {
        self.containerView = _view;
        self.image = [UIImage imageNamed:@"inventory-top-launcher.png"];
        self.userInteractionEnabled = YES;
        CGRect backFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:backFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
        CGRect storeFrame = CGRectMake(0.7812*viewWidth, 0.0, 0.2031*viewWidth, viewHeight);
        self.storeLauncher = [TouchAreaView createWithFrame:storeFrame name:@"store" andDelegate:self];
        [self addSubview:self.storeLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"store"]) {
    } else {
        [self.delegate viewTouchedNamed:touchedView.viewName];
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

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
