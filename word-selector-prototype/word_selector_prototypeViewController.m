//
//  word_selector_prototypeViewController.m
//  word-selector-prototype
//
//  Created by Vanger on 18.05.11.
//  Copyright 2011 Flexis. All rights reserved.
//

#import "word_selector_prototypeViewController.h"

@implementation word_selector_prototypeViewController

@synthesize translationLabel;
@synthesize selectedWord;
@synthesize scrollView;

- (void)dealloc
{
    [selectedWord release];
    selectedWord = NULL;
    
    [scrollView release];
    scrollView = NULL;
    
    [translationLabel release];
    translationLabel = NULL;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (UIView *)addNewPageWithNumber:(CGFloat)pageNumber {
    UIView *page = [[UIView alloc] init];
    page.userInteractionEnabled = YES;
    
    CGFloat x = self.view.frame.size.width * pageNumber;
    CGFloat width = self.scrollView.frame.size.width;
    NSLog(@"Created page with X = %f and Width = %f", x, width);
    
    page.frame = CGRectMake(x, 
                            0, 
                            width,
                            self.scrollView.frame.size.height);
    
    [self.scrollView addSubview:page];
    
    [page release];
    
    return page;
}

- (void)showText:(NSString *)someText {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    
    [array addObject:[self addNewPageWithNumber:0]];
    
    NSArray *words = [someText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    CGFloat borderWidth = 5;
    CGFloat indentBetweenRows = 2;
    CGFloat spaceWidth = 3;
    
    CGFloat width = self.scrollView.frame.size.width * [array count];
    CGFloat height = self.scrollView.frame.size.height;
    
    CGFloat minimalX = borderWidth;
    CGFloat minimalY = borderWidth;
    
    CGFloat maximumX = width - borderWidth;
    CGFloat maximumY = height - borderWidth;
    
    CGFloat x = minimalX;
    CGFloat y = minimalY;
    UIFont *font = [UIFont systemFontOfSize:14];
    for (NSString *word in words) {
        UIButton *wordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wordButton setTitle:word forState:UIControlStateNormal];
        wordButton.titleLabel.font = font;
        wordButton.titleLabel.textColor = [UIColor blackColor];
        wordButton.titleLabel.userInteractionEnabled = NO;
        wordButton.userInteractionEnabled = YES;
        
        CGRect frame = wordButton.frame;
        frame.size = [word sizeWithFont:font];
        
        frame.origin.x = x;
        frame.origin.y = y;
        frame.size.height = frame.size.height + indentBetweenRows;
        if (frame.origin.x + frame.size.width > maximumX) {
            x = minimalX;
            frame.origin.x = x;
            y += frame.size.height + indentBetweenRows;
            
            if (y + frame.size.height > maximumY) {
                y = minimalY;
                [array addObject:[self addNewPageWithNumber:[array count]]];
            }
            frame.origin.y = y;
        }
        wordButton.frame = frame;
        
        x += frame.size.width + spaceWidth;
        
        [wordButton addTarget:self action:@selector(wordSelectedInLabel:) forControlEvents:UIControlEventTouchUpInside];
        
        [[array lastObject] addSubview:wordButton];
    }
    
    self.scrollView.contentSize = CGSizeMake(width * [array count], height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *textFilePath = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"txt"];
    NSString *someText = [NSString stringWithContentsOfFile:textFilePath encoding: NSUTF8StringEncoding error:NULL];
    
    //@"One two three four five aaaaaaaa bbbbbbbbb ccccccccc dddddddddd eeeeeeeee";
    
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.exclusiveTouch = YES;
    self.scrollView.delaysContentTouches = YES;
    
    [self showText:someText];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBActions

- (IBAction)wordSelectedInLabel:(id)sender {
    if (selectedWord) {
        selectedWord.backgroundColor = [UIColor clearColor];
    }
    UIButton *buttonSender = (UIButton *)sender;
    buttonSender.backgroundColor = [UIColor blueColor];
    translationLabel.text = [NSString stringWithFormat:@"<Перевод слова %@>", buttonSender.titleLabel.text];
    
    selectedWord = buttonSender;
}

@end
