//
//  ZZWebSocketUtility.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/4.
//  Copyright © 2018年 张张. All rights reserved.
//
// 有关websocket介绍 https://www.zhihu.com/question/20215561
#import <Foundation/Foundation.h>
#import "SocketRocket.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZWebSocketUtility : NSObject

+ (instancetype)shareInstance;
// 连接socket
- (void)connectWebSocket;
// 断开socket
- (void)disConnectWebSocket;
// 发送消息
- (void)sendMessageData:(id)data;
- (SRReadyState)socketReadyState;
@end

NS_ASSUME_NONNULL_END
