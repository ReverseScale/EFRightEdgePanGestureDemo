//
//  XWPageCoverController.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWPageCoverController.h"
#import "XWPageCoverPushController.h"
#import "XWInteractiveTransition.h"

@interface XWPageCoverController ()<XWPageCoverPushControllerDelegate>

@property (nonatomic, strong) XWInteractiveTransition *interactiveTransitionPush;

@end

@implementation XWPageCoverController

- (void)viewDidLoad {
    [super viewDidLoad];

    _interactiveTransitionPush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePush GestureDirection:XWInteractiveTransitionGestureDirectionRight];
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
    //[_interactiveTransitionPush addPanGestureForViewController:self];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush {
    return _interactiveTransitionPush;
}

-(void)pushConfig:(GestureConifg)config {
    _interactiveTransitionPush.pushConifg = config;
}

@end
