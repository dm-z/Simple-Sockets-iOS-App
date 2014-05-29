//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientStream.h"

@interface ChatClientStream ()

@property (retain, nonatomic) NSInputStream *inputStream;
@property (retain, nonatomic) NSOutputStream *outputStream;
@end

@implementation ChatClientStream

#pragma mark - getter/setter

- (id)initWithHost:(NSString *)host
              port:(NSUInteger)port
       andDelegate:(id <NSStreamDelegate>)delegate
{
    self = [super init];
    if (self) {
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef) host, port, &readStream, &writeStream);
        self.inputStream = (__bridge_transfer NSInputStream *) readStream;
        self.outputStream = (__bridge_transfer NSOutputStream *) writeStream;
        CFBridgingRelease(readStream);
        CFBridgingRelease(writeStream);

        self.inputStream.delegate = delegate;
        self.outputStream.delegate = delegate;

        [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                    forMode:NSDefaultRunLoopMode];
        [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                     forMode:NSDefaultRunLoopMode];
        [self.inputStream open];
        [self.outputStream open];
    }
    return self;
}

- (NSInteger)write:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSASCIIStringEncoding]];
    return [self.outputStream write:[data bytes] maxLength:[data length]];
}


@end