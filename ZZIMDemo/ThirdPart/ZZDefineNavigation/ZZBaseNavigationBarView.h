//
//  ZZBaseNavigationBarView.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseNavigationBarView : UIView
- (id)initWithTitle:(NSString *)titleStr;
- (void)setNavTitleLabel:(NSString *)title;
- (void)createLeftButtonWithTitle:(NSString *)strTitle action:(SEL)selAction target:(id)target;
@end

NS_ASSUME_NONNULL_END
