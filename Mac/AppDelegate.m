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

#import "AppDelegate.h"
#import "FileHash.h"


@implementation AppDelegate

#pragma mark -
#pragma mark Properties

@synthesize window;
@synthesize label;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application 
}


#pragma mark -
#pragma mark Actions

- (IBAction)computeMD5HashOfBinary:(id)sender {
    NSString *executablePath = [[NSBundle mainBundle] executablePath];
    NSString *executableFileMD5Hash = [FileHash md5HashOfFileAtPath:executablePath];
    [[self label] setStringValue:executableFileMD5Hash ? executableFileMD5Hash : @""];
}

@end
