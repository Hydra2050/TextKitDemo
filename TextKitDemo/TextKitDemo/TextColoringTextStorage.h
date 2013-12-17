//
//  TextColoringTextStorage.h
//  TextKitDemo
//
//  Created by Hydra on 13-12-16.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const TKDDefaultTokenName;

@interface TextColoringTextStorage : NSTextStorage
@property (nonatomic, copy) NSDictionary *tokens;  //key：需要处理的文本字段 value：显示的属性
@end
