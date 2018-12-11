//
//  ZZWeChatSessionTableView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionTableView.h"
#import "ZZSessionTableViewCell.h"
#import "ZZSessionModel.h"
@interface ZZWeChatSessionTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL isResgister;
@end
@implementation ZZWeChatSessionTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.sessionDelegate && [self.sessionDelegate respondsToSelector:@selector(tableViewResignFirstResponder)]) {
        [self.sessionDelegate tableViewResignFirstResponder];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isResgister) {
        if (self.sessionDelegate && [self.sessionDelegate respondsToSelector:@selector(tableViewResignFirstResponder)]) {
            [self.sessionDelegate tableViewResignFirstResponder];
        }
    }
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height)
    {
        //在最底部
        self.isResgister = YES;
    }
}
- (void)ScrollToBottom{
    self.isResgister = NO;
    if (self.dataArray.count != 0 && self.contentSize.height > self.frame.size.height) {
        
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

}
- (void)tableviewScrollToBottom{

    [self ScrollToBottom];

    CGFloat height = self.frame.size.height;
    CGFloat contentOffsetY = self.contentOffset.y;
    CGFloat bottomOffset = self.contentSize.height - contentOffsetY;
    if (bottomOffset <= height)
    {
        //在最底部
        self.isResgister = YES;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.frame.size.height) animated:YES];
//    [self setContentOffset:CGPointMake(0, self.contentSize.height - 90) animated:YES];
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZSessionModel * sessionModel = self.dataArray[indexPath.row];
    NSString * cellId = @"ZZSessionTableViewCell_isMySelf";

    if ([sessionModel.isMySelf isEqualToString:@"1"]) {
        cellId = @"ZZSessionTableViewCell_isMySelf";
        
    }else if ([sessionModel.isMySelf isEqualToString:@"0"]) {
        cellId = @"ZZSessionTableViewCell_isOther";
    }else{
        
        cellId = @"ZZSessionTableViewCell_time";

    }
    
    ZZSessionTableViewCell * sessionCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (sessionCell == nil) {
        sessionCell = [[ZZSessionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    sessionCell.sessionModel = sessionModel;
    
    return sessionCell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
