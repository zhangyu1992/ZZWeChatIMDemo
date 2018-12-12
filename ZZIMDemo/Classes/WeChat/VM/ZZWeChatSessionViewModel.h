//
//  ZZWeChatSessionViewModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZSessionModel.h"
#import "ZZWeChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZZWeChatSessionViewModelDelegate <NSObject>

/**
 键盘消失
 */
- (void)keyboardWillHide;

/**
 键盘弹出
 */
- (void)keyboardWillShowToKeyboardRect:(CGRect )keyboardRect withAnimationOption:(NSInteger)animationOption andDuration:(double)timeInterval;

@end
@interface ZZWeChatSessionViewModel : NSObject

/**
 从数据库中去 单条聊天数据

 @param WeChatID 聊天ID
 @return 数据数组
 */
- (NSMutableArray *)getModelDataArrayFromLoaclTableWithWeChatID:(NSString *)WeChatID;

/**
 添加键盘 监听
 */
- (void)NotiKeyBoard;

@property (nonatomic, weak) id<ZZWeChatSessionViewModelDelegate>delegate;

/**
 发送一条信息
 @param WeChatModel 聊天model
 @param message 信息内容
 @param success 成功
 @param failed 失败
 */
- (void)addMessageToDBWithWeChatModel:(ZZWeChatModel *)WeChatModel sendMessage:(NSString *)message success:(void (^)(ZZSessionModel * _Nonnull sessionModel))success failed:(void (^)(void))failed;

- (BOOL)receiveMessage:(NSDictionary *)dict toDBWithWeChatModel:(ZZWeChatModel *)WeChatModel;
@end

NS_ASSUME_NONNULL_END
