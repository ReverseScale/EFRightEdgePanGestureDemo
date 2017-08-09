//
//  XWPageCoverController.h
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWInteractiveTransition.h"
#import "XWPageCoverPushController.h"

@interface XWPageCoverController : UIViewController<XWPageCoverPushControllerDelegate>

- (void)pushConfig:(GestureConifg)config;

@end
