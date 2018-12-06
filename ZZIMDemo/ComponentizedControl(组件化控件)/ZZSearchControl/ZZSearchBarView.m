
//
//  ZZSearchBarView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZSearchBarView.h"
@interface ZZSearchBarView()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * searchBar;
@end

@implementation ZZSearchBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.searchBar];
    }
    return self;
}
-(UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.delegate = self;
        _searchBar.text = @"搜索";
        _searchBar.placeholder = @"搜索";
        _searchBar.showsSearchResultsButton = NO;
        _searchBar.showsBookmarkButton = YES;
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
        _searchBar.inputAccessoryView.backgroundColor = [UIColor redColor];
        [_searchBar setImage:[UIImage imageNamed:@"sousuo-4"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [_searchBar setImage:[UIImage imageNamed:@"yuyin-2"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        [_searchBar setPositionAdjustment:UIOffsetMake(self.center.x - 50, 0) forSearchBarIcon:UISearchBarIconSearch];
        _searchBar.barTintColor = ZZMianBackColor_Gray;
    }
    return _searchBar;
}
@end
