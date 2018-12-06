//
//  ZZBaseViewController.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZBaseNavigationBarView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseViewController : UIViewController
@property (nonatomic, strong) ZZBaseNavigationBarView * navBarView;
- (void)creatNavBarViewWithTitle:(id)title;
@property (nonatomic, strong) UIView * backView;
@end

NS_ASSUME_NONNULL_END
