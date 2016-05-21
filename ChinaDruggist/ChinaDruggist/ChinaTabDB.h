//
//  ChinaTabDB.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "footmodel.h"
@interface ChinaTabDB : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(ChinaTabDB);

-(void)insertDBModel:(footmodel*)model;

-(NSArray*)getInsertDBModels;

-(void)deleteDBModel:(footmodel*)model;
-(BOOL)isgetSaveModel:(footmodel*)model;

@end
