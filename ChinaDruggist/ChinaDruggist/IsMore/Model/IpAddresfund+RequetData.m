//
//  IpAddresfund+RequetData.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "IpAddresfund+RequetData.h"
#import "AFNetworking.h"
@implementation IpAddresfund (RequetData)
SYNTHESIZE_SINGLETON_FOR_CLASS(IpAddresfund)
-(void)requestData:(NSString *)IPnumber block:(requestdata)requestdata{

    AFHTTPRequestOperationManager *mager=[AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *sear=[AFHTTPRequestSerializer serializer];
    [sear setValue:ip_addreasKEY forHTTPHeaderField:@"apix-key"];
    mager.requestSerializer=sear;
    mager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [mager GET:@"http://a.apix.cn/tongyu/iplookup/ip" parameters:@{@"ip":IPnumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];


        IpAddresfund *ads=[[IpAddresfund alloc]init];
        //        [ads setValuesForKeysWithDictionary:dic];

        ads.countyname=dic[@"country"];
        ads.province=dic[@"province"];
        ads.operatorlcty=dic[@"operator"];
        ads.city=dic[@"city"];
        NSLog(@"%@",ads);
        requestdata(ads,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         requestdata(nil,error);

        NSLog(@"%@",error);
    }];
    
    
}
@end
