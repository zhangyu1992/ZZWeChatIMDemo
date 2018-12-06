//
//  ZZWeChatModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ZZWeChatModel : NSObject
@property (nonatomic,copy) NSString * wechat_id;
@property (nonatomic,copy) NSString * wechat_name;
@property (nonatomic,copy) NSString * lastText;
@property (nonatomic,copy) NSString * lastTime;
- (instancetype)initWithDefalutData;
@end

NS_ASSUME_NONNULL_END
