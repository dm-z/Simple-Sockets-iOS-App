//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientViewController.h"
#import "ChatClientStream.h"


@implementation ChatClientViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *titleString = [NSString stringWithFormat:@"You entered as '%@'", self.chat.name];
    self.title = titleString;
}

@end