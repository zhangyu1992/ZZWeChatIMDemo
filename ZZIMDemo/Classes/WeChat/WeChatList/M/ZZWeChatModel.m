//
//  ZZWeChatModel.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatModel.h"
#import <objc/runtime.h>
@implementation ZZWeChatModel
- (instancetype)initWithDefalutData{
    if (self = [super init]) {
       self = [self updateVariable];
    }
    return self;
}
/** 获取属性列表 */
-(void)getProperties{
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *attributes = property_getAttributes(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
        NSLog(@"attributesStr : %@", attributesStr);
    }
}
/** 修改变量 */
- (id)updateVariable
{
    //获取当前类
    id theClass = [self class];
    //初始化
    id otherClass = [[theClass alloc] init];
    
    unsigned int count = 0;
    //获取属性列表
    Ivar *members = class_copyIvarList([otherClass class], &count);
    
    //遍历属性列表
    for (int i = 0 ; i < count; i++) {
        Ivar var = members[i];
        //获取变量名称
        const char *memberName = ivar_getName(var);
        //获取变量类型
        const char *memberType = ivar_getTypeEncoding(var);
        
        NSLog(@"%s----%s", memberName, memberType);
        
        Ivar ivar = class_getInstanceVariable([otherClass class], memberName);
        
        NSString *typeStr = [NSString stringWithCString:memberType encoding:NSUTF8StringEncoding];
        //判断类型
        if ([typeStr isEqualToString:@"@\"NSString\""]) {
            //修改值
            object_setIvar(otherClass, ivar, @"");
        }
//        else{
//            object_setIvar(otherClass, ivar, [NSNumber numberWithInt:0]);
//        }
    }
    return otherClass;
}


@end
