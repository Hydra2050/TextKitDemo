//
//  OutliningLayoutManager.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-16.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "OutliningLayoutManager.h"

@implementation OutliningLayoutManager

//重写drawUnderline方法，实现绘制边框的效果
- (void)drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin
{
	// Left border (== position) of first underlined glyph
	CGFloat firstPosition = [self locationForGlyphAtIndex: glyphRange.location].x;
	
	// Right border (== position + width) of last underlined glyph
	CGFloat lastPosition;
	
	// When link is not the last text in line, just use the location of the next glyph
	if (NSMaxRange(glyphRange) < NSMaxRange(lineGlyphRange)) {
		lastPosition = [self locationForGlyphAtIndex: NSMaxRange(glyphRange)].x;
	}
	// Otherwise get the end of the actually used rect
	else {
		lastPosition = [self lineFragmentUsedRectForGlyphAtIndex:NSMaxRange(glyphRange)-1 effectiveRange:NULL].size.width;
	}
	
	// Inset line fragment to underlined area
	lineRect.origin.x += firstPosition;
	lineRect.size.width = lastPosition - firstPosition;
	
	// Offset line by container origin
	lineRect.origin.x += containerOrigin.x;
	lineRect.origin.y += containerOrigin.y;
	
	// Align line to pixel boundaries, passed rects may be
	lineRect = CGRectInset(CGRectIntegral(lineRect), .5, .5);
	
	[[UIColor greenColor] set];
	[[UIBezierPath bezierPathWithRect: lineRect] stroke];
}

@end
