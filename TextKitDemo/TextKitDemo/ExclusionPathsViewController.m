//
//  ExclusionPathsViewController.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-15.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "ExclusionPathsViewController.h"

@interface ExclusionPathsViewController ()
@property (nonatomic, strong, readonly) UIBezierPath *originalButterflyPath;
@property (nonatomic) CGPoint gestureStartingPoint;
@property (nonatomic) CGPoint gestureStartingCenter;
- (UIBezierPath *)translatedBezierPath;
@end

@implementation ExclusionPathsViewController

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
    self.navigationItem.title = @"ExclusionPaths";
    self.textView.textAlignment = NSTextAlignmentJustified;
    
    self.textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBezierPath *)translatedBezierPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //从预先设置好的plist中读取
        _originalButterflyPath = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"butterflyPath" ofType:@"plist"]];
    });
    
    CGRect butterflyImageRect = [self.textView convertRect:self.imageView.frame fromView:self.view];
    UIBezierPath *newButterflyPath = [self.originalButterflyPath copy];
    [newButterflyPath applyTransform:CGAffineTransformMakeTranslation(butterflyImageRect.origin.x, butterflyImageRect.origin.y)];
    
    return newButterflyPath;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
}

- (IBAction)imagePanned:(id)sender
{
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *localSender = sender;
        
        if (localSender.state == UIGestureRecognizerStateBegan) {
            self.gestureStartingPoint = [localSender translationInView:self.textView];
            self.gestureStartingCenter = self.imageView.center;
        } else if (localSender.state == UIGestureRecognizerStateChanged) {
            CGPoint currentPoint = [localSender translationInView:self.textView];
            
            CGFloat distanceX = currentPoint.x - self.gestureStartingPoint.x;
            CGFloat distanceY = currentPoint.y - self.gestureStartingPoint.y;
            
            CGPoint newCenter = self.gestureStartingCenter;
            
            newCenter.x += distanceX;
            newCenter.y += distanceY;
            
            self.imageView.center = newCenter;
            
            self.textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
        } else if (localSender.state == UIGestureRecognizerStateEnded) {
            self.gestureStartingPoint = CGPointZero;
            self.gestureStartingCenter = CGPointZero;
        }
    }
}
@end
