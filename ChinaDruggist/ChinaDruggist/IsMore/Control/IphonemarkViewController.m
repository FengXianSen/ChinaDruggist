//
//  IphonemarkViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//
#import "IphonemarkViewController.h"
#import "iphoneADdreas.h"
#import "iphoneADdreas+requestData.h"
@interface IphonemarkViewController ()<UITextFieldDelegate>
{
    UITextField*_text;
    iphoneADdreas *_idass;
    NSMutableArray *_arrcount;
}
@end


@implementation IphonemarkViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _idass=[[iphoneADdreas alloc]init];
    _arrcount=[[NSMutableArray alloc]init];
    [self createView];
}
-(void)createView{
     UIView *vie2=[[UIView alloc]initWithFrame:CGRectMake(5, 64, self.view.frame.size.width-10, 32)];
    _text=[[UITextField alloc]initWithFrame:CGRectMake(32,0,self.view.frame.size.width-110,32)];
    _text.placeholder=@"请输入手机号";
    _text.textAlignment=NSTextAlignmentLeft;
    _text.borderStyle=UITextBorderStyleRoundedRect;
    _text.font=[UIFont boldSystemFontOfSize:20];
    _text.delegate=self;
    _text.keyboardType=UIKeyboardTypePhonePad;
    _text.clearButtonMode=UITextFieldViewModeWhileEditing;
    [vie2 addSubview:_text];

    UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    image.image=[UIImage imageNamed:@"iconfont-shoujihaoma"];
    [vie2 addSubview:image];

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80,32)];
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [vie2 addSubview:btn];
    [self.view addSubview:vie2];


    UIView *vie=[[UIView alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-50, 35*4+20)];
    for (int i=0; i<4; i++) {
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(50, 40*i, self.view.frame.size.width-50, 35)];
        lab1.font=[UIFont boldSystemFontOfSize:20];
        [vie addSubview:lab1];
        [_arrcount addObject:lab1];
    }
    [self.view addSubview:vie];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)click:(UIButton*)btn{
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_idass requestData:_text.text block:^(iphoneADdreas *iphoneadresaa, NSError *erro) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel*lab3=(UILabel*)_arrcount[1];
                lab3.text=[NSString stringWithFormat:@"号码:%@",iphoneadresaa.telephone];
                UILabel*lab2=(UILabel*)_arrcount[3];
                lab2.text=[NSString stringWithFormat:@"所属:%@",iphoneadresaa.operatorname];
                UILabel*lab4=(UILabel*)_arrcount[2];
                lab4.text= [NSString stringWithFormat:@"省份:%@.%@",iphoneadresaa.province,iphoneadresaa.city];
            });
            
        }];

    });

}

@end
