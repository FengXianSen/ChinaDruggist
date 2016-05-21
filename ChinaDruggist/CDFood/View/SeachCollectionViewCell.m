//
//  SeachCollectionViewCell.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "SeachCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface SeachCollectionViewCell ()
{
    UIImageView *image;
    UILabel *lable;
    UIWebView *web;

}

@end


@implementation SeachCollectionViewCell
//+ (void)initialize
//{
//    if (self == [UICollectionViewCell class]) {
//        [[self alloc]init];
//    }
//}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatUIView];
    }
    return self;
}
-(void)creatUIView{
    image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.contentView addSubview:image];

    web=[[UIWebView alloc]initWithFrame:CGRectMake(0, image.frame.origin.y+image.frame.size.height, image.frame.size.width, 50)];
    web.scrollView.scrollEnabled=NO;
    [self.contentView addSubview:web];
}
-(void)setModel:(SeachModel *)model{
    _model=model;
    [image sd_setImageWithURL:[NSURL URLWithString:[image_path stringByAppendingString:model.img]] placeholderImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"]];
 NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", model.title];
    [web loadHTMLString:htmlcontent baseURL:nil];
}
-(void)setFootmodel:(footmodel *)footmodel{
    _footmodel=footmodel;
    [image sd_setImageWithURL:[NSURL URLWithString:[image_path stringByAppendingString:footmodel.img]] placeholderImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"]];
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", footmodel.name];
    [web loadHTMLString:htmlcontent baseURL:nil];

}



@end
