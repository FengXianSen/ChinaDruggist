//
//  HHADView.m
//  Tsss
//
//  Created by 郝海圣 on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HHADView.h"
#import "UIImageView+WebCache.h"
@interface HHADView()
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@end


@implementation HHADView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}
-(void)customView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds    ];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-100, self.bounds.size.height-30, 200, 30)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor blueColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self addSubview:_pageControl];
}

-(void)loadData{
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*self.itemArray.count, self.bounds.size.height);
    for (int i = 0; i < self.itemArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.image=[UIImage imageNamed:_itemArray[i]
                         ];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];

    }
    _pageControl.numberOfPages = _itemArray.count;
}




-(void)reloadData{
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*self.itemArray.count, self.bounds.size.height);
    for (int i = 0; i < self.itemArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        HHADItem *item = [self.itemArray objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.imagePath]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
        UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*i,self.bounds.size.height-30, self.bounds.size.width, 30)];
        label.text = item.imageName;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor
                                 blackColor];
        label.font = [UIFont boldSystemFontOfSize:25];
        label.alpha = 0.8;
        [_scrollView addSubview:label];
    }
    _pageControl.numberOfPages = _itemArray.count;
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
