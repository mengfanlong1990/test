//
//  MFLEmptyView.m
//  AiKline
//
//  Created by mengfl on 16/9/7.
//  Copyright © 2016年 YJNetwork. All rights reserved.
//
#import "MFLEmptyView.h"

@interface MFLEmptyView ()
/** 敲击视图要做的事 */
@property (nonatomic, copy) TapViewBlock tapViewBlock;
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;


@end

@implementation MFLEmptyView

+ (instancetype)emptyView{
    MFLEmptyView *emptyV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MFLEmptyView class]) owner:nil options:nil] lastObject];
    return emptyV;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        if(self.emptyImageName){
            [self.emptyImageView setImage:[UIImage imageNamed:self.emptyImageName]];
        }else{
            [self.emptyImageView setImage:[UIImage imageNamed:@"grzx_pic_kong"]];
        }
        if(self.emptyLabelText){
            [self.emptyLabel setText:self.emptyLabelText];
        }else{
            [self.emptyLabel setText:@"暂无相关数据"];
        }
        
        [self.coverBtn addTarget:self action:@selector(tapView) forControlEvents:UIControlEventTouchDown];

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.emptyImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.isReLoad = NO;//默认不是重新加载视图
    self.emptyLabel.textColor = [UIColor colorWithHexStr:@"#bbbbbb"];
    
    if(self.emptyImageName){
        [self.emptyImageView setImage:[UIImage imageNamed:self.emptyImageName]];
    }else{
        [self.emptyImageView setImage:[UIImage imageNamed:@"grzx_pic_kong"]];
    }
    if(self.emptyLabelText){
        [self.emptyLabel setText:self.emptyLabelText];
    }else{
        [self.emptyLabel setText:@"暂无相关数据"];
    }
    
    [self.coverBtn addTarget:self action:@selector(tapView) forControlEvents:UIControlEventTouchDown];
}
-(void)setIsReLoad:(BOOL)isReLoad
{
    _isReLoad = isReLoad;
    
    if (_isReLoad) {
        [self.emptyImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(206);
            make.height.offset(83);
        }];
    }else{
        [self.emptyImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(161);
            make.height.offset(145);
        }];
    }
    
}
- (void)setEmptyImageName:(NSString *)emptyImageName{
    _emptyImageName = emptyImageName;
    if(self.emptyImageName){
        [self.emptyImageView setImage:[UIImage imageNamed:self.emptyImageName]];
    }else{
        [self.emptyImageView setImage:[UIImage imageNamed:@"grzx_pic_kong"]];
    }
}

- (void)setEmptyLabelText:(NSString *)emptyLabelText{
    _emptyLabelText = emptyLabelText;
    if(self.emptyLabelText){
        [self.emptyLabel setText:self.emptyLabelText];
    }else{
        [self.emptyLabel setText:@"暂无相关数据"];
    }
}

- (void)tapView{
    if(self.tapViewBlock) self.tapViewBlock();
}

- (void)tapViewTodo:(TapViewBlock)tapViewTodo{
    self.tapViewBlock = tapViewTodo;
}


@end
