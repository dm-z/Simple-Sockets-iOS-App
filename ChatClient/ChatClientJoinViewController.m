//
//  ChatClientJoinViewController.m
//  ChatClient
//
//  Created by Dmitry Zozulya on 19.05.14.
//  Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientJoinViewController.h"
#import "ChatClientStream.h"

@interface ChatClientJoinViewController () <NSStreamDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) ChatClientStream *stream;
@end

@implementation ChatClientJoinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stream = [[ChatClientStream alloc] initWithHost:@"localhost"
                                                    port:80
                                             andDelegate:self];
}

- (IBAction)joinChat
{
    NSString *response  = [NSString stringWithFormat:@"iam:%@", self.textField.text];
    [self.stream write:response];
}

@end
