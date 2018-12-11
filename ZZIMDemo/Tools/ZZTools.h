//
//  ZZTools.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZZTools : NSObject

/**
 iPhone X 底部安全距离

 @return iPhone X 底部安全距离
 */
+ (CGFloat)getSafeAreaBottom;

/**
 当前时间 字符串

 @return 返回当前时间 str
 */
+ (NSString *)getNowTimeString;
@end


NS_ASSUME_NONNULL_END
