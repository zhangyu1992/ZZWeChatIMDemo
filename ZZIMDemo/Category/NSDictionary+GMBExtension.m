//
//  NSDictionary+Extension.m
//  GomeEShop
//
//  Created by 苏循波 on 15/6/15.
//  Copyright (c) 2015年 Gome. All rights reserved.
//

#import "NSDictionary+GMBExtension.h"

#define GMK_Str_Protect(str) ((str) ? (str) : (@""))
#pragma mark - ************************************ NSDictionary ***********************************

@implementation NSDictionary (GMBExtension)


/// 重写objectForKey，获取String类型值为nil时，加保护为@""
- (NSString *)gmObjectStrForKey:(NSString *)key
{
    NSString *str = [self objectForKey:key];
    
    /// 对为nil时加入保护
    return GMK_Str_Protect(str);
}


@end


#pragma mark - ********************************* NSMutableDictionary *******************************

@implementation NSMutableDictionary (GMBExtension)


/// 重写setObject:forKey，设置值为nil时，不做任何处理
- (void)gmSetObject:(id)value forKey:(NSString *)key
{
    if (value)
    {
        [self setObject:value forKey:key];
    }
    else
    {
#ifdef DEBUG
        /// 测试模式下，不做任何处理，就是让系统Crash，便于跟踪
//        [self setObject:value forKey:key];
#else
        /// 正式模式下，不做设置处理
#endif
    }
}


@end
