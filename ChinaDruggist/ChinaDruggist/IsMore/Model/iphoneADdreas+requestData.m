//
//  iphoneADdreas+requestData.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "iphoneADdreas+requestData.h"
#import "AFNetworking.h"
@implementation iphoneADdreas (requestData)
SYNTHESIZE_SINGLETON_FOR_CLASS(iphoneADdreas)
-(void)requestData:(NSString *)number block:(requestdata)requestdata{

    AFHTTPRequestOperationManager *mager=[AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *sear=[AFHTTPRequestSerializer serializer];
    [sear setValue:iphone_addreasKEY forHTTPHeaderField:@"apix-key"];
    mager.requestSerializer=sear;
    mager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [mager GET:@"http://a.apix.cn/apixlife/phone/phone" parameters:@{@"phone":number} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];
       iphoneADdreas *ads=[[iphoneADdreas alloc]initWithDictionary:dic error:nil];
        requestdata(ads,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



@end
