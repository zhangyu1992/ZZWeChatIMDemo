//
//  ZZBaseNavigationBarView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseNavigationBarView.h"
@interface ZZBaseNavigationBarView()
// 标题
@property (nonatomic, strong) UILabel * titleLabel;
// 左侧按钮
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UILabel * LeftLabel;

@end
@implementation ZZBaseNavigationBarView
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ZZScreenWidth, ZZ_Navigation_Height);
        self.backgroundColor = ZZ_Navigation_DefalutColor;
    }
    return self;
}
// chuang
- (void)createLeftButtonWithTitle:(NSString *)strTitle action:(SEL)selAction target:(id)target{
    if (!_leftButton)
    {
        _leftButton = [[UIButton alloc]init];
        _leftButton.tag = 10001;
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        _leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_leftButton setTitleColor:ZZ_NavBar_TitleColor forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"jiantou" ] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(ZZ_StatesBar_Height + 5);

        }];
    }
    [_leftButton addTarget:target action:selAction forControlEvents:UIControlEventTouchUpInside];
    
    if (strTitle && ![strTitle isEqualToString:@""]){
        self.LeftLabel.text = strTitle;
    }
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
- (void)setNavLeftLabel:(NSString *)title{
    self.LeftLabel.text = title;
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
- (UILabel *)LeftLabel{
    if (_LeftLabel == nil) {
        _LeftLabel = [[UILabel alloc]init];
        _LeftLabel.backgroundColor = [UIColor clearColor];
        _LeftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _LeftLabel.textAlignment = NSTextAlignmentCenter;
        _LeftLabel.textColor = ZZ_NavBar_TitleColor;
        
        [self addSubview:_LeftLabel];
        [_LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
            make.left.equalTo(self.mas_left).offset(30);
            make.top.equalTo(self.mas_top).offset(ZZ_StatesBar_Height + 5);
            
        }];
    }
    return _LeftLabel;
}

@end
