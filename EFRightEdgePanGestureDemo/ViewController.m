//
//  ViewController.m
//  EFRightEdgePanGestureDemo
//
//  Created by WhatsXie on 2017/8/9.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)leftAction:(id)sender {
    SubViewController *subVC = [SubViewController new];
    self.navigationController.delegate = subVC;
    subVC.delegate = self;
    [self.navigationController pushViewController:subVC animated:YES];
}
- (IBAction)rightAction:(id)sender {
    SubViewController *subVC = [SubViewController new];
    [self.navigationController pushViewController:subVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
