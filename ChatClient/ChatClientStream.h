//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ChatClientStreamDelegate
@optional
- (void)messageReceived:(NSString *)newMessage;
@end

@interface ChatClientStream : NSObject <NSStreamDelegate>

@property (weak, nonatomic) id <ChatClientStreamDelegate> delegate;
@property (retain, nonatomic) NSString *name;
@property (readonly, nonatomic) NSMutableArray *messages;

- (id)initWithHost:(NSString *)host
           andPort:(NSUInteger)port;
- (void)sendMessage:(NSString *)message;
@end