//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatClientStream;


@interface ChatClientViewController : UIViewController
@property (retain, nonatomic) ChatClientStream *chat;
@end