//
//  MainView.m
//  Jul5
//
//  Created by Dominick Ciano on 7/4/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "MainView.h"
#import "PicView0.h"
#import "PicView1.h"
#import "PicView2.h"

@implementation MainView

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		photos = [NSDictionary dictionaryWithObjectsAndKeys:
				  @"                  Mike.jpg                 ", @"p1",
				  @"                   Kim.jpg                 ", @"p2",
				  @"               MikeAndKim.jpg              ", @"p3",
				  nil
				  ];
		
		//Don't bother with a background color--
		//this MainView is entirely occupied by a PicView.
		
		
		CGRect f = CGRectMake(
							  self.bounds.origin.x + 20,
							  self.bounds.origin.y + 40,
							  self.bounds.size.width - 40,
							  190//self.bounds.size.height - 100
							  );	
		views = [NSArray arrayWithObjects:
				 
				 [[PicView0 alloc] initWithFrame: f],
				 [[PicView1 alloc] initWithFrame: f],
				 [[PicView2 alloc] initWithFrame: f],
				 nil
				 ];
		
		index = 0;	//PicView0 is the one that's initially visible.
		[self addSubview: [views objectAtIndex: index]];
		
		//create heading
		
		NSString *sHeading = @"Wedding Book";
		UIFont *hdgFont = [UIFont fontWithName: @"Arial-BoldMT" size: 16];
		CGSize hdgSize = [sHeading sizeWithFont: hdgFont];
		
        // set up heading
		CGRect f2 = CGRectMake(
							   self.bounds.origin.x + (self.bounds.size.width - hdgSize.width)/2,
							   self.bounds.origin.y,
							   hdgSize.width,
							   hdgSize.height + 10
							   );
		
		heading = [[UILabel alloc] initWithFrame: f2];
		heading.textColor = [UIColor whiteColor];
		heading.backgroundColor = [UIColor blackColor];
		heading.font = hdgFont;
		heading.text = sHeading;
		[self addSubview: heading];				
		
		
		
		
		
		
		
		
		
		//create caption
		NSString *key = @"p1";
		NSString *sLabel = [photos objectForKey: key];
		UIFont *font = [UIFont fontWithName: @"Courier-Bold" size: 12];
		CGSize size = [sLabel sizeWithFont: font];
		
        // set up photo caption
		CGRect f3 = CGRectMake(
							   self.bounds.origin.x,
							   self.bounds.origin.y+400,
							   size.width +150,
							   size.height
							   );
		
		caption = [[UILabel alloc] initWithFrame: f3];
		caption.textColor = [UIColor whiteColor];
		caption.backgroundColor = [UIColor blackColor];
		caption.font = font;
		caption.text = sLabel;
		[self addSubview: caption];		
		
		
		//create 'Previous' button
		prevButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		prevButton.backgroundColor = [UIColor redColor];
		
		//set the position of the button
		prevButton.frame = CGRectMake(0, 430,160, 30);
		
		//set the button's title
		[prevButton setTitle:@"Previous" forState:UIControlStateNormal];
		
		//listen for clicks
		[prevButton addTarget:self action:@selector(prevPressed) 
			 forControlEvents:UIControlEventTouchUpInside];
		
		//create 'Next' button
		nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		nextButton.backgroundColor = [UIColor redColor];
		
		//set the position of karaoke button
		nextButton.frame = CGRectMake(160, 430,160, 30);
		
		//set the button's title
		[nextButton setTitle:@"Next" forState:UIControlStateNormal];
		
		//listen for clicks
		[nextButton addTarget:self action:@selector(nextPressed) 
			 forControlEvents:UIControlEventTouchUpInside];
		
		//set enabled and title color		
		
		[prevButton setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
		prevButton.enabled = NO;		
		
		[nextButton setTitleColor: [UIColor blueColor]forState:UIControlStateNormal];
		prevButton.enabled = NO;		
		
		
		//add buttons to view	
		[self addSubview:prevButton];
		[self addSubview:nextButton];	
		
		UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]
												initWithTarget: self action: @selector(swipe:)
												];
		recognizer.direction = UISwipeGestureRecognizerDirectionRight;
		[self addGestureRecognizer: recognizer];
		
		recognizer = [[UISwipeGestureRecognizer alloc]
					  initWithTarget: self action: @selector(swipe:)
					  ];
		recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
		[self addGestureRecognizer: recognizer];
		
		
		//load click.wav
		soundPath = [[NSBundle mainBundle] pathForResource:@"ButtonClick" ofType:@"wav"];			
		AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &clickButtonSoundID);
		
		
		
		//[soundPath release]; 
		
		
	}
	return self;
}


- (void) swipe: (UISwipeGestureRecognizer *) recognizer {
	
	NSUInteger newIndex;
	if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
		if (index == 0)
			newIndex = 0; //dead end
		else
		{
		    newIndex = index - 1; 
			[UIView transitionFromView: [views objectAtIndex: index]
								toView: [views objectAtIndex: newIndex]
							  duration: 2.25
							   options: UIViewAnimationOptionTransitionCurlDown
							completion: NULL
			 ];
		}
		index = newIndex;
		
		if (index == 0){
			[prevButton setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
			prevButton.enabled = NO;
		}
		else if (index < 2){
			[nextButton setTitleColor: [UIColor blueColor]forState:UIControlStateNormal];
			nextButton.enabled = YES;	
		}
		
	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
		if (index < 2){
			newIndex = (index + 1) % 3;	//toggle the index
			[UIView transitionFromView: [views objectAtIndex: index]
								toView: [views objectAtIndex: newIndex]
							  duration: 2.25
							   options: UIViewAnimationOptionTransitionCurlUp
							completion: NULL
			 ];
		}
		else {
			newIndex = 2; // dead end
			
		}
		
		index = newIndex;
		if (index > 0){
			[prevButton setTitleColor: [UIColor blueColor]forState:UIControlStateNormal];
			prevButton.enabled = YES;
		}
		if (index == 2){
			[nextButton setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
			nextButton.enabled = NO;
		}		
		
	}
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void) drawRect: (CGRect) rect
 {
 // Drawing code
 }
 */


-(void)prevPressed {	
	NSUInteger newIndex;
	
	AudioServicesPlaySystemSound (clickButtonSoundID);
	if (index == 0)
		newIndex = 0; // dead end
	else
		newIndex = index - 1; 
	[UIView transitionFromView: [views objectAtIndex: index]					 	toView: [views objectAtIndex: newIndex]		duration: 2.25
					   options: UIViewAnimationOptionTransitionCurlDown
					completion: NULL
	 ];
	
	index = newIndex;
	
	NSString *key = [NSString stringWithFormat: @"p%d", index + 1];
	NSString *sLabel = [photos objectForKey: key];
	caption.text = sLabel;
	
	
	if (index == 0){
		[prevButton setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
		prevButton.enabled = NO;
	}
	else if (index < 2){
		[nextButton setTitleColor: [UIColor blueColor]forState:UIControlStateNormal];
		nextButton.enabled = YES;	
	}
	
}

-(void)nextPressed {
	NSUInteger newIndex;
	
	AudioServicesPlaySystemSound (clickButtonSoundID);	
	newIndex = (index + 1) % 3;	//toggle the index
	
	[UIView transitionFromView: [views objectAtIndex: index]
						toView: [views objectAtIndex: newIndex]
					  duration: 2.25
					   options: UIViewAnimationOptionTransitionCurlUp
					completion: NULL
	 ];
	
	index = newIndex;	
	
	NSString *key = [NSString stringWithFormat: @"p%d", index + 1];
	NSString *sLabel = [photos objectForKey: key];
	caption.text = sLabel;
	
	if (index > 0){
		[prevButton setTitleColor: [UIColor blueColor]forState:UIControlStateNormal];
		prevButton.enabled = YES;
	}
	if (index == 2){
		[nextButton setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
		nextButton.enabled = NO;
	}
}


@end
