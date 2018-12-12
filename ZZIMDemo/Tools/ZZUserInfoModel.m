//
//  ZZUserInfoModel.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/12.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZUserInfoModel.h"

@implementation ZZUserInfoModel
+(instancetype)shareInstance{
    static ZZUserInfoModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (model == nil) {
            model = [[ZZUserInfoModel alloc]init];
        }
    });
    return model;
}
@end
