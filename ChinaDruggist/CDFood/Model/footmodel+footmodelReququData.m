//
//  footmodel+footmodelReququData.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "footmodel+footmodelReququData.h"
#import "AFNetworking.h"
#import "EffectModel.h"
#import "SeachModel.h"
@implementation footmodel (footmodelReququData)

+(id)sharefootmodel{
   static footmodel *model=nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model=[[footmodel alloc]init];
    });

    return model;
}
-(void)requestDataBlock:(NSInteger)page DataPath:(NSString*)datapath block:(modelReququData)requestData{

    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": Net_key};
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:datapath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
   if (error) {
       NSLog(@"%@", error);
   } else {
       NSMutableArray *arrdata=[NSMutableArray array];
       NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"yi18"];
       for (NSDictionary *dic in arr) {
           footmodel *fdVC=[[footmodel alloc]initWithDictionary:dic error:nil];
           [arrdata addObject:fdVC];
       }
       requestData(arrdata,nil);
   }
  }];
    [dataTask resume];
}
-(void)requestDataModelBlock:(NSString*)FOODID block:(modelReququDataModel)requestData{


    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": Net_key};

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:foot_option(FOODID)]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
              NSLog(@"%@", error);
            } else {
                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                footmodel *fdVC=[[footmodel alloc]init];
                [fdVC setValuesForKeysWithDictionary:dic[@"yi18"]];
                requestData(fdVC,nil);
             }
      }];
    [dataTask resume];

}
-(void)requestEffectDataBlock:(modelReququData)requestData{
     dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": Net_key};
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:foot_effect_bar] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     if (error) {
         NSLog(@"%@", error);
     } else {
         NSMutableArray *arrdata=[NSMutableArray array];
         NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"yi18"];

         for (NSDictionary *dic in arr) {
            EffectModel *fdVC=[[EffectModel alloc]init];
                         fdVC.name=dic[@"name"];
                         fdVC.nameid=dic[@"id"];
                         [arrdata addObject:fdVC];
         }
         requestData(arrdata,nil);
     }
  }];
    [dataTask resume];
  });
}
-(void)requestFunctionDataBlock:(modelReququData)requestData{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": Net_key};
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:foot_function_bar] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     if (error) {
         NSLog(@"%@", error);
     } else {
         NSMutableArray *arrdata=[NSMutableArray array];
         NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"yi18"];
         for (NSDictionary *dic in arr) {
             EffectModel *fdVC=[[EffectModel alloc]init];
             fdVC.name=dic[@"name"];
             fdVC.nameid=dic[@"id"];
             [arrdata addObject:fdVC];
         }
         requestData(arrdata,nil);
     }
 }];
    [dataTask resume];

  });

    }

-(void)requestMenulistDataModelBlock:(NSString*)page typeID:(NSString*)FOODID block:(modelReququData)requestData{
    AFHTTPRequestOperationManager *mager=[AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *serializer=[AFHTTPRequestSerializer serializer];
    [serializer setValue:Net_key forHTTPHeaderField:@"apix-key"];
    mager.requestSerializer=serializer;
    mager.responseSerializer=[AFHTTPResponseSerializer serializer];

    [mager GET:foot_effect(FOODID)

        parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *arr=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"yi18"];
            NSMutableArray *arrdata=[NSMutableArray array];
            for (NSDictionary *dic in arr) {
                footmodel *fdVC=[[footmodel alloc]initWithDictionary:dic error:nil  ];
                [arrdata addObject:fdVC];
            }
            requestData(arrdata,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestbarlistDataModelBlock:(NSString*)page typeID:(NSString*)FOODID block:(modelReququData)requestData{
    AFHTTPRequestOperationManager *mager=[AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *serializer=[AFHTTPRequestSerializer serializer];
    [serializer setValue:Net_key forHTTPHeaderField:@"apix-key"];
    mager.requestSerializer=serializer;
    mager.responseSerializer=[AFHTTPResponseSerializer serializer];

    [mager GET:foot_function(FOODID)
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *arr=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"yi18"];
        NSMutableArray *arrdata=[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            footmodel *fdVC=[[footmodel alloc]initWithDictionary:dic error:nil];
            [arrdata addObject:fdVC];
        }
        requestData(arrdata,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)requestSearchlistDataModelBlock:(NSString*)Keyword block:(modelReququData)requestData{
    AFHTTPRequestOperationManager *mager=[AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *serializer=[AFHTTPRequestSerializer serializer];
    [serializer setValue:Net_key forHTTPHeaderField:@"apix-key"];
    mager.requestSerializer=serializer;
    mager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *str=[Keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mager GET:foot_search_path(str)
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"yi18"];
        NSMutableArray *arrdata=[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            SeachModel *fdVC=[[SeachModel alloc]initWithDictionary:dic error:nil];
            [arrdata addObject:fdVC];
        }
        requestData(arrdata,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
