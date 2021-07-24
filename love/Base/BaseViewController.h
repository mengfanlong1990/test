//
//  BaseViewController.h
//  yyhouse
//
//  Created by 刘佳 on 2017/10/24.
//  Copyright © 2017年 RenJiZiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
//#import "MFLEmptyView.h"
@interface BaseViewController : UIViewController
@property (nonatomic,strong)NSString * navTitle;
//@property (nonatomic,strong)MFLEmptyView * emptyView;
-(void)dealWithNetChange:(AFNetworkReachabilityStatus)status;//实现这个方法来定义网络状况改变后的实现代码
-(void)basePushViewController:(UIViewController *)vc animated:(BOOL)animated ;
-(void)baseRemoveSelfFromNav;

@property (nonatomic,assign)BOOL forbidInteractivePopGesture;//限制边缘手势返回
@end

@interface BaseTableViewController:BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tableView;

@end

@interface BaseCollectionController:BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)UICollectionView *collectionView;
@end

@interface BaseGroupTableViewController:BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableView;
//@property (nonatomic,strong)MFLEmptyView * emptyView;

@end;
