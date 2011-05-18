//
//  word_selector_prototypeAppDelegate.h
//  word-selector-prototype
//
//  Created by Vanger on 18.05.11.
//  Copyright 2011 Flexis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class word_selector_prototypeViewController;

@interface word_selector_prototypeAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet word_selector_prototypeViewController *viewController;

@end
