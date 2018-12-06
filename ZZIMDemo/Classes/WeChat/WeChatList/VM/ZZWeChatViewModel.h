//
//  ZZWeChatViewModel.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZWeChatSessionViewController.h"
#import "ZZWeChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZWeChatViewModel : NSObject
- (NSMutableArray *)getModelDataArrayFromLoaclTable;
- (ZZWeChatSessionViewController * )pushSessionViewControllerWithWeChatModel:(ZZWeChatModel *)wechatModel;
@end

NS_ASSUME_NONNULL_END
