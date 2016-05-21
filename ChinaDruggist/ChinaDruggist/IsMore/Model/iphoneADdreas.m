//
//  iphoneADdreas.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "iphoneADdreas.h"

@implementation iphoneADdreas

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"operator":@"operatorname"}];

}


@end
