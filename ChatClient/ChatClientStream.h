//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChatClientStream : NSObject
@property (retain, nonatomic) NSString *name;

- (id)initWithHost:(NSString *)host
              port:(NSUInteger)port
       andDelegate:(id <NSStreamDelegate>)delegate;
@end