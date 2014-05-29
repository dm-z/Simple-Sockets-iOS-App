//
//  ChatClientJoinViewController.m
//  ChatClient
//
//  Created by Dmitry Zozulya on 19.05.14.
//  Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientJoinViewController.h"
#import "ChatClientStream.h"
#import "ChatClientViewController.h"

@interface ChatClientJoinViewController () <NSStreamDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) ChatClientStream *chat;
@end

@implementation ChatClientJoinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chat = [[ChatClientStream alloc] initWithHost:@"localhost"
                                                    port:80
                                             andDelegate:self];
}

- (IBAction)joinChat
{
    [self.chat setName:self.textField.text];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"toChatClientViewController"]) {
        ChatClientViewController *viewController = segue.destinationViewController;
        viewController.chat = self.chat;
    }
}

@end
