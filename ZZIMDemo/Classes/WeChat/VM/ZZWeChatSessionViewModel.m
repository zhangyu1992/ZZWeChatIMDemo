//
//  ZZWeChatSessionViewModel.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionViewModel.h"
@implementation ZZWeChatSessionViewModel


// 取数据库 数据
- (NSMutableArray *)getModelDataArrayFromLoaclTableWithWeChatID:(NSString *)WeChatID{
    NSMutableArray * modelArray = [[NSMutableArray alloc]init];
    
    if (![self openDB]) {
        return modelArray;
    }
    if (![self isTableExistWithWeChatID:WeChatID]) {
        return modelArray;
    }
    ZZSessionModel * wechatModel = [[ZZSessionModel alloc]initWithDefalutData];
    NSDictionary * modelDict = wechatModel.mj_keyValues;
    
    NSMutableArray * dataArray = [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatSessionTable(WeChatID) andKeysArray:modelDict.allKeys];
    
    for (NSDictionary * dict in dataArray) {
        ZZSessionModel * model = [ZZSessionModel mj_objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    // 添加
//    [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatSessionTable WithContentDict:@{@"sendID":@"3",@"sendName":@"zhangzhang",@"messageText":@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",@"sendTime":@"2018-12-06 13:47:00",@"isMySelf":@"1"}];
    
    return modelArray;
}
#pragma mark 打开数据库
- (BOOL)openDB{
    return [[ZZFMDBTool shareInstance] openDataBaseWithFileName:ZZSQL_WECHATLIST];
}
#pragma mark -- 创建表
- (BOOL)isTableExistWithWeChatID:(NSString *)WeChatID{
    // 判断 y表存在
    if (![[ZZFMDBTool shareInstance] isTableExist:ZZSQL_TABLE_WeChatSessionTable(WeChatID)]) {
        // 创建
        ZZSessionModel * wechatModel = [[ZZSessionModel alloc]initWithDefalutData];
        NSDictionary * modelDict = wechatModel.mj_keyValues;
        return [[ZZFMDBTool shareInstance] creatTablesWithTableName:ZZSQL_TABLE_WeChatSessionTable(WeChatID) andElementArray:modelDict.allKeys];
    }
    return YES;
}
- (void)addMessageToDBWithWeChatID:(NSString *)WeChatID Message:(NSString *)message success:(void (^)(ZZSessionModel * _Nonnull sessionModel))success failed:(void (^)(void))failed{
    
    ZZSessionModel * model = [[ZZSessionModel alloc]init];
    model.sendID = @"3";
    model.sendName = @"zhangzhang";
    model.messageText = message;
    model.sendTime = [ZZTools getNowTimeString];
    model.isMySelf = @"1";
    NSDictionary * dict = model.mj_keyValues;
    // 添加
    ;
    BOOL isadd =  [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatSessionTable(WeChatID) WithContentDict:dict];
    
    if (isadd) {
        success(model);
    }else{
        failed();
    }
}

- (void)test{
    // 添加
    [[ZZFMDBTool shareInstance] addDataToTable:ZZSQL_TABLE_WeChatSessionTable(@"test") WithContentDict:@{@"sendID":@"3",@"sendName":@"zhangzhang",@"messageText":@"哈哈",@"sendTime":@"2018-12-06 13:47:00",@"isMySelf":@"1"}];
    // 删除
    [[ZZFMDBTool shareInstance] deleteDataWithTable:ZZSQL_TABLE_WeChatSessionTable(@"test") andWeChatID:@"1"];
    // 修改
    [[ZZFMDBTool shareInstance] reviseDataWithTable:ZZSQL_TABLE_WeChatSessionTable(@"test") WeChatId:@"2" andReviseKey:@"lastText" ReviseValue:@"最后的话"];
    // 查找
    [[ZZFMDBTool shareInstance] inquireALLDataWithTable:ZZSQL_TABLE_WeChatSessionTable(@"test") andKeysArray:@[@"wechat_id",@"wechat_name",@"lastText",@"lastTime"]];
    // 删表
    [[ZZFMDBTool shareInstance]deleteTable:ZZSQL_TABLE_WeChatSessionTable(@"test")];
}
- (void)NotiKeyBoard{
    //增加监听，当键盘出现或改变时触发方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时调用代理方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//当键盘出现或改变时回调的代理方法
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    //    CGFloat height = keyboardRect.size.height;
    double timeInterval = [[aNotification.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    NSInteger animationOption = [aNotification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardWillShowToY:withAnimationOption:andDuration:)]) {
        [self.delegate keyboardWillShowToY:keyboardRect.origin.y withAnimationOption:animationOption andDuration:timeInterval];
    }
}

//当键退出时回调
- (void)keyboardWillHide:(NSNotification *)aNotification{
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardWillHide)]) {
        [self.delegate keyboardWillHide];
    }
}- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"Execution dealloc");
}


@end
