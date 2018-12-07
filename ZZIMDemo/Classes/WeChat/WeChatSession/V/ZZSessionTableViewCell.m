//
//  ZZSessionTableViewCell.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZSessionTableViewCell.h"
@interface ZZSessionTableViewCell()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIImageView * logoImageView;
@property (nonatomic, strong) UILabel * messageTextLabel;
@property (nonatomic, strong) UIImageView * messageImageView;

@property (nonatomic, strong) UILabel * timeTextLabel;

@end
@implementation ZZSessionTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUIWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}
- (void)setSessionModel:(ZZSessionModel *)sessionModel{
    self.messageTextLabel.text = sessionModel.messageText;
}
- (void)creatUIWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_greaterThanOrEqualTo(40);
        make.bottom.equalTo(self.contentView.mas_bottom);

    }];
    
    if ([reuseIdentifier hasSuffix:@"isMySelf"]) {
        // 右边
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView.mas_right);
            make.top.equalTo(self.bgView.mas_top);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        self.logoImageView.image = [UIImage imageNamed:@"touxiangnvhai"];


        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.logoImageView.mas_left).offset(-10);
            make.top.equalTo(self.bgView.mas_top).offset(5);
            make.bottom.equalTo(self.bgView.mas_bottom);
            make.left.equalTo(self.messageTextLabel.mas_left).offset(-5);
        }];
        UIImage *senderImage =
        [[UIImage imageNamed:@"chat_bg_sender"] stretchableImageWithLeftCapWidth:/*21*/13.0
                                                                    topCapHeight:/*14*/11.0];
        self.messageImageView.image = senderImage;
        
        [self.messageTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.logoImageView.mas_left).offset(-25);
            make.top.equalTo(self.bgView.mas_top).offset(10);
            make.height.greaterThanOrEqualTo(@(50));
            make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
            make.width.mas_lessThanOrEqualTo(0.5 * ZZScreenWidth);
        }];
        self.messageTextLabel.textAlignment = NSTextAlignmentRight;

        
    }else if ([reuseIdentifier hasSuffix:@"time"]){
        // 时间
        [self.timeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top);
            make.bottom.equalTo(self.bgView.mas_bottom);
            make.left.equalTo(self.bgView.mas_left);
            make.right.equalTo(self.bgView.mas_right);
        }];
    }else{
        
        // 左边
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left);
            make.top.equalTo(self.bgView.mas_top);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        self.logoImageView.image = [UIImage imageNamed:@"icon-gray"];

        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView.mas_bottom);
            make.left.equalTo(self.logoImageView.mas_right).offset(10);
            make.top.equalTo(self.bgView.mas_top).offset(5);
            make.right.equalTo(self.messageTextLabel.mas_right).offset(5);
      
        }];
        
        UIImage *receiveImage =
        [[UIImage imageNamed:@"chat_bg_recived"] stretchableImageWithLeftCapWidth:/*21*/13.0
                                                                     topCapHeight:/*14*/11.0];

        self.messageImageView.image = receiveImage;//[UIImage imageNamed:@"chat_bg_recived"];
        
        [self.messageTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
            make.left.equalTo(self.logoImageView.mas_right).offset(25);
            make.top.equalTo(self.bgView.mas_top).offset(10);
            make.height.greaterThanOrEqualTo(@(50));
            make.width.mas_lessThanOrEqualTo(0.5 * ZZScreenWidth);
        }];
        self.messageTextLabel.textAlignment = NSTextAlignmentLeft;

    }
}
-(UILabel *)timeTextLabel{
    if (_timeTextLabel == nil) {
        _timeTextLabel = [[UILabel alloc]init];
        _timeTextLabel.textColor = ZZMainTextColor_Gray;
        _timeTextLabel.font = ZZWeChatContLabelFont;
        _timeTextLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_timeTextLabel];
    }
    return _timeTextLabel;
}
-(UILabel *)messageTextLabel{
    if (_messageTextLabel == nil) {
        _messageTextLabel = [[UILabel alloc]init];
        _messageTextLabel.numberOfLines = 0;
        _messageTextLabel.backgroundColor = [UIColor clearColor];
        _messageTextLabel.textColor = ZZMainTextColor_Balck;
        _messageTextLabel.font = ZZWeChatContLabelFont;
        _messageTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_messageTextLabel];
    }
    return _messageTextLabel;
}
-(UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.layer.cornerRadius = 10;
        [self.bgView addSubview:_logoImageView];
    }
    return _logoImageView;
}
-(UIImageView *)messageImageView{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc]init];
        [self.bgView addSubview:_messageImageView];
    }
    return _messageImageView;
}
-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
