//
//  ChatVC.swift
//  esc
//
//  Created by Rebecca Shaw on 4/13/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatVC: JSQMessagesViewController {
    
    // MARK: Properties
    var messages = [JSQMessage]()
    
    // message bubble colors
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "chat"
        setupBubbles()
        
        // No avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        observeMessages()
    }
    
    // when user sends a message
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: NSDate!) {
        
        // Using childByAutoId(), you create a child reference with a unique key.
        let itemRef = DataService.dataService.MESSAGE_REF.childByAutoId()
        
        // Create a dictionary to represent the message. A [String: AnyObject] works as a JSON-like object.
        let messageItem = [
            "text": text,
            "senderId": senderId
        ]
        
        // Save the value at the new child location.
        itemRef.setValue(messageItem)
        
        // Play the canonical “message sent” sound.
        JSQSystemSoundPlayer.jsq_playMessageSentSound()

        // Complete the “send” action and reset the input toolbar to empty.
        finishSendingMessage()
    }
    
    // creates a new JSQMessage with a blank displayName and adds it to the data source.
    func addMessage(id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    // synhronizing the data source
    private func observeMessages() {
        
        // creating a query that limits the synchronization to the last 25 messages.
        let messagesQuery = DataService.dataService.MESSAGE_REF.queryLimitedToLast(25)
        
        // Use the .ChildAdded event to observe for every child item that has been added, and will be added, at the messages location.
        messagesQuery.observeEventType(.ChildAdded) { (snapshot: FDataSnapshot!) in
            
            // Extract the senderId and text from snapshot.value.
            let id = snapshot.value["senderId"] as! String
            let text = snapshot.value["text"] as! String
            
            // Extract the senderId and text from snapshot.value.
            self.addMessage(id, text: text)
            
            // Inform JSQMessagesViewController that a message has been received.
            self.finishReceivingMessage()
        }
    }
    
    // for message data - setting up data source and delegate
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    // for message data
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    // aesthetics
    
    // setting the bubble images
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        // Here you retrieve the message based on the NSIndexPath item.
        let message = messages[indexPath.item]
        if message.senderId == senderId {   // Check if the message was sent by the local user. If so, return the outgoing image view.
            return outgoingBubbleImageView
        } else {    // If the message was not sent by the local user, return the incoming image view.
            return incomingBubbleImageView
        }
    }
    
    // remove avatar support and close the gap where the avatars would normally get displayed.
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // message bubble text
    // If the message is sent by the local user, the text color is white. If it’s not sent by the local user, the text is black.
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        
        return cell
    }
}
