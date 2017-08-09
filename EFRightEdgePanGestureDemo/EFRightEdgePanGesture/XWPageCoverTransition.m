//
//  XWPageCoverTransition.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWPageCoverTransition.h"
#import "UIView+FrameChange.h"

@interface XWPageCoverTransition ()
@property (nonatomic, assign, getter=isPopInitialized) BOOL popInitialized;
@end

@implementation XWPageCoverTransition

+ (instancetype)transitionWithType:(XWPageCoverTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XWPageCoverTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.30;
}
/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case XWPageCoverTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;

        case XWPageCoverTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // 对 tempView 做动画，避免 bug
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    fromVC.view.hidden = YES;

    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transfrom3d;

    toVC.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    toVC.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    toVC.view.layer.shadowRadius = 6.0;
    toVC.view.layer.shadowOpacity = 0.24;
    toVC.view.layer.masksToBounds = NO;
    
    toVC.view.layer.transform = CATransform3DMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0, 0);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        tempView.layer.transform = CATransform3DMakeTranslation([UIScreen mainScreen].bounds.size.width/3.0, 0, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}

/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    // UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    UIView *tempToView = containerView.subviews.firstObject;
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];

    tempView.layer.shadowColor = [[UIColor blackColor] CGColor];
    tempView.layer.shadowOffset = CGSizeMake(0, 0);
    tempView.layer.shadowRadius = 6.0;
    tempView.layer.shadowOpacity = 0.24;
    tempView.layer.masksToBounds = NO;

    tempToView.layer.transform = CATransform3DMakeTranslation([UIScreen mainScreen].bounds.size.width/3.0, 0, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempToView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        tempView.layer.transform = CATransform3DMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempToView removeFromSuperview];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        }
    }];
}

@end
