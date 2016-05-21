//
//  iphoneADdreas+requestData.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "iphoneADdreas.h"

typedef void(^requestdata)(iphoneADdreas*iphoneadresaa,NSError*erro);

@interface iphoneADdreas (requestData)
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(iphoneADdreas)

-(void)requestData:(NSString *)number block:(requestdata)requestdata;

@end
