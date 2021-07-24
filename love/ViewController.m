//
//  ViewController.m
//  love
//
//  Created by mfl on 2018/11/2.
//  Copyright © 2018 love. All rights reserved.
//

#import "ViewController.h"
#import "xibV.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ceshi";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#cccccc"];
    UIView * firstV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 400, 400)];
    firstV.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstV];
    
    UIView * secondV = [[UIView alloc]init];
    secondV.backgroundColor = [UIColor orangeColor];
    [firstV addSubview: secondV];
    [secondV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.view.mas_top).offset(15);
            make.height.offset(50);
            
    }];
    
    xibV * xi =[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xibV class]) owner:nil options:nil] lastObject];
    xi.frame =CGRectMake(0, 0, 300 ,500);
    [secondV addSubview:xi];
    
}


@end
