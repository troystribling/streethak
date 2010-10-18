//
//  ViewControllerManager.h
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class InventoryViewController;
@class ContactsViewController;
@class AddContactViewController;
@class ContactMessagesViewController;
@class SendMessageViewController;
@class EventsViewController;
@class SendEventViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    ContactsViewController* contactsViewController;
    InventoryViewController* inventoryViewController;
    AddContactViewController* addContactViewController;
    ContactMessagesViewController* contactMessagesViewController;
    SendMessageViewController* sendMessageViewController;
    EventsViewController* eventsViewController;
    SendEventViewController* sendEventViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) InventoryViewController* inventoryViewController;
@property (nonatomic, retain) ContactsViewController* contactsViewController;
@property (nonatomic, retain) AddContactViewController* addContactViewController;
@property (nonatomic, retain) ContactMessagesViewController* contactMessagesViewController;
@property (nonatomic, retain) SendMessageViewController* sendMessageViewController;
@property (nonatomic, retain) EventsViewController* eventsViewController;
@property (nonatomic, retain) SendEventViewController* sendEventViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (InventoryViewController*)showInventoryView:(UIView*)containerView;
- (void)removeInventoryView;

- (ContactsViewController*)showContactsView:(UIView*)containerView;
- (void)removeContactsView;

- (AddContactViewController*)showAddContactView:(UIView*)containerView;
- (void)removeAddContactView;

- (ContactMessagesViewController*)showContactMessagesView:(UIView*)containerView;
- (void)removeContactMessagesView;

- (SendMessageViewController*)showSendMessageView:(UIView*)containerView;
- (void)removeSendMessageView;

- (EventsViewController*)showEventsView:(UIView*)containerView;
- (void)removeEventsViewView;

- (SendEventViewController*)showSendEventView:(UIView*)containerView;
- (void)removeSendEventView;

@end
