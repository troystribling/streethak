//
//  SendMessageViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/25/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendMessageViewController.h"
#import "MessageModel.h"
#import "AccountModel.h"

#import "XMPPMessage.h"
#import "XMPPClientManager.h"
#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendMessageViewController (PrivateAPI)

- (void)loadAccount;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize messageView;
@synthesize sendMessageButton;
@synthesize account;
@synthesize rosterItem;

//===================================================================================================================================
#pragma mark SendMessageViewController

//===================================================================================================================================
#pragma mark SendMessageViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirstDisplayed];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendMessageButtonWasPressed:(id)sender {
    NSString* enteredMessageText = self.messageView.text;
    if (![enteredMessageText isEqualToString:@""]) {
        MessageModel* model = [[MessageModel alloc] init];
        model.messageText = enteredMessageText;
        model.accountPk = self.account.pk;
        model.toJid = [self.rosterItem fullJID];
        model.fromJid = [self.account fullJID];
        model.textType = MessageTextTypeBody;
        model.createdAt = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        model.itemId = @"-1";
        model.messageRead = YES;
        [model insert];
        [model release];
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        [XMPPMessage chat:xmppClient JID:[self.rosterItem toJID] messageBody:enteredMessageText];
    }    
    [self.messageView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.messageView becomeFirstResponder];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
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

