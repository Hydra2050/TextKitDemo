//
//  TextColoringViewController.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-16.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "TextColoringViewController.h"
#import "TextColoringTextStorage.h"
#import "OutliningLayoutManager.h"

@interface TextColoringViewController ()

@end

@implementation TextColoringViewController

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
    self.navigationItem.title = @"TextColoring";
    
    self.textStorage = [[TextColoringTextStorage alloc] init];
    OutliningLayoutManager* layoutManager = [[OutliningLayoutManager alloc] init];
    NSTextContainer* textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    [layoutManager addTextContainer:textContainer];
    [self.textStorage addLayoutManager:layoutManager];
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) textContainer:textContainer];
    [self.view addSubview:textView];
    
    //设置需要处理的文本片段
    self.textStorage.tokens = @{ @"Alice" : @{ NSForegroundColorAttributeName : [UIColor redColor] },
                                 @"once" : @{ NSForegroundColorAttributeName : [UIColor greenColor] },
                                 TKDDefaultTokenName : @{ NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18.]} };
    
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.textStorage beginEditing];
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
    [self.textStorage endEditing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
