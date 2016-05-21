//
//  Food_2viewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "Food_2viewController.h"
#import "UIImageView+WebCache.h"
#import "ChinaTabDB.h"
#import "UMSocial.h"
@interface Food_2viewController ()<UMSocialUIDelegate>
{
    UIWebView *WEW;
    UIWebView *WEW1;
    ChinaTabDB *_china;
    BOOL       _isSave;
    UIButton *saveBtn;
    UIButton *shareBtn;
}
@property(nonatomic,strong) UIActivityIndicatorView*active;
@end
@implementation Food_2viewController

-(void)viewDidLoad{
    self.view.backgroundColor=[UIColor whiteColor];
     _china=[ChinaTabDB sharedChinaTabDB];
    self.modelfoot=[footmodel sharefootmodel];
    self.navigationController.navigationBar.hidden=NO;
     self.automaticallyAdjustsScrollViewInsets=NO;
    [self createdata];

}
- (void)viewDidAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}
-(void)createdata{
    [self.view addSubview:self.active];
    [self.active startAnimating];
    [_modelfoot requestDataModelBlock:_foodID block:^(footmodel *model, NSError *erro) {
        self.modelfoot=model;
        self.modelfoot.idapp=_foodID;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.active stopAnimating];
        [self creteview];
        [self creteDownView];
        });
    }];
}
-(void)creteview{
     self.navigationItem.title=self.modelfoot.name;
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,64, KScreeWidth, self.view.frame.size.height-123)];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5,150,150)];
    [image sd_setImageWithURL:[NSURL URLWithString:[image_path stringByAppendingString:self.modelfoot.img]] placeholderImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL@2x"]];
    WEW=[[UIWebView alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+10,image.frame.origin.y+20,scroll.frame.size.width-image.frame.size.width-15,150)];
     [WEW loadHTMLString:_modelfoot.summary baseURL:nil];
     //WEW.scrollView.scrollEnabled=NO;
    [WEW.scrollView setBounces:NO];
    UILabel *wewSummary =[[UILabel alloc]initWithFrame:CGRectMake(WEW.frame.origin.x,WEW.frame.origin.y-20, WEW.frame.size.width, 20)];
    wewSummary.text=@"简介：";
    wewSummary.font=[UIFont boldSystemFontOfSize:15];
    WEW1=[[UIWebView alloc]initWithFrame:CGRectMake(0, WEW.frame.size.height+WEW.frame.origin.y+20,scroll.frame.size.width,
                                                    scroll.frame.size.height-(WEW.frame.size.height+WEW.frame.origin.y+20))];
    NSString *str=[_modelfoot.detailText  stringByReplacingOccurrencesOfString:@"来源于:" withString:@""];

     str=[str  stringByReplacingOccurrencesOfString:@"http://www.tngou.net/tech" withString:@""];
     str=[str  stringByReplacingOccurrencesOfString:@"http://www.tngou.net/tech/list/36" withString:@""];
     str=[str  stringByReplacingOccurrencesOfString:@"农业技术" withString:@""];
     str=[str  stringByReplacingOccurrencesOfString:@"蔬菜种植技术" withString:@""];
      str=[str  stringByReplacingOccurrencesOfString:@"- " withString:@""];
    UILabel *wewdetailText =[[UILabel alloc]initWithFrame:CGRectMake(10,WEW1.frame.origin.y-20, scroll.frame.size.width, 20)];
    wewdetailText.text=@"功能：";
    wewdetailText.font=[UIFont boldSystemFontOfSize:15];
    [scroll addSubview:wewSummary];
    [scroll addSubview:wewdetailText];
    
    [WEW1 loadHTMLString:str baseURL:nil];
    [WEW1.scrollView setBounces:NO];


   // scroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+150);
    [scroll addSubview:image];
    [scroll addSubview:WEW];
     [scroll addSubview:WEW1];
    [self.view addSubview:scroll];

}
-(void)creteDownView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];

    shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.bounds.size.width/2, 49)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"iconfont-fenxiang-3"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.tag=1000;
     shareBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [view addSubview:shareBtn];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -shareBtn.titleLabel.bounds.size.width-30, 0, 0);
    [shareBtn setContentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(-15,35,21,shareBtn.titleLabel.bounds.size.width);

    saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(view.bounds.size.width/2, 0, view.bounds.size.width/2, 49)];
    saveBtn.tag=1001;
    if ([_china isgetSaveModel:_modelfoot]) {
         [saveBtn setTitle:@"已收藏" forState:UIControlStateNormal];
         [saveBtn setImage:[UIImage imageNamed:@"iconfont-shoucang-6"] forState:UIControlStateNormal];
    }else{
         [saveBtn setTitle:@"收藏" forState:UIControlStateNormal];
         [saveBtn setImage:[UIImage imageNamed:@"iconfont-shoucang-5"] forState:UIControlStateNormal];
    }

    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [saveBtn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    saveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -saveBtn.titleLabel.bounds.size.width-30, 0, 0);
    [saveBtn setContentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
     saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
     saveBtn.imageEdgeInsets = UIEdgeInsetsMake(-15,35,21,saveBtn.titleLabel.bounds.size.width);

    [view addSubview:saveBtn];
    [self.view addSubview:view];
}

-(void)onclick:(UIButton*)btn{

    switch (btn.tag) {
        case 1000:
        {
            [UMSocialSnsService presentSnsIconSheetView:self         appKey:@"5642ffcf67e58e76a70004e6"shareText:@"你要分享的文字" shareImage:[UIImage imageNamed:@"iconfont-sousuo-2"]shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatFavorite,UMShareToTencent,UMShareToTwitter,UMShareToYXTimeline,nil]delegate:self];
        }
            break;
        case 1001:
        {
            if ([_china isgetSaveModel:_modelfoot]) {
                 [saveBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [saveBtn setImage:[UIImage imageNamed:@"iconfont-shoucang-5"] forState:UIControlStateNormal];
                [_china deleteDBModel:_modelfoot];
            }
            else{
                 [saveBtn setImage:[UIImage imageNamed:@"iconfont-shoucang-6"] forState:UIControlStateNormal];
                [_china insertDBModel:_modelfoot];
                  [saveBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            }
        }
            break;
        default:
            break;
    }
    [self.deleget relodatable];
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
