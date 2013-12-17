//
//  ExclusionPathsViewController.h
//  TextKitDemo
//
//  Created by Hydra on 13-12-15.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExclusionPathsViewController : UIViewController
@property (nonatomic,weak) IBOutlet UIImageView* imageView;
@property (nonatomic,weak) IBOutlet UITextView* textView;
- (IBAction)imagePanned:(id)sender;
@end
