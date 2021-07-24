//
//  ViewController.m
//  yyf
//
//  Created by 人济紫顶 on 2017/8/14.
//  Copyright © 2017年 人济紫顶. All rights reserved.
//

#define xScale [UIScreen mainScreen].bounds.size.width / 375.0
#define yScale ([UIScreen mainScreen].bounds.size.height-64-49) / (667.0-64-49)
#define RED_COLOR                 @"#d63535"//升 颜色
#import "YYFGuidePage.h"


@interface YYFGuidePage ()<UIScrollViewDelegate>

@property (nonatomic,copy) guidePageBlock guideBlock;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger totalPage;


@end

@implementation YYFGuidePage

-(instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)imagesArray getIntoMainView:(void (^)())handlerBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        _guideBlock = handlerBlock;
        
        [self createGuidePageUI:imagesArray];
        
    }
    return self;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate=self;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 30)];
        _pageControl.hidesForSinglePage=YES;
        _pageControl.pageIndicatorTintColor=[UIColor redColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor blueColor];
        _pageControl.backgroundColor=[UIColor yellowColor];
    }
    return _pageControl;
}

-(void)createGuidePageUI:(NSArray *)imagesArray
{
    [self addSubview:self.scrollView];
    
    CGFloat currentViewWidth=self.frame.size.width;
    CGFloat currentViewHeigth=self.frame.size.height;
    
    self.scrollView.contentSize=CGSizeMake(imagesArray.count*currentViewWidth, currentViewHeigth);
    self.pageControl.numberOfPages=imagesArray.count;
    
    for (UIImageView *image in self.scrollView.subviews) {
        
        [image removeFromSuperview];
        
    }
    
    for (NSInteger i=0; i<imagesArray.count; i++) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*currentViewWidth, 0, currentViewWidth, currentViewHeigth)];
        imageView.userInteractionEnabled=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.image=[UIImage imageNamed:imagesArray[i]];
        
        if (i==imagesArray.count-1) {
            
            UIButton *btn=[UIButton buttonWithType:0];
//            btn.frame=CGRectMake((currentViewWidth-(135))/2.0, kScreenH-(60+36), (135), (36));
//            btn.backgroundColor = CGreen;
            btn.titleLabel.font=[UIFont systemFontOfSize:(15)];
            btn.layer.cornerRadius = 36/2;
            btn.layer.masksToBounds = YES;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn setTitle:@"立即体验"forState:UIControlStateNormal];
            [btn setTitle:@"立即体验"forState:UIControlStateHighlighted];

            [btn addTarget:self action:@selector(buttonActionBlock:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
        }
        
        [self.scrollView addSubview:imageView];
        
    }
    
//    _totalPage=imagesArray.count;
}

-(void)buttonActionBlock:(UIButton *)sender
{  
    [UIView animateWithDuration:1. animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _pageControl.currentPage=scrollView.contentOffset.x/self.frame.size.width;
}

@end











