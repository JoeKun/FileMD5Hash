/*
 *  FileMD5HashApplicationDelegate.m
 *  FileMD5Hash
 * 
 *  Copyright © 2010-2014 Joel Lopes Da Silva. All rights reserved.
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

// Header file
#import "FileMD5HashApplicationDelegate.h"

// View controller
#import "FileMD5HashViewController.h"


#pragma mark -
#pragma mark Private extension

@interface FileMD5HashApplicationDelegate ()

@property (nonatomic, strong) FileMD5HashViewController *viewController;

@end


#pragma mark -

@implementation FileMD5HashApplicationDelegate

#pragma mark -
#pragma mark Deallocation

- (void)dealloc {
    self.viewController = nil;
    self.window = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSWindow *window = self.window;
    FileMD5HashViewController *viewController = [FileMD5HashViewController new];
    NSView *view = viewController.view;
    NSRect frame = window.frame;
    frame.origin = NSZeroPoint;
    view.frame = frame;
    view.autoresizingMask = (NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin);
    window.contentView = view;
    self.viewController = viewController;
    [viewController release];
}

@end
