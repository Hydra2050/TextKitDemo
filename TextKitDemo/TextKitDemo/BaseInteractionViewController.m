//
//  BaseInteractionViewController.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-15.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "BaseInteractionViewController.h"

@interface BaseInteractionViewController ()

@end

@implementation BaseInteractionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"BaseInteraction";
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:@"This is a block of text which does not match a data detector.\r\nThis is a phone number: +1 (555) 555-5555\r\nThis is a URL: http://www.apple.com\r\nThis is another block of text which does not match a data detector.\r\nThis URL will not be opened:http://www.google.com" attributes:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextFieldDelegate
-(BOOL) textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if([[URL host] isEqualToString:@"www.google.com"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
@end
