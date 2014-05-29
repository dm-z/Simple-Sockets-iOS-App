//
// Created by Dmitry Zozulya on 29.05.14.
// Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import "ChatClientViewController.h"
#import "ChatClientStream.h"

@interface ChatClientViewController () <UITableViewDataSource, UITabBarDelegate, ChatClientStreamDelegate>

@property (nonatomic) IBOutlet UITableView *tableVIew;
@property (nonatomic) IBOutlet UITextField *textField;
@end

@implementation ChatClientViewController

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *titleString = [NSString stringWithFormat:@"You entered as '%@'", self.chat.name];
    self.title = titleString;
    self.chat.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.chat.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }

    NSInteger revertIndex = self.chat.messages.count - indexPath.row - 1;
    cell.textLabel.text = self.chat.messages[(NSUInteger) revertIndex];

    return cell;
}

#pragma mark - ChatClientStreamDelegate

- (void)messageReceived:(NSString *)newMessage
{
    [self.tableVIew reloadData];
}

#pragma mark - actions

- (IBAction)sendMessage
{
    [self.chat sendMessage:self.textField.text];
    self.textField.text = @"";
}
@end