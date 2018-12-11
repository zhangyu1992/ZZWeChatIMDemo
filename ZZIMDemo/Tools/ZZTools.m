//
//  ZZTools.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZTools.h"

@implementation ZZTools
#pragma mark -- iPhone X 底部安全距离
+ (CGFloat)getSafeAreaBottom {
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
        return insets.bottom;
    } else {
        return 0;
    }
}
#pragma mark -- 返回当前时间
+ (NSString *)getNowTimeString{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter  alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:SS"];
    NSString * time = [formatter stringFromDate:date];
    return time;
    
}
@end
