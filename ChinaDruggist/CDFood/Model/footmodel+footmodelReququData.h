//
//  footmodel+footmodelReququData.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "footmodel.h"

typedef void(^modelReququData)(NSArray *arr,NSError *erro);
typedef void(^modelReququDataModel)(footmodel *model,NSError *erro);

@interface footmodel (footmodelReququData)



+(id)sharefootmodel;
-(void)requestDataBlock:(NSInteger)page DataPath:(NSString*)datapath block:(modelReququData)requestData;



-(void)requestDataModelBlock:(NSString*)FOODID block:(modelReququDataModel)requestData;

-(void)requestMenulistDataModelBlock:(NSString*)page typeID:(NSString*)FOODID block:(modelReququData)requestData;

-(void)requestbarlistDataModelBlock:(NSString*)page typeID:(NSString*)FOODID block:(modelReququData)requestData;


-(void)requestEffectDataBlock:(modelReququData)requestData;
-(void)requestFunctionDataBlock:(modelReququData)requestData;

-(void)requestSearchlistDataModelBlock:(NSString*)Keyword block:(modelReququData)requestData;
@end
