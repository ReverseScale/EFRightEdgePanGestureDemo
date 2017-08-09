//
//  XWInteractiveTransition.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWInteractiveTransition.h"

@interface XWInteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;
/**手势方向*/
@property (nonatomic, assign) XWInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) XWInteractiveTransitionType type;

@end

@implementation XWInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    self.completionCurve = UIViewAnimationCurveLinear;
    [viewController.view addGestureRecognizer:pan];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    //边缘检测
    BOOL isEdge = NO;
    CGFloat tempWidth = 1;

    switch (_direction) {
        case XWInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;

            tempWidth = panGesture.view.frame.size.width;
            isEdge = (tempWidth - [panGesture locationInView:panGesture.view].x) / tempWidth < (1 / 10.0);
        }
            break;
        case XWInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;

            tempWidth = panGesture.view.frame.size.width;
            isEdge = [panGesture locationInView:panGesture.view].x / tempWidth < (1 / 10.0);
        }
            break;
        case XWInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case XWInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    persent = (0.88 * persent + 0.06) * 0.89;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            if (isEdge == YES) {
                //手势开始的时候标记手势状态，并开始相应的事件
                self.interation = YES;
                [self startGesture];
            }
            break;
        case UIGestureRecognizerStateChanged:{
            if (YES == self.interation) {
                //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
                [self updateInteractiveTransition:persent];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            if (YES == self.interation) {
                //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
                self.interation = NO;
                CGFloat velocity = _direction == XWInteractiveTransitionGestureDirectionLeft ? (-[panGesture velocityInView:panGesture.view].x) : [panGesture velocityInView:panGesture.view].x;
                if (persent > 0.5 || velocity > 1000) {
                    [self finishInteractiveTransition];
                }else{
                    [self cancelInteractiveTransition];
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case XWInteractiveTransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;

        case XWInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case XWInteractiveTransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case XWInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}

@end
