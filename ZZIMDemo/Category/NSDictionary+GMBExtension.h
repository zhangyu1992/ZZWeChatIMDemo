//
//  NSDictionary+Extension.h
//  GomeEShop
//
//  Created by 苏循波 on 15/6/15.
//  Copyright (c) 2015年 Gome. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 是否NSDictionary类型（单独处理NSMutableDictionary）
#define GMK_Dic_Class(dic) [dic isKindOfClass:[NSDictionary class]]
#define GMK_mDic_Class(mdic) [mdic isKindOfClass:[NSMutableDictionary class]]

/// 是否有效，不为空，且是NSDictionary类型，且count值大于0（单独处理NSMutableDictionary）
#define GMK_Dic_Is_Valid(dic) ((dic) && (GMK_Dic_Class(dic)) && (dic.count > 0))
#define GMK_mDic_Is_Valid(mdic) ((mdic) && (GMK_mDic_Class(mdic)) && (mdic.count > 0))

/// 是否无效，或为空，或不是NSDictionary类型，或count值小于等于0（单独处理NSMutableDictionary）
#define GMK_Dic_Not_Valid(dic) ((!dic) || (!GMK_Dic_Class(dic)) || (dic.count <= 0))
#define GMK_mDic_Not_Valid(mdic) ((!mdic) || (!GMK_mDic_Class(mdic)) || (mdic.count <= 0))


#pragma mark - ************************************ NSDictionary ***********************************

/*!
 *  @author  苏循波,15-06-15 16:30:40
 *
 *  @brief  NSDictionary类别 基本方法
 */
@interface NSDictionary (GMBExtension)


/// 重写objectForKey，获取String类型值为nil时，加保护为@""
- (NSString *)gmObjectStrForKey:(NSString *)key;


@end


#pragma mark - ********************************* NSMutableDictionary *******************************

@interface NSMutableDictionary (GMBExtension)


/// 重写setObject:forKey，设置值为nil时，不做任何处理
- (void)gmSetObject:(id)value forKey:(NSString *)key;


@end
