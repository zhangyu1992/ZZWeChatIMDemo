//
//  ZZBaseNavigationBarView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseNavigationBarView.h"
@interface ZZBaseNavigationBarView()
@property (nonatomic, strong) UILabel * titleLabel;

@end
@implementation ZZBaseNavigationBarView
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ZZScreenWidth, ZZ_Navigation_Height);
        self.backgroundColor = ZZ_Navigation_DefalutColor;
    }
    return self;
}
- (id)initWithTitle:(NSString *)titleStr{
    if (self = [self init]) {

        [self setNavTitleLabel:titleStr];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(ZZ_StatesBar_Height);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(ZZScreenWidth * 0.5);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}
- (void)setNavTitleLabel:(NSString *)title{
    self.titleLabel.text = title;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = ZZ_NavBar_TitleColor;
    }
    return _titleLabel;
}

@end
