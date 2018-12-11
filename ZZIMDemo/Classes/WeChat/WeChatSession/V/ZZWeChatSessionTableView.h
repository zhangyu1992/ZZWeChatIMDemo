//
//  ZZWeChatSessionTableView.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZZWeChatSessionTableViewDelegate <NSObject>

- (void)tableViewResignFirstResponder;

@end
@interface ZZWeChatSessionTableView : UITableView
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, weak) id <ZZWeChatSessionTableViewDelegate> sessionDelegate;

- (void)tableviewScrollToBottom;
- (void)ScrollToBottom;
@end

NS_ASSUME_NONNULL_END
