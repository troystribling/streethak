//
//  SendMessageViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/25/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendMessageViewController.h"
#import "SendBottomLauncherView.h"
#import "ViewControllerManager.h"
#import "MessageModel.h"
#import "AccountModel.h"
#import "XMPPMessage.h"
#import "XMPPClientManager.h"
#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendMessageViewController (PrivateAPI)

- (void)loadAccount;
- (void)sendMessage;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize messageView;
@synthesize account;
@synthesize contact;
@synthesize containerView;

//===================================================================================================================================
#pragma mark SendMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[SendMessageViewController alloc] initWithNibName:@"SendMessageViewController" bundle:nil inView:_containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerView = _containerView;
        self.view.frame = self.containerView.frame;
        self.messageView.font = [UIFont fontWithName:kGLOBAL_FONT size:24.0];
    }
    return self;
}

//===================================================================================================================================
#pragma mark SendMessageViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirstDisplayed];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendMessage {
    NSString* enteredMessageText = self.messageView.text;
    if (![enteredMessageText isEqualToString:@""]) {
        MessageModel* model = [[MessageModel alloc] init];
        model.messageText = enteredMessageText;
        model.accountPk = self.account.pk;
        model.toJid = [self.contact fullJID];
        model.fromJid = [self.account fullJID];
        model.textType = MessageTextTypeBody;
        model.createdAt = [NSDate date];
        model.itemId = @"-1";
        model.messageRead = YES;
        [model insert];
        [model release];
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        [XMPPMessage chat:xmppClient JID:[self.contact toJID] messageBody:enteredMessageText];
    }    
    [self.messageView resignFirstResponder];
}	

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
    if ([_name isEqualToString:@"send"]) {
        [self sendMessage];
        [[ViewControllerManager instance] contactMessagesViewWillAppear];
        [self.view removeFromSuperview];
    } else if ([_name isEqualToString:@"back"]) {
        [[ViewControllerManager instance] contactMessagesViewWillAppear];
        [self.view removeFromSuperview];
    }
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [SendTopLauncherView inView:self.view withImageNamed:@"send-message-top-launcher.png" andDelegate:self];
    [SendBottomLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    self.messageView.text = @"";
    [self.messageView becomeFirstResponder];
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//===================================================================================================================================
#pragma mark UITextViewDelegate

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end

