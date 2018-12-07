//
//  ZZSessionModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZSessionModel : ZZBaseModel
@property (nonatomic, copy) NSString * messageText;
@property (nonatomic, copy) NSString * sendTime;
@property (nonatomic, copy) NSString * sendName;
@property (nonatomic, copy) NSString * sendID;
@property (nonatomic, copy) NSString * isMySelf;// 1：是 0：不是
@end

NS_ASSUME_NONNULL_END
