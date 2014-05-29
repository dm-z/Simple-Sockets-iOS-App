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

#pragma mark - lifecycle

- (id)initWithHost:(NSString *)host
           andPort:(NSUInteger)port
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

        self.inputStream.delegate = self;
        self.outputStream.delegate = self;

        [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                    forMode:NSDefaultRunLoopMode];
        [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                     forMode:NSDefaultRunLoopMode];
        [self.inputStream open];
        [self.outputStream open];
        _messages = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - public

- (void)setName:(NSString *)name
{
    _name = name;
    NSString *response = [NSString stringWithFormat:@"iam:%@", name];
    [self write:response];
}

- (void)sendMessage:(NSString *)message
{
    NSString *streamMessage = [NSString stringWithFormat:@"msg:%@", message];
    [self write:streamMessage];
}

#pragma mark - private

- (NSInteger)write:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSASCIIStringEncoding]];
    return [self.outputStream write:[data bytes] maxLength:[data length]];
}


#pragma mark - NSStreamDelegate

- (void)stream:(NSStream *)theStream
   handleEvent:(NSStreamEvent)streamEvent
{
    switch (streamEvent) {

        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            if (theStream == self.inputStream) {

                uint8_t buffer[1024];
                int len;

                while ([self.inputStream hasBytesAvailable]) {
                    len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {

                        NSString *output = [[NSString alloc] initWithBytes:buffer
                                                                    length:len
                                                                  encoding:NSASCIIStringEncoding];

                        if (nil != output) {
                            NSLog(@"server said: %@", output);
                            NSString *oneLine = [output stringByReplacingOccurrencesOfString:@"\r\n"
                                                                                  withString:@""];
                            [self.messages addObject:oneLine];
                            [self.delegate messageReceived:oneLine];
                        }
                    }
                }
            }
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
        case NSStreamEventEndEncountered:
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            break;

        default:
            NSLog(@"Unknown event");
            break;
    }

    NSLog(@"stream event %i", streamEvent);
}

@end