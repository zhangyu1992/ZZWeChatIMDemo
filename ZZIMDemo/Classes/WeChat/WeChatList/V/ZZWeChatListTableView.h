//
//  ZZWeChatListTableView.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZZWeChatModel;

@protocol ZZWeChatListTableViewDelegate <NSObject>

- (void)TableViewDidSelectedWithModel:(ZZWeChatModel *)wechatModel;

@end
@interface ZZWeChatListTableView : UITableView
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, weak) id <ZZWeChatListTableViewDelegate> listTableViewDelegate;
@end

NS_ASSUME_NONNULL_END
