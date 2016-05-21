//
//  ChinaTabDB.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "ChinaTabDB.h"
#import "FMDB.h"


@interface ChinaTabDB ()
{
 FMDatabase *_dataBase;
}
@property(nonatomic,strong)FMDatabaseQueue *dataBasQueue;
@end
@implementation ChinaTabDB
SYNTHESIZE_SINGLETON_FOR_CLASS(ChinaTabDB);

-(instancetype)init{

    if (self=[super init]) {
        [self creatDB];
    }
    return self;
}
-(void)creatDB{

    NSString *sql = @"CREATE TABLE IF NOT EXISTS ChinaTablist (bar text , btncount text, fcount text,idapp text, img text,menu text,name text,rcount text,summary text, detailText text)";
    NSString *docPath  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];


    NSString *dbPath = [docPath stringByAppendingPathComponent:@"ChinaTabDB.db"];

    _dataBase = [[FMDatabase alloc]initWithPath:dbPath];

    //打开数据库
    [_dataBase open];


    _dataBasQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];

    [_dataBasQueue inDatabase:^(FMDatabase *db) {

        BOOL isSueccess = [db executeUpdate:sql];
        if (isSueccess) {
            NSLog(@"%@",@"创建表格成功");
        }else{
            NSLog(@"%@",@"创建表格失败");
        }
    }];

}

-(void)insertDBModel:(footmodel*)model{

    NSString *sql1 = @"select * from ChinaTablist";
    FMResultSet *Sueccess = [_dataBase executeQuery:sql1];
    BOOL isEs  = NO;//判断当前插入的数据是否存在

    while ([Sueccess next]) {
        if ([[Sueccess stringForColumn:@"idapp"] isEqualToString:model.idapp]){
            isEs = YES;
        }
    }
    if (!isEs) {
        NSString *sql = @"insert into ChinaTablist (bar, btncount,fcount,idapp, img,menu,name,rcount,summary,detailText)  values(?,?,?,?,?,?,?,?,?,?)";
        BOOL isSueccess = [_dataBase executeUpdate:sql,model.bar,model.btncount,model.fcount,model.idapp,model.img,model.menu,model.name,model.rcount,model.summary,model.detailText];
        if (isSueccess ) {
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
        }
    }
}

-(NSArray*)getInsertDBModels{
    NSString *sql = @"select * from ChinaTablist";
    FMResultSet *isSueccess = [_dataBase executeQuery:sql];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    while ([isSueccess next]) {
        footmodel*model=[[footmodel alloc]init];
        model.bar=[isSueccess stringForColumn:@"bar"];
        model.btncount=[isSueccess stringForColumn:@"btncount"];
        model.fcount=[isSueccess stringForColumn:@"fcount"];
        model.menu=[isSueccess stringForColumn:@"menu"];
        model.idapp=[isSueccess stringForColumn:@"idapp"];
        model.img=[isSueccess stringForColumn:@"img"];
        model.rcount=[isSueccess stringForColumn:@"rcount"];
        model.summary=[isSueccess stringForColumn:@"summary"];
        model.detailText=[isSueccess stringForColumn:@"detailText"];
        model.name=[isSueccess stringForColumn:@"name"];
        [arr addObject:model];
    }
    return arr;
}

-(BOOL)isgetSaveModel:(footmodel*)model{
    NSString *sql= @"SELECT * FROM ChinaTablist";
    FMResultSet *isSueccess = [_dataBase executeQuery:sql];
    BOOL isEs  = NO;//判断当前插入的数据是否存在
    while ([isSueccess next]) {

//        NSLog(@"%@",[isSueccess stringForColumn:@"idapp"]);
        if ([[isSueccess stringForColumn:@"idapp"] isEqualToString:model.idapp]){
             isEs = YES;
        }
       //如果进来，当前存在一条这样的语句
    }
    return isEs;
}


-(void)deleteDBModel:(footmodel*)model{
    NSString *sql = @"delete from ChinaTablist where idapp =?";
    //执行sql语句
    BOOL isSueccess = [_dataBase executeUpdate:sql,model.idapp];
    if (isSueccess ) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}

@end
