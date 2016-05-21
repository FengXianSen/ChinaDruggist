//
//  IpAddresfund.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "JSONModel.h"
//@class IpAddresfund;

@interface IpAddresfund : JSONModel
@property(nonatomic,copy)NSString* countyname;
@property(nonatomic,copy)NSString* province;
@property(nonatomic,copy)NSString* operatorlcty;
@property(nonatomic,copy)NSString* city;

@end
