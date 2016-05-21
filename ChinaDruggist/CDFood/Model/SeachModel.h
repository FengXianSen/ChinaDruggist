//
//  SeachModel.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "JSONModel.h"

@interface SeachModel : JSONModel
@property(nonatomic,copy)NSNumber<Optional>*titleId;
@property(nonatomic,copy)NSString<Optional>*title;
@property(nonatomic,copy)NSString<Optional>*img;
@property(nonatomic,copy)NSString<Optional>*keywords;
@property(nonatomic,copy)NSString<Optional>*content;
@property(nonatomic,copy)NSString<Optional>*type;
@end
