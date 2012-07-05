//
//  Jul5AppDelegate.h
//  Jul5
//
//  Created by Dominick Ciano on 6/29/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>  //needed for AVAudioPlayer

@class MainView;

@interface Jul5AppDelegate: UIResponder <UIApplicationDelegate> {
	MainView *mainView;
	UIWindow *_window;
	AVAudioPlayer *player;
}

@property (strong, nonatomic) UIWindow *window;
@end