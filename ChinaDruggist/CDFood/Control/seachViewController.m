//
//  seachViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "seachViewController.h"
#import "SeachModel.h"
#import "footmodel+footmodelReququData.h"
#import "footmodel.h"
#import "SeachCollectionViewCell.h"
#import "Food_2viewController.h"
@interface seachViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    UITextField *textfield;
    footmodel *model;
    UICollectionView*_clview;
}

@property(nonatomic,strong)UIAlertView *alert;
@property(nonatomic,strong)NSMutableArray *seararr;
@property(nonatomic,strong)UITableView *searchtab;

@end

@implementation seachViewController

- (void)viewDidLoad {
    model=[[footmodel alloc]init];
    [super viewDidLoad];
    [self createView];

}

-(void)createdata{
    [model requestSearchlistDataModelBlock:textfield.text block:^(NSArray *arr, NSError *erro) {
        self.seararr=[NSMutableArray arrayWithArray:arr];

        if(self.seararr.count>0){
             [_clview reloadData];
        }else{
            [self.view addSubview:self.alert];
            [self.alert show];
        }
    }];

}

-(void)createView{
    [self creadSearhView];
    UICollectionViewFlowLayout*clfy=[[UICollectionViewFlowLayout alloc]init];
    clfy.itemSize=CGSizeMake(150, 200);
    clfy.sectionInset=UIEdgeInsetsMake(5,20, 5, 20);
    _clview =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 110, KScreeWidth, KScreeHeigth-110) collectionViewLayout:clfy];
    _clview.delegate=self;
    _clview.dataSource=self;


    _clview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_clview];

    [_clview registerClass:[SeachCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];

    self.title=@"搜索";
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.seararr.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SeachCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model=_seararr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Food_2viewController *fd2vc=[[Food_2viewController alloc]init];
    SeachModel *model2=_seararr[indexPath.item];
    fd2vc.foodID=[model2.titleId stringValue];
    [self.navigationController pushViewController:fd2vc animated:YES];
    
}
-(void)creadSearhView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreeWidth, 44)];
    textfield=[[UITextField alloc]initWithFrame:CGRectMake(5, 2, KScreeWidth-10, 30)];
    textfield.placeholder=@"🔍千种中草任你搜";
    textfield.layer.cornerRadius=10;
    textfield.layer.masksToBounds=YES;
    textfield.textAlignment=NSTextAlignmentCenter;
    textfield.font=[UIFont boldSystemFontOfSize:15];
    textfield.layer.borderWidth=0.1;
    textfield.delegate=self;
    textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    //更改键盘搜索键名
    textfield.returnKeyType=UIReturnKeySearch;
    [view addSubview:textfield];
    [self.view addSubview:view];
}
#pragma mark UITextField协议方法
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    textField.textAlignment=NSTextAlignmentLeft;
    textField.placeholder=@"";

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.textAlignment=NSTextAlignmentCenter;
    textField.placeholder=@"🔍千种中草任你搜";;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [self createdata];
    return YES;
}

-(UIAlertView *)alert{

    if (_alert==nil) {
        _alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无数据，敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }
    return _alert;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
