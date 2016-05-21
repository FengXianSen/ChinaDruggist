//
//  FoodTableViewCell.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ChinaTabDB.h"



@implementation FoodTableViewCell


- (void)awakeFromNib {

}

-(void)setModel:(footmodel *)model{
//    self.backgroundColor=[UIColor clearColor];
    _model=model;
    [self creatUI];
}

-(void)creatUI{
//    UIImageView *imageae=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cate_list_bg2"]];
//
//    imageae.alpha=0.2;
//    UIImageView *imageae1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cate_list_bg1"]];
//
//    self.selectedBackgroundView=imageae;
//
//    self.backgroundView=imageae1;
//    self.contentView.backgroundColor=[UIColor clearColor];

    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 110, 85)];
    [image sd_setImageWithURL:[NSURL URLWithString:[image_path stringByAppendingString:_model.img]]placeholderImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"]];
    image.layer.cornerRadius=10;
    image.layer.masksToBounds=YES;
    [self.contentView addSubview:image];


    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+10, image.frame.origin.y, self.frame.size.width-image.frame.size.width+10, 35)];
    lab.text=_model.name;
    lab.font=[UIFont boldSystemFontOfSize:20];
    lab.textColor=[UIColor blackColor];
    [self.contentView addSubview: lab];


    UILabel *labGX=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+10, lab.frame.origin.y+lab.frame.size.height, (self.frame.size.width-image.frame.size.width+10)/2, 25)];
    labGX.text=[@"功效:" stringByAppendingString:_model.menu];
    labGX.font=[UIFont boldSystemFontOfSize:13];
    labGX.textColor=[UIColor grayColor];
    [self.contentView addSubview: labGX];


    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(lab.frame.origin.y+lab.frame.size.width+10, lab.frame.origin.y+20,80, 35)];

    [btn setTitleColor:[UIColor blackColor] forState:
     UIControlStateNormal];


    if ([[ChinaTabDB sharedChinaTabDB]isgetSaveModel:_model]) {
        [btn setTitle:@"已收藏" forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:@"iconfont-shoucang-7"] imageWithRenderingMode:0] forState:UIControlStateNormal];
    }else{

        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:@"iconfont-shoucang-4"] imageWithRenderingMode:0] forState:UIControlStateNormal];
    }
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:btn];

    UILabel *labGN=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+10, labGX.frame.origin.y+labGX.frame.size.height,200/2, 25)];
    labGN.text=[@"功能:" stringByAppendingString:_model.bar];
    labGN.font=[UIFont boldSystemFontOfSize:13];
    labGN.textColor=[UIColor grayColor];
    [self.contentView addSubview: labGN];

    UILabel *labCont=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x+15, btn.frame.origin.y+btn.frame.size.height+10, self.frame.size.width-image.frame.size.width+10, 25)];
    labCont.text=[NSString stringWithFormat:@"点击量:%@",_model.btncount];
    labCont.font=[UIFont boldSystemFontOfSize:13];
    labCont.textColor=[UIColor grayColor];
    [self.contentView addSubview: labCont];
}
@end
