//
//  NavigationLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/30/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "NavigationLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NavigationLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize configLauncher;
@synthesize notificationsLauncher;
@synthesize contactsLauncher;
@synthesize mapLauncher;
@synthesize delegate;

//===================================================================================================================================
#pragma mark NavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate {
    return [[NavigationLauncherView alloc] initInView:_view withImageNamed:_imageName andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1823*_view.frame.size.height;
    CGFloat viewPosY = 0.8177*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0,  viewPosY, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.delegate = _delegate;
        self.image = [UIImage imageNamed:_imageName];
        self.userInteractionEnabled = YES;
        CGRect configFrame = CGRectMake(0.7735*viewWidth, 0.0, 0.2265*viewWidth, viewHeight);
        self.configLauncher = [TouchAreaView createWithFrame:configFrame name:@"config" andDelegate:self];
        [self addSubview:self.configLauncher];
        CGRect contactsFrame = CGRectMake(0.4297*viewWidth, 0.0, 0.3438*viewWidth, viewHeight);
        self.contactsLauncher = [TouchAreaView createWithFrame:contactsFrame name:@"contacts" andDelegate:self];
        [self addSubview:self.contactsLauncher];
        CGRect notificationsFrame = CGRectMake(0.1563*viewWidth, 0.0, 0.2734*viewWidth, viewHeight);
        self.notificationsLauncher = [TouchAreaView createWithFrame:notificationsFrame name:@"notifications" andDelegate:self];
        [self addSubview:self.notificationsLauncher];
        CGRect mapFrame = CGRectMake(0.0, 0.0, 0.1563*viewWidth, viewHeight);
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
        if ([self.delegate respondsToSelector:@selector(touchedConfig)]) {
            [self.delegate touchedConfig];
        }         
    } else if ([touchedView.viewName isEqualToString:@"notifications"]) {
        if ([self.delegate respondsToSelector:@selector(touchedNotifications)]) {
            [self.delegate touchedNotifications];
        }         
    } else if ([touchedView.viewName isEqualToString:@"contacts"]) {
        if ([self.delegate respondsToSelector:@selector(touchedContacts)]) {
            [self.delegate touchedContacts];
        }         
    } else if ([touchedView.viewName isEqualToString:@"location"]) {
        if ([self.delegate respondsToSelector:@selector(touchedLocation)]) {
            [self.delegate touchedLocation];
        }         
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
