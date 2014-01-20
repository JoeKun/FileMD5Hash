/*
 *  FileMD5HashViewController.m
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
#import "FileMD5HashViewController.h"

// File hash
#import "FileHash.h"


#pragma mark -
#pragma mark Private extension

@interface FileMD5HashViewController ()

@property (nonatomic, strong) NSButton *button;
@property (nonatomic, strong) NSTextField *label;

@end


#pragma mark -

@implementation FileMD5HashViewController

#pragma mark -
#pragma mark Deallocation

- (void)dealloc {
    self.button.target = nil;
    self.button.action = NULL;
    self.button = nil;
    self.label = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark View lifecycle

- (void)loadView {
    NSView *view = [NSView new];
    
    NSButton *button = [NSButton new];
    button.bezelStyle = NSRoundedBezelStyle;
    button.title = @"Compute MD5 hash of executable file";
    button.target = self;
    button.action = @selector(computeMD5HashOfExecutableFile:);
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:button];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-30.0]];
    
    NSTextField *label = [NSTextField new];
    label.bordered = NO;
    label.selectable = NO;
    label.alignment = NSCenterTextAlignment;
    label.backgroundColor = [NSColor clearColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:label];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:30.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-30.0]];
    
    self.view = view;
    self.button = button;
    self.label = label;
    [label release];
    [view release];
}


#pragma mark -
#pragma mark Button handler

- (void)computeMD5HashOfExecutableFile:(id)sender {
    NSString *executablePath = [[NSBundle mainBundle] executablePath];
    NSString *executableFileMD5Hash = [FileHash md5HashOfFileAtPath:executablePath];
    self.label.stringValue = executableFileMD5Hash ? executableFileMD5Hash : @"Error";
}

@end
