//
//  ChatClientViewController.m
//  ChatClient
//
//  Created by Dmitry Zozulya on 19.05.14.
//  Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientViewController.h"

@interface ChatClientViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) NSInputStream *inputStream;
@property (retain, nonatomic) NSOutputStream *outputStream;
@end

@implementation ChatClientViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNetworkCommunication];
    // Do any additional setup after loading the containerView, typically from a nib.
}

- (IBAction)joinChat
{
    NSLog(@"JoinChat");
}

#pragma mark - private

- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 80, &readStream, &writeStream);
    self.inputStream = (NSInputStream *)readStream;
    self.outputStream = (NSOutputStream *)writeStream;
}

@end
