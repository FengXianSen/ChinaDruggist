//
//  LFFoodTableViewcController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "LFFoodTableViewcController.h"
#import "footmodel+footmodelReququData.h"
#import "footmodel.h"
#import "EffectModel.h"
@interface LFFoodTableViewcController ()

@property (strong,nonatomic)NSMutableArray *EffectArray;
@property(strong,nonatomic)NSMutableArray *Functionarr;
@property(strong,nonatomic)NSMutableArray *DataCont;
@property(strong,nonatomic)NSMutableArray *DataContnil;
@property(strong,nonatomic)NSMutableArray *TitleTable;
@property (nonatomic,strong) NSMutableArray *flagArray;
@property(nonatomic,strong) UIActivityIndicatorView*active;
@property(assign,nonatomic) BOOL   isButton;
@end



@implementation LFFoodTableViewcController

-(void)viewDidLoad{
    self.view.backgroundColor=[UIColor clearColor];
    self.tableView.backgroundColor=[UIColor clearColor];
    _DataContnil=[[NSMutableArray alloc]init];
    _DataCont=[[NSMutableArray alloc]init];
     [self getData];
    self.tableView.showsVerticalScrollIndicator=NO;
}
-(void)getData{
    [self.view addSubview:self.active];
    [self.active startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5];
        [[footmodel alloc] requestEffectDataBlock:^(NSArray *arr, NSError *erro) {
            if (erro==nil) {
                _EffectArray =[NSMutableArray arrayWithArray:arr];
                [_DataCont addObject:_EffectArray];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                    [NSThread sleepForTimeInterval:0.2];
                    [[footmodel alloc] requestFunctionDataBlock:^(NSArray *arr, NSError *erro) {
                        if (erro==nil) {
                            _Functionarr =[NSMutableArray arrayWithArray:arr];
                             _TitleTable =[NSMutableArray arrayWithArray:@[@"功效",@"功能"]];
                            _flagArray=[NSMutableArray arrayWithArray:@[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]]];
                            [_DataCont addObject:_Functionarr];

                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self .tableView reloadData];
                                [self.active startAnimating];
                            });
                        }
                    }];
                });
            }
        }];
    });
[self .tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.DataCont.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.flagArray[section] boolValue] == YES) {
        //是收起状态
        return 0;
    }else{
         return [self.DataCont[section] count];
    }//不是收起状态


}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    EffectModel *model=_DataCont[indexPath.section][indexPath.row];
    cell.textLabel.text=model.name;
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
           UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
       // view.backgroundColor = [UIColor grayColor];
        //创建一个按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-45, 0,32, 32)];
        NSNumber *flagN = self.flagArray[section];
        //判断当前是否收起
        if ([flagN boolValue]) {
            //是收起状态
            [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-youjiantou"] forState:UIControlStateNormal];
        }else
        {
            //不是收起的状态
            [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-xiajiantou"] forState:UIControlStateNormal ];
        }
        //设置tag值，tag值一定要和section相关联
        btn.tag = 300+section;
        //btn增加一个回调函数
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

        [view addSubview:btn];
        //创建一个UILabel
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-125, 0, 65, 32)];
        label.text = _TitleTable[section];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        [view addSubview:label];
        return view;
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EffectModel *model=_DataCont[indexPath.section][indexPath.row];
    [self notifycation];
    if (indexPath.section==0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tablerload" object:nil userInfo:@{@"id":model.nameid,@"name":model.name}];
    }else if (indexPath.section==1){
          [[NSNotificationCenter defaultCenter]postNotificationName:@"tablerloadBar" object:nil userInfo:@{@"id":model.nameid,@"name":model.name}];
    }
}
-(void)notifycation{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TOGGER" object:nil userInfo:nil];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"chagevalue" object:nil userInfo:nil];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TOGGER" object:nil];
}
    //箭头按钮的回调函数
-(void)onClick:(UIButton *)btn{
        //判断相对应的标记数组中的状态,更改为相反的状态
    if ([self.flagArray[btn.tag - 300] boolValue]) {
            [self.flagArray replaceObjectAtIndex:(btn.tag - 300) withObject:[NSNumber  numberWithBool:NO ]];
        }else{
            [self.flagArray replaceObjectAtIndex:(btn.tag - 300) withObject:[NSNumber numberWithBool:YES]];
        }
        //刷新数据
        [self.tableView reloadData ];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}

-(UIActivityIndicatorView *)active{
    if (_active==nil) {
        _active=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _active.center=self.view.center;
        _active.layer.transform=CATransform3DMakeScale(2, 2, 0);

    }
    return _active;
    
}

@end
