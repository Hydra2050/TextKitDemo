//
//  TextColoringTextStorage.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-16.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//
//  Subclassing NSTextStorage，需要重写的四个方法：
//  -(NSString*) string
//  - (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
//  - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
//  - (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
//
#import "TextColoringTextStorage.h"

NSString *const TKDDefaultTokenName = @"TKDDefaultTokenName";

@interface TextColoringTextStorage ()
{
    NSMutableAttributedString* _backingStore;
    BOOL _dynamicTextNeedsUpdate;
}

@end

@implementation TextColoringTextStorage

-(id) init
{
    self = [super init];
    if(self)
    {
        _backingStore = [[NSMutableAttributedString alloc] init];
    }
    return self;
}
-(NSString*) string
{
    return _backingStore.string;
}
- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location effectiveRange:range];
}
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters|NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    
    static NSDataDetector *linkDetector;
	linkDetector = linkDetector ?: [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:NULL];
	
	// Clear text color of edited range
	NSRange paragaphRange = [self.string paragraphRangeForRange: NSMakeRange(range.location, str.length)];
	[self removeAttribute:NSLinkAttributeName range:paragaphRange];
	[self removeAttribute:NSBackgroundColorAttributeName range:paragaphRange];
	[self removeAttribute:NSUnderlineStyleAttributeName range:paragaphRange];
	
	// Find all iWords in range
	[linkDetector enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		// Add red highlight color
		[self addAttribute:NSLinkAttributeName value:result.URL range:result.range];
		[self addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:result.range];
		[self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:result.range];
	}];
    
    _dynamicTextNeedsUpdate = YES;
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)performReplacementsForCharacterChangeInRange:(NSRange)changedRange
{
    NSRange extendedRange = NSUnionRange(changedRange, [[_backingStore string] lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[_backingStore string] lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    
    [self applyTokenAttributesToRange:extendedRange];
}

-(void)processEditing
{
    if(_dynamicTextNeedsUpdate)
    {
        _dynamicTextNeedsUpdate = NO;
        [self performReplacementsForCharacterChangeInRange:[self editedRange]];
    }
    [super processEditing];
}

- (void)applyTokenAttributesToRange:(NSRange)searchRange
{
    NSDictionary *defaultAttributes = [self.tokens objectForKey:TKDDefaultTokenName];
    
    [[_backingStore string] enumerateSubstringsInRange:searchRange options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        NSDictionary *attributesForToken = [self.tokens objectForKey:substring];
        if(!attributesForToken)
            attributesForToken = defaultAttributes;
        
        if(attributesForToken)
            [self addAttributes:attributesForToken range:substringRange];
    }];
}
@end
