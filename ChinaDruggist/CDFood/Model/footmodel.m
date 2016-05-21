//
//  footmodel.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "footmodel.h"

@implementation footmodel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"count":@"btncount",@"id":@"idapp"}];
}
@end
