//
//  main.m
//  ChatClient
//
//  Created by Dmitry Zozulya on 19.05.14.
//  Copyright (c) 2014 Dmitry Zozulya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatClientAppDelegate.h"

static bool isRunningTests()
{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    NSString* injectBundle = environment[@"XCInjectBundle"];
    return [[injectBundle pathExtension] isEqualToString:@"xctest"];
}

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        if (isRunningTests())
        {
            return UIApplicationMain(argc, argv, nil, nil);
        }
        else {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([ChatClientAppDelegate class]));
        }
    }
}