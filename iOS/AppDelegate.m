/*
 *  AppDelegate.m
 *  FileMD5Hash
 * 
 *  Copyright © 2010 Joel Lopes Da Silva. All rights reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 * 
 *        http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

//---------------------------------------------------------
// Imports
//---------------------------------------------------------

// Header file
#import "AppDelegate.h"

// FileMD5Hash
#include "FileMD5Hash.h"


//---------------------------------------------------------
// Interface declaration
//---------------------------------------------------------

@implementation AppDelegate


#pragma mark -
#pragma mark Deallocation

- (void)dealloc {
    [window release];
    [label release];
    [super dealloc];
}



#pragma mark -
#pragma mark Properties

@synthesize window;
@synthesize label;



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application 
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    [window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to 
    // inactive state. This can occur for certain types of temporary 
    // interruptions (such as an incoming phone call or SMS message) 
    // or when the user quits the application and it begins the 
    // transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and 
    // throttle down OpenGL ES frame rates. Games should use this 
    // method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while 
    // the application was inactive.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate.
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // Free up as much memory as possible by purging cached data objects 
    // that can be recreated (or reloaded from disk) later.
}



#pragma mark -
#pragma mark Actions

- (IBAction)computeMD5HashOfBinary:(id)sender {
    NSString *executablePath = [[NSBundle mainBundle] executablePath];
    CFStringRef executableFileMD5Hash = 
        FileMD5HashCreateWithPath((CFStringRef)executablePath, 
                                  FileHashDefaultChunkSizeForReadingData);
    if (executableFileMD5Hash) {
        [[self label] setText:((NSString *)executableFileMD5Hash)];
        CFRelease(executableFileMD5Hash);
    }
}


@end
