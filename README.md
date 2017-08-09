# EFRightEdgePanGestureDemo
简单设置实现左右 Push，并支持手势

演示效果：

![](http://og1yl0w9z.bkt.clouddn.com/17-8-9/91705068.jpg)

向左推出 简单代码：（向右推出正常）
```Objective-C
    SubViewController *subVC = [SubViewController new];
    self.navigationController.delegate = subVC;
    subVC.delegate = self;
    [self.navigationController pushViewController:subVC animated:YES];
```
