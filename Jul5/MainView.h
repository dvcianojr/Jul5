//
//  MainView.h
//  Jul5
//
//  Created by Dominick Ciano on 7/4/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface MainView: UIView {
	//holds the two subviews we transtion between
	NSArray *views;
	
	//index in views of the currently displayed little view: 0 or 1 or 2
	NSUInteger index;
	
	UILabel *heading;
	UILabel *caption;
	UIButton *prevButton;
	UIButton *nextButton;
	NSString *soundPath;
	SystemSoundID clickButtonSoundID;
	NSDictionary *photos;
	
}
@end
