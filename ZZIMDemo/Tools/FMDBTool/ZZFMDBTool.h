//
//  ZZFMDBTool.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZFMDBTool : NSObject
+ (instancetype)shareInstance;

/**
 打开数据库

 @param fileName 数据库名称
 @return bool
 */
- (BOOL)openDataBaseWithFileName:(NSString *)fileName;

/**
 判断表是否存在

 @param tableName 表名
 @return BOOL
 */
- (BOOL)isTableExist:(NSString *)tableName;

/**
 创建表

 @param tableName 表名
 @param elementArray 表中的元素
 @return BOOL
 */
- (BOOL)creatTablesWithTableName:(NSString * )tableName andElementArray:(NSArray *)elementArray;

/**
 向表中 添加内容

 @param tableName 表名
 @param params 内容字典
 @return BOOL
 */
- (BOOL)addDataToTable:(NSString *)tableName WithContentDict:(NSDictionary *)params;

/**
 删除表中的一条信息

 @param tableName 表名
 @param wechat_id 查找条件
 @return BOOL
 */
- (BOOL)deleteDataWithTable:(NSString *)tableName andWeChatID:(NSString *)wechat_id;

/**
 修改表中的内容

 @param tableName 表名
 @param wechat_id 要修改那条信息 查找id
 @param reviseKey 要修改的key
 @param reviseValue 修改后的内容
 @return BOOL
 */
- (BOOL)reviseDataWithTable:(NSString *)tableName WeChatId:(NSString *)wechat_id andReviseKey:(NSString *)reviseKey ReviseValue:(NSString *)reviseValue;

/**
 查询表中的内容

 @param tableName 表名
 @param keysArray 要查找内容的key
 @return 字典数组
 */
- (NSMutableArray *)inquireALLDataWithTable:(NSString *)tableName andKeysArray:(NSArray *)keysArray;

/**
 删除表

 @param tableName 表名
 @return BOOL
 */
- (BOOL)deleteTable:(NSString *)tableName;
@end

NS_ASSUME_NONNULL_END
