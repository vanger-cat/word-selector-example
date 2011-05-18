//
//  word_selector_prototypeViewController.h
//  word-selector-prototype
//
//  Created by Vanger on 18.05.11.
//  Copyright 2011 Flexis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface word_selector_prototypeViewController : UIViewController {
    
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *translationLabel;
@property (retain, nonatomic) UIButton *selectedWord;

- (IBAction)wordSelectedInLabel:(id)sender;


@end
