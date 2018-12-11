//
//  ZZSessionInputView.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZZSessionInputViewDelegate <NSObject>

- (void)sendMessage:(NSString *)message;

@end
@interface ZZSessionInputView : UIView
+ (instancetype)initInputView;
@property (nonatomic,weak) id <ZZSessionInputViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
