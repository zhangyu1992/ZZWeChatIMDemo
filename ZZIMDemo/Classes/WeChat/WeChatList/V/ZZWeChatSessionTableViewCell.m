//
//  ZZWeChatSessionTableViewCell.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionTableViewCell.h"


@interface ZZWeChatSessionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * lastTextLabel;
@property (nonatomic, weak) IBOutlet UILabel * lastTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView * disturbImageView;

@end
@implementation ZZWeChatSessionTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setWechatModel:(ZZWeChatModel *)wechatModel{
    self.nameLabel.text = wechatModel.wechat_name;
    self.lastTextLabel.text = wechatModel.lastText;
    self.lastTimeLabel.text = wechatModel.lastTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
