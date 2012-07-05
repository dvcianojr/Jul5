//
//  PicView1.m
//  Jul5
//
//  Created by Dominick Ciano on 7/4/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "PicView1.h"

@implementation PicView1

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		UIImage *image = [UIImage imageNamed: @"Kim.jpg"];
		if (image == nil) {
			NSLog(@"could not create image");
			return nil;
		}
		view = [[UIImageView alloc] initWithImage: image];
		
		//Keep the UIImageView the same size,
		//but center it in the View.
		
		CGRect b = self.bounds;
		
		view.center = CGPointMake(
								  b.origin.x + b.size.width / 2,
								  b.origin.y + b.size.height/ 2 + 75
								  );
		
		view.transform = CGAffineTransformMakeScale(
													self.bounds.size.width / 400,
													self.bounds.size.height / 300
													);	
		[self addSubview: view];
	}
	return self;

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
 - (void) drawRect: (CGRect) rect
 {
 // Drawing code
 }
 */
@end

