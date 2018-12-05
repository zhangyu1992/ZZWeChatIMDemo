//
//  ZZBaseViewController.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseViewController.h"

@interface ZZBaseViewController ()

@end

@implementation ZZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZZ_MainVC_BackGroundColor;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)creatNavBarViewWithTitle:(id)title{
    if (self.navBarView == nil) {
        self.navBarView = [[ZZBaseNavigationBarView alloc]initWithTitle:title];
        [self.view addSubview:self.navBarView];
    }else{
        [self.navBarView setNavTitleLabel:title];
    }
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
