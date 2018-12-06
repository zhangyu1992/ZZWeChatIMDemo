//
//  ZZFMDBTool.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZFMDBTool.h"
#import "FMDatabase.h"
@interface ZZFMDBTool (){
    FMDatabase * _db;// 数据库对象
    int mark_student;
}
@property (nonatomic, copy) NSString * documentPath;// 沙盒路径
@property (nonatomic, copy) NSString * fileName;
@end
@implementation ZZFMDBTool

#pragma mark -- 1.打开数据库
- (BOOL)openDataBaseWithFileName:(NSString *)fileName{
    self.fileName = fileName;
    // 获取数据库
    _db = [FMDatabase databaseWithPath:self.fileName];
    if ([_db open]) {
        NSLog(@"数据库打开成功");
        
        return YES;
    }
    NSLog(@"数据库打开失败");
    return NO;
}
#pragma mark -- 判断表是否存在
- (BOOL)isTableExist:(NSString *)tableName{
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        if (count == 1)
        {
            return YES;
        }
        
    }
    
    return NO;
}
#pragma mark -- 2.创建表
- (BOOL)creatTablesWithTableName:(NSString * )tableName andElementArray:(NSArray *)elementArray{

    NSMutableArray * elementStrArray = [[NSMutableArray alloc]init];
    for (NSString * ele in elementArray) {
        [elementStrArray addObject:[NSString stringWithFormat:@"%@ text NOT NULL",ele]];
    }
    
    NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, %@);",tableName,[elementStrArray componentsJoinedByString:@","]];
    
    BOOL result = [_db executeUpdate:sql];
    if (result) {
        NSLog(@"创建表成功");
        return YES;
    }
    NSLog(@"创建表失败");
    return NO;
    
    
   
    
}

#pragma mark -- 3.添加数据
- (BOOL)addDataToTable:(NSString *)tableName With:(NSDictionary *)params{

    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    NSMutableArray * wenhaoArray = [[NSMutableArray alloc]init];
    NSMutableArray * keysArray = [[NSMutableArray alloc]init];
    NSMutableArray * valuesArray = [[NSMutableArray alloc]init];

    for (NSString * key in params.allKeys) {
        [wenhaoArray addObject:@"?"];
        [keysArray addObject:key];
        [valuesArray addObject:params[key]];
        
    }
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);",tableName,[keysArray componentsJoinedByString:@","],[wenhaoArray componentsJoinedByString:@","]];
    // @"INSERT INTO t_student (name, age, sex) VALUES (?,?,?) name,@(age),sex"
//    BOOL result = [_db executeUpdate:sql];
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
    //    BOOL result = [_db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
    //3.参数是数组的使用方式
    BOOL result = [_db executeUpdate:sql withArgumentsInArray:valuesArray];//@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);"
    if (result) {
        NSLog(@"插入成功");
        return YES;
    }
    NSLog(@"插入失败");

    return NO;
}
#pragma mark -- 4.删除数据
- (BOOL)deleteDataWithTable:(NSString *)tableName andWeChatID:(NSString *)wechat_id{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where wechat_id = ?",tableName];
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）@"delete from t_student where id = ?
    BOOL result = [_db executeUpdate:sql,wechat_id];
    //2.不确定的参数用%@，%d等来占位
//    BOOL result = [_db executeUpdateWithFormat:sql,wechat_id];
    if (result) {
        NSLog(@"删除成功");
        return YES;
    }
    NSLog(@"删除失败");
    return NO;
}
#pragma mark -- 5.修改数据
- (BOOL)reviseDataWithTable:(NSString *)tableName WeChatId:(NSString *)wechat_id andReviseKey:(NSString *)reviseKey ReviseValue:(NSString *)reviseValue{
    // @"update t_student set name = ? where name = ?"
    NSString * sql = [NSString stringWithFormat:@"update %@ set %@ = ? where wechat_id = ?",tableName,reviseKey];

    BOOL result = [_db executeUpdate:sql,reviseValue,wechat_id];
    if (result) {
        NSLog(@"修改成功");
        return YES;
    }
    NSLog(@"修改失败");
    return NO;
}
#pragma mark -- 6.查询数据
- (NSMutableArray *)inquireALLDataWithTable:(NSString *)tableName andKeysArray:(NSArray *)keysArray{
    //查询整个表
    NSString * sql = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet * resultSet = [_db executeQuery:sql];
    //根据条件查询
    //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    //遍历结果集合
    while ([resultSet next]) {
        NSMutableDictionary * keysDict = [[NSMutableDictionary alloc]init];
        for (NSString * key in keysArray) {
            [keysDict gmSetObject:[resultSet objectForColumn:key] forKey:key];
        }
        [dataArray addObject:keysDict];
    }
    return [dataArray mutableCopy];
}
#pragma mark -- 7.删除表
- (BOOL)deleteTable:(NSString *)tableName{
    //如果表格存在 则销毁
    NSString * sql = [NSString stringWithFormat:@"drop table if exists %@",tableName];

    BOOL result = [_db executeUpdate:sql];
    if (result) {
        NSLog(@"删除表成功");
        return YES;
    }
    NSLog(@"删除表失败");

    return NO;
}
- (void)setFileName:(NSString *)fileName{
    
    _fileName = [NSString stringWithFormat:@"%@/%@",self.documentPath,fileName];
}
- (NSString *)documentPath{
    if (_documentPath == nil) {
        _documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];;
    }
    return _documentPath;
}

static ZZFMDBTool* _instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [ZZFMDBTool shareInstance] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [ZZFMDBTool shareInstance] ;
}


@end
