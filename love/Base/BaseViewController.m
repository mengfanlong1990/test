//
//  BaseViewController.m
//  yyhouse
//
//  Created by 刘佳 on 2017/10/24.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//
#import "BaseViewController.h"
#import <IQKeyboardManager.h>
#import "HttpRequest.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@end

@implementation BaseViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.forbidInteractivePopGesture == NO) {
        UINavigationController * nv =(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if ([nv respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            nv.interactivePopGestureRecognizer.delegate = self;
            nv.interactivePopGestureRecognizer.enabled = YES;
        }
    }else{
        UINavigationController * nv =(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if ([nv respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            nv.interactivePopGestureRecognizer.enabled = NO;
        }
    }
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    UINavigationController * nv =(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nv respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        nv.interactivePopGestureRecognizer.enabled = NO;
    }
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afnNetNotification:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
   
    WS;
//    //空内容视图
//    self.emptyView =  [MFLEmptyView emptyView];
//    [self.view addSubview:self.emptyView];
//    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//    self.emptyView.emptyLabelText = @"加载失败,点击屏幕重新加载";
//    self.emptyView.emptyImageName = @"jzsb_icon_da";
//    self.emptyView.hidden = YES;
//    self.emptyView.backgroundColor =[UIColor clearColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *lineView = [self emurate:self.tabBarController.tabBar];
    lineView.hidden = YES;
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //去除导航栏下方的横线
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // bg.png为自己ps出来的想要的背景颜色。
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"bg.png"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];

    //设置statusBar颜色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication  sharedApplication]setStatusBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark AFNetReachability
-(void)afnNetNotification:(NSNotification *)note{
    NSNumber *number = note.userInfo[AFNetworkingReachabilityNotificationStatusItem];
    
    AFNetworkReachabilityStatus status = number.integerValue;
    [self dealWithNetChange:status];
}

-(void)dealWithNetChange:(AFNetworkReachabilityStatus)status{
    
}



-(void)basePushViewController:(UIViewController *)vc animated:(BOOL)animated  {
  
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"nav_icon_back"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_icon_back"]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:vc animated:animated];
    
}
-(void)baseRemoveSelfFromNav{
    
    NSMutableArray *navArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [navArr removeObject:self];
    self.navigationController.viewControllers = navArr;
}

-(void)setNavTitle:(NSString *)title{
    _navTitle = title;
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = Font(16);
    
    
    self.navigationItem.titleView = label;
    
}

#pragma mark - uinavdelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated{


//    BOOL hide = [viewController isKindOfClass:[MomHomePageViewController class]];
    
    [navigationController setNavigationBarHidden:NO animated:YES];
}


-(UIImageView *)emurate:(UIView *)view{
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[UIImageView class] ]) {
            
            UIImageView *imageView = (UIImageView *) sub;
            if (imageView.image == nil) {
                return imageView;
                
            }

        }else  if (sub.subviews.count != 0) {
            
         return  [self emurate:sub];
        }
        
       
        }
    return nil;
}



-(BOOL)prefersStatusBarHidden{

    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(BOOL)shouldAutorotate{
    return NO;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


#pragma mark - 分享视图及回调
#pragma mark - 分享视图及回调
//-(void)shareWithTitle:(NSString *)title subTitle:(NSString *)subTitle url:(NSString *)url image:(id)image  {
//    WSF(weakSelf);
//    weakSelf.shareView = [MyshareView shareViewWithTitle:title subTitle:subTitle url:url image:image collectClick:^{
//
//    } reportClick:^{
//
//    } delete:^{
//
//    }];
//    weakSelf.shareView.shareType = SHARETYPE_Prediction;
//    [UIView animateWithDuration:0.25 animations:^{
//        weakSelf.shareView.y -= 120;
//        weakSelf.shareView.HidenShareBtn.alpha = 0.2;
//        weakSelf.shareView.alpha = 1;
//    }];
//}



@end



#pragma  mark - tableViewController
@interface BaseTableViewController()
@end

@implementation BaseTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    WS;
    UITableView *tableView = [[UITableView alloc]init];
//    [self.view insertSubview:tableView belowSubview:self.emptyView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available (iOS 11.0,*)) {
            make.edges.mas_equalTo(weakSelf.view.safeAreaInsets);

        }else{
            make.edges.equalTo(weakSelf.view);
        }
        
    }];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableFooterView = [[UIView alloc]init];

    //空内容视图
//    self.emptyView =  [MFLEmptyView emptyView];
//    [self.tableView addSubview:self.emptyView];
//    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.centerY.offset(0);
//        make.width.equalTo(weakSelf.tableView.mas_width).offset(0);
//        make.height.equalTo(weakSelf.tableView.mas_height).offset(0);
//
//    }];
//    self.emptyView.emptyLabelText = @"空空如也";
//    self.emptyView.emptyImageName = @"grzx_pic_kong";
//    self.emptyView.hidden = YES;
//    self.emptyView.backgroundColor = [UIColor clearColor];
   
}


@end


@implementation BaseCollectionController
 -(void)viewDidLoad{
        [super viewDidLoad];
     UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout: [[UICollectionViewLayout alloc]init]];
     
     [self.view addSubview:collection];
     WS;
     [collection mas_makeConstraints:^(MASConstraintMaker *make) {
         if (@available (iOS 11.0,*)) {
             make.edges.mas_equalTo(weakSelf.view.safeAreaInsets);
             
         }else{
             make.edges.equalTo(weakSelf.view);
         }
         
     }];
     self.collectionView = collection;
     collection.delegate = self;
     collection.dataSource = self;
     
     collection.backgroundColor = [UIColor whiteColor];
 }

@end


@implementation BaseGroupTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    WS;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available (iOS 11.0,*)) {
            make.edges.mas_equalTo(weakSelf.view.safeAreaInsets);
            
        }else{
            make.edges.equalTo(weakSelf.view);
        }
        
    }];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

//    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //空内容视图
//    self.emptyView =  [MFLEmptyView emptyView];
//    [self.tableView addSubview:self.emptyView];
//    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.centerY.offset(0);
//        make.width.equalTo(weakSelf.tableView.mas_width).offset(0);
//        make.height.equalTo(weakSelf.tableView.mas_height).offset(0);
//        
//    }];
//    self.emptyView.emptyLabelText = @"空空如也";
//    self.emptyView.emptyImageName = @"grzx_pic_kong";
//    self.emptyView.hidden = YES;
//    self.emptyView.backgroundColor = [UIColor clearColor];
}


@end
