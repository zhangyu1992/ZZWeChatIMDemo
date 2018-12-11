//
//  ZZWeChatViewModel.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatViewModel.h"

@implementation ZZWeChatViewModel
- (ZZWeChatSessionViewController * )pushSessionViewControllerWithWeChatModel:(ZZWeChatModel *)wechatModel{
    
    ZZWeChatSessionViewController * sessionVC = [[ZZWeChatSessionViewController alloc]init];
    sessionVC.listWeChatModel = wechatModel;
    return sessionVC;
}
// 取数据库 数据
- (NSMutableArray *)getModelDataArrayFromLoaclTable{
    NSMutableArray * modelArray = [[NSMutableArray alloc]init];

    if (![self openDB]) {
        return modelArray;
    }
    if (![self isTableExist]) {
        return modelArray;
    }
    ZZWeChatModel * wechatModel = [[ZZWeChatModel alloc]initWithDefalutData];
    NSDictionary * modelDict = wechatModel.mj_keyValues;
    
    NSMutableArray * dataArray = [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatListTable andKeysArray:modelDict.allKeys];
    
    for (NSDictionary * dict in dataArray) {
        ZZWeChatModel * model = [ZZWeChatModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    [self test];
    return modelArray;
}
#pragma mark 打开数据库
- (BOOL)openDB{
   return [[ZZFMDBTool shareInstance] openDataBaseWithFileName:ZZSQL_WECHATLIST];
}
#pragma mark -- 创建表
- (BOOL)isTableExist{
    // 判断 y表存在
    if (![[ZZFMDBTool shareInstance] isTableExist:ZZSQL_TABLE_WeChatListTable]) {
        // 创建
        ZZWeChatModel * wechatModel = [[ZZWeChatModel alloc]initWithDefalutData];
        NSDictionary * modelDict = wechatModel.mj_keyValues;
        return [[ZZFMDBTool shareInstance] creatTablesWithTableName:ZZSQL_TABLE_WeChatListTable andElementArray:modelDict.allKeys];
    }
    return YES;
}

- (void)test{
    // 添加
//    [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatListTable WithContentDict:@{@"wechat_id":@"2",@"wechat_name":@"zhangzhang",@"lastText":@"哈哈",@"lastTime":@"2018-12-06 13:47:00"}];
    // 删除
//    [[ZZFMDBTool shareInstance] deleteDataWithTable:ZZSQL_TABLE_WeChatListTable andWeChatID:@"1"];
    // 修改
//    [[ZZFMDBTool shareInstance] reviseDataWithTable:ZZSQL_TABLE_WeChatListTable WeChatId:@"2" andReviseKey:@"lastText" ReviseValue:@"最后的话"];
    // 查找
//    [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatListTable andKeysArray:@[@"wechat_id",@"wechat_name",@"lastText",@"lastTime"]];
//     删表
//    [[ZZFMDBTool shareInstance]deleteTable:ZZSQL_TABLE_WeChatListTable];
}
@end
