//
//  ZZWeChatSessionViewModel.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionViewModel.h"
#import "ZZSessionModel.h"
@implementation ZZWeChatSessionViewModel
// 取数据库 数据
- (NSMutableArray *)getModelDataArrayFromLoaclTable{
    NSMutableArray * modelArray = [[NSMutableArray alloc]init];
    
    if (![self openDB]) {
        return modelArray;
    }
    if (![self isTableExist]) {
        return modelArray;
    }
    ZZSessionModel * wechatModel = [[ZZSessionModel alloc]initWithDefalutData];
    NSDictionary * modelDict = wechatModel.mj_keyValues;
    
    NSMutableArray * dataArray = [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatSessionTable andKeysArray:modelDict.allKeys];
    
    for (NSDictionary * dict in dataArray) {
        ZZSessionModel * model = [ZZSessionModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    // 添加
//    [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatSessionTable WithContentDict:@{@"sendID":@"3",@"sendName":@"zhangzhang",@"messageText":@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",@"sendTime":@"2018-12-06 13:47:00",@"isMySelf":@"0"}];
    
    return modelArray;
}
#pragma mark 打开数据库
- (BOOL)openDB{
    return [[ZZFMDBTool shareInstance] openDataBaseWithFileName:ZZSQL_WECHATLIST];
}
#pragma mark -- 创建表
- (BOOL)isTableExist{
    // 判断 y表存在
    if (![[ZZFMDBTool shareInstance] isTableExist:ZZSQL_TABLE_WeChatSessionTable]) {
        // 创建
        ZZSessionModel * wechatModel = [[ZZSessionModel alloc]initWithDefalutData];
        NSDictionary * modelDict = wechatModel.mj_keyValues;
        return [[ZZFMDBTool shareInstance] creatTablesWithTableName:ZZSQL_TABLE_WeChatSessionTable andElementArray:modelDict.allKeys];
    }
    return YES;
}

- (void)test{
    // 添加
    [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatSessionTable WithContentDict:@{@"sendID":@"3",@"sendName":@"zhangzhang",@"messageText":@"哈哈",@"sendTime":@"2018-12-06 13:47:00",@"isMySelf":@"1"}];
    // 删除
    [[ZZFMDBTool shareInstance] deleteDataWithTable:ZZSQL_TABLE_WeChatSessionTable andWeChatID:@"1"];
    // 修改
    [[ZZFMDBTool shareInstance] reviseDataWithTable:ZZSQL_TABLE_WeChatSessionTable WeChatId:@"2" andReviseKey:@"lastText" ReviseValue:@"最后的话"];
    // 查找
    [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatSessionTable andKeysArray:@[@"wechat_id",@"wechat_name",@"lastText",@"lastTime"]];
    // 删表
    [[ZZFMDBTool shareInstance]deleteTable:ZZSQL_TABLE_WeChatSessionTable];
}
@end
