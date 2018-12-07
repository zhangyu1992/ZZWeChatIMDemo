//
//  ZZStyleCommon.h
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#ifndef ZZStyleCommon_h
#define ZZStyleCommon_h

/**屏幕宽度*/
#define ZZScreenWidth [UIScreen mainScreen].bounds.size.width
/**屏幕高度*/
#define ZZScreenHeight [UIScreen mainScreen].bounds.size.height
/**导航栏的高度*/
#define ZZ_Navigation_Height (44 + ZZ_StatesBar_Height)
/** 状态栏的高度*/
#define ZZ_StatesBar_Height ([[UIApplication sharedApplication] statusBarFrame].size.height)

/**颜色*/
#define ZZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**导航栏颜色*/
#define ZZ_Navigation_DefalutColor ZZColor(51,51,51)
/**导航栏文字颜色*/
#define ZZ_NavBar_TitleColor ZZColor(255,255,255)
/**主控制器背景颜色*/
#define ZZ_MainVC_BackGroundColor ZZColor(255,255,255)
/**主背景颜色 -- 灰色*/
#define ZZMianBackColor_Gray ZZColor(230,230,230)
/**主文字颜色 -- 黑色*/
#define ZZMainTextColor_Balck ZZColor(51,51,51)
/**主文字颜色 -- 灰色*/
#define ZZMainTextColor_Gray ZZColor(128,128,128)

/**WeChatlist 标题文字大小*/
#define ZZWeChatNameLabelFont [UIFont systemFontOfSize:20.0]
#define ZZWeChatContLabelFont [UIFont systemFontOfSize:18.0]


#define iPhoneX_SafeArea_Bottom ([ZZTools getSafeAreaBottom])

#endif /* ZZStyleCommon_h */
