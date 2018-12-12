//
//  ZZWeChatModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZWeChatModel : ZZBaseModel
@property (nonatomic,copy) NSString * wechat_id;
@property (nonatomic,copy) NSString * wechat_name;
@property (nonatomic,copy) NSString * receive_id;// 接收人ID
@property (nonatomic,copy) NSString * lastText;
@property (nonatomic,copy) NSString * lastTime;
@end

NS_ASSUME_NONNULL_END
