//
//  IpAddresfund+RequetData.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "IpAddresfund.h"
typedef void(^requestdata)(IpAddresfund*iphoneadresaa,NSError*erro);
@interface IpAddresfund (RequetData)
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(IpAddresfund)
-(void)requestData:(NSString *)IPnumber block:(requestdata)requestdata;
@end
