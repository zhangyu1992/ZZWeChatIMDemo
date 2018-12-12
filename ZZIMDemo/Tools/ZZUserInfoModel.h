//
//  ZZUserInfoModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/12.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZUserInfoModel : ZZBaseModel
+(instancetype)shareInstance;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userImageName;

@end

NS_ASSUME_NONNULL_END
