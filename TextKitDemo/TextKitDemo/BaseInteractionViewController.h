//
//  BaseInteractionViewController.h
//  TextKitDemo
//
//  Created by Hydra on 13-12-15.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseInteractionViewController : UIViewController<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UITextView* textView;
@end
