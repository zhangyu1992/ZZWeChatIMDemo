//
//  ZZNamesCommon.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#ifndef ZZNamesCommon_h
#define ZZNamesCommon_h

/**数据库名*/
#define ZZSQL_WECHATLIST @"WeChat.sqlite"
/**微信首页消息列表 表名*/
#define ZZSQL_TABLE_WeChatListTable @"WeChatListTable"

/**微信聊天消息列表 表名 receiveID:接受者ID*/
#define ZZSQL_TABLE_WeChatSessionTable(WeChatID) [NSString stringWithFormat:@"WeChatSessionTable_%@",WeChatID]
//@"WeChatSessionTable"

#endif /* ZZNamesCommon_h */
