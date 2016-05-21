//
//  IpAddresfund.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "IpAddresfund.h"
#import "AFNetworking.h"
@implementation IpAddresfund

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"county":@"countyname",@"operatorl":@"operatorlcty"}];
}

@end


