//
//  SeachModel.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "SeachModel.h"

@implementation SeachModel
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//}
+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"titleId"}];
}

@end
