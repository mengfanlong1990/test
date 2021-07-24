//
//  MFLRefresh.m
//  yyf
//
//  Created by rjzd on 2017/9/4.
//  Copyright © 2017年 人济紫顶. All rights reserved.
//
#define StateLabelDataArray @"stateLabelDataArray"
#import "MFLRefresh.h"

@interface MFLRefresh ()
@property (strong,nonatomic)UIImageView * rotateImgView;
@property (copy,nonatomic)NSArray * stateLabelDataArray;
@end

@implementation MFLRefresh
-(void)endRefreshing{
    [super endRefreshing];
    [self loadNewData];
}
-(void)loadNewData
{
//    [self stateLabelDataArray];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:StateLabelDataArray]&&[[[NSUserDefaults standardUserDefaults]objectForKey:StateLabelDataArray] count]>0) {
        int selectNum = [self getRandomNumber:0 to:(int)[(NSArray *)[[NSUserDefaults standardUserDefaults]objectForKey:StateLabelDataArray] count]-1];
        NSString * selectTitle = [(NSArray *)[[NSUserDefaults standardUserDefaults]objectForKey:StateLabelDataArray] objectAtIndex:selectNum];
        [self setTitle:selectTitle?:@"" forState:MJRefreshStateRefreshing];
    }else{
        [self setTitle:@"正在拼命刷新中..." forState:MJRefreshStateRefreshing];
    }

}
- (void)prepare
{
    [super prepare];
        

    
    // 设置original状态的动画图片
    NSMutableArray *originalImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"xlsx_pic%lu", (unsigned long)i]];
        [originalImages addObject:image];
    }
    [self setImages:originalImages forState:MJRefreshStateIdle];
    
//    // 设置Pulling状态的动画图片
//    NSMutableArray *pullingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=18; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%lu", (unsigned long)i]];
//        [pullingImages addObject:image];
//    }
//    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置Refreshing状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"xlsx_pic%lu", (unsigned long)i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
//    self.stateLabel.textColor = [UIColor colorWithHexStr:@"#5a5a5a"];
//    self.stateLabel.font = [UIFont systemFontOfSize:13];
    
    
    
    
    
//    //所有的自定义东西都放在这里
//    [self setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
//    [self setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
//    [self setTitle:@"正在中....." forState:MJRefreshStateRefreshing];
//    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
//    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    //一些其他属性设置
    /*
     // 设置字体
     self.stateLabel.font = [UIFont systemFontOfSize:15];
     self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
     
     // 设置颜色
     self.stateLabel.textColor = [UIColor redColor];
     self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
     // 隐藏时间
     self.lastUpdatedTimeLabel.hidden = YES;
     // 隐藏状态
     self.stateLabel.hidden = YES;
     // 设置自动切换透明度(在导航栏下面自动隐藏)
     self.automaticallyChangeAlpha = YES;
     */
    
}
//如果需要自己重新布局子控件
- (void)placeSubviews{
    [super placeSubviews];
    
    //如果需要自己重新布局子控件，请在这里设置

}
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}
-(NSArray *)stateLabelDataArray
{
    if (!_stateLabelDataArray) {
        _stateLabelDataArray = @[@""];
//        _stateLabelDataArray = @[@"如果你没有做好承受痛苦的准备，那就离开吧！",
//                                 @"不买落后股，不买平庸股，锁定领导股！",
//                                 @"有时成功的投资需要按兵不动。",
//                                 @"永远不要问理发师你是否需要理发。",
//                                 @"风险来自你不知道自己正在做什么！",
//                                 @"如开始就成功，就不要另觅他途。",
//                                 @"我只做我完全明白的事。",
//                                 @"不能承受股价下跌50%的人就不应该炒股。",
//                                 @"承担风险，但同时记住千万不能孤注一掷！",
//                                 @"买其所值，卖其疯狂。",
//                                 @"静坐观望，永远耐心地等候投资机会的来临。",
//                                 @"我从来不在我不懂的事情上投入大量的金钱。",
//                                 @"我从来没有见过能够预测市场走势的人。",
//                                 @"顺大势者昌，逆大势者亡。",
//                                 @"涨势形成不得不涨，跌势形成不得不跌。",
//                                 @"通道堵塞赶紧溜，通道不堵就不走。",
//                                 @"高位十字星，不走变穷人。",
//                                 @"周k线走出第三次金叉，买入此股就发家。",
//                                 @"周k线的一个价托涨三个月。",
//                                 @"能量朝稳步走高，五线向上牵大牛。",
//                                 @"能量朝高走前面，日后股价节节高。",
//                                 @"三阴灭不了一阳，后市要看涨。",
//                                 @"一阳吞没了十阴，黄土变成金。",
//                                 @"一旦冲破压力线，托着股价上天庭。",
//                                 @"上山爬坡缓慢走，烘云托月是小牛。",
//                                 @"大牛变疯牛，天量到了头。",
//                                 @"看家十字星，脚底须抹油。",
//                                 @"地量见地价，先有地量，后有地价。",
//                                 @"价值发现在于地量里。",
//                                 @"底部跳空向上走，天打雷劈不放手。",
//                                 @"高位跳空向上走，神仙招手却不留。",
//                                 @"60天均线向下走，神仙想留却犯愁。",
//                                 @"此时卖掉损失小，斤斤计较必深套。",
//                                 @"买入前要小心求证，买入时要三思而行。",
//                                 @"卖出时要决心果断，卖出后要经常看看。",
//                                 @"耐不住寂寞，拿不住钞票。",
//                                 @"该出手时就出手。",
//                                 @"感情用事是股市中的致命伤。",
//                                 @"股市未来从来都是不确定的。",
//                                 @"投资者重红利，投机者重消息。",
//                                 @"久盘必跌。",
//                                 @"长线是纸，短线是金,投机市如此。",
//                                 @"以市场为师，践学不悔，敏学不倦，谦学不怠。",
//                                 @"多也赚钱，空也赚钱，唯独贪心的人例外。",
//                                 @"对股市的短期预测是毒药。",
//                                 @"赚钱的空间是跌出来的。",
//                                 @"反弹不是底，是底不反弹。",
//                                 @"股市不是天天能赚钱的地方。",
//                                 @"最佳的赢利方法就是跟随趋势。",
//                                 @"个股的底是砸出来的，顶是累出来的。",
//                                 @"在低位重复放量却不走，是买股的一大忌。",
//                                 @"卖票最好在中长阳中。",
//                                 @"短线变中线，中线变长线，长线变贡献。",
//                                 @"没有只跌不涨的股市，也没有只涨不跌的股市。",
//                                 @"大户变中户，中户变散户，散户光屁股。",
//                                 @"股市投资的第一技术是避险。",
//                                 @"投机像山岳一样古老。",
//                                 @"弃我取，人取我予。",
//                                 @"买入靠信心，持有靠耐心，卖出靠决心。",
//                                 @"只有持股才能赚大钱。",
//                                 @"企业价值决定股票长期价格。",
//                                 @"远离市场，远离人群。",
//                                 @"不知深浅切勿下水；不懂股性切勿入市。",
//                                 @"看大方向赚大钱，看小方向赚小钱。",
//                                 @"多头空头皆可赚，惟有贪心赚不成。",
//                                 @"选股不如选时，善买不如善卖。",
//                                 @"买股票与其追高不如低吸。",
//                                 @"伏久者飞必高，开先者谢独早。",
//                                 @"大涨之后不买，大跌之后不卖。",
//                                 @"利多出尽不涨必跌，利空出尽不跌必涨。",
//                                 @"分次买，不赔钱；一次买，多赔钱。",
//                                 @"牛市时人人是专家，熊市时个个是输家。",
//                                 @"抄底逃顶，高抛低吸。",
//                                 @"选股如选美。",
//                                 @"长线买公司，中线买趋势，短线买庄家。",
//                                 @"不会念经，别当和尚；不懂K线，别当股民。",
//                                 @"编筐编篓，重在收口；买股持股，终在卖股。",
//                                 @"炒股如种粮，春播秋收冬藏。",
//                                 @"鸡蛋不要放在一只篮子里。",
//                                 @"吃鱼吃中段，头尾留别人。",
//                                 @"割肉空仓，赚钱不慌。",
//                                 @"手中有股，心中无股。",
//                                 @"新手怕大跌，老手怕大涨。",
//                                 @"利好出尽是利空，利空出尽是利好。",
//                                 @"横有多长，竖有多高。",
//                                 @"守住30线，炒股不赔钱。",
//                                 @"顶部３日，底部百天。",
//                                 @"小阳，小阳，必有长阳。",
//                                 @"牛市不言顶，熊市不言底。",
//                                 @"暴涨不买，暴跌不卖。",
//                                 @"炒股要炒强，赚钱靠头羊。",
//                                 @"反弹不是底，是底不反弹。",
//                                 @"涨时重势，跌时重质。",
//                                 @"牛市除权火上浇油，熊市除权雪上加霜。",
//                                 @"贪婪和恐惧是股市的双轮驱动。",
//                                 @"股性是否活跃，是选股的重要标准之一。",
//                                 @"当潮水退去之后，你才会发现谁在裸泳。",
//                                 @"山不在高，有仙则名；股不在好，有庄则升。",
//                                 @"股市的下跌如一月份的暴风雪是正常现象。",
//                                 @"不断的减少交易。",
//                                 @"专业选手检测风险，业余选手检测潜力。",
//                                 @"看不懂、看不准、没把握时坚决不进场。",
//                                 @"君子问凶不问吉，高手看盘先看跌。",
//                                 @"买股时勿冲动，卖股时要果断。",
//                                 @"最大的利好是跌过头，最大的利空是涨过头。",
//                                 @"忙于工作的股民，不妨选择定量定时投资法。",
//                                 @"不在大涨之后买进，不在大跌之后卖出。",
//                                 @"总股本少的公司股票，容易产生。",
//                                 @"谁笑到最后，谁赔得最惨。",
//                                 @"避免在'鸡犬升天'的市场中久留。",
//                                 @"凡领先股市上涨的股票，必会领先大势下跌",
//                                 @"成交量激增，价位不动，是股市近顶的讯号。",
//                                 @"炒股六分心态，三分技巧，一分运气。",
//                                 @"大跌胆要大；大涨胆要小。",
//                                 @"基本面决定技术面，技术面能提前反映基本面。",
//                                 @"控制风险是投资成功的前提。",
//                                 @"该跌不跌，理应看涨；该涨不涨，理应看跌。",
//                                 @"先战胜自己，然后战胜庄家。",
//                                 @"交易之道，守不败之地，攻可赢之敌。",
//                                 @"不要担心错失机会，善猎者必善等待。",
//                                 @"跟党走，听党的话，做一个会赚钱的好股民。",
//                                 @"看不懂、看不准、没把握时坚决不进场。",
//                                 @"君子问凶不问吉，高手看盘先看跌。",
//                                 @"自古圣者皆寂寞，惟有忍者能其贤。",
//                                 @"最大的利好是跌过头，最大的利空是涨过头。",
//                                 @"止损， 越止越损， 止赢，越止越赢。",
//                                 @"第一看趋势，第二看趋势，第三是不看趋势。",
//                                 @"戴花要戴大红花， 骑马要骑千里马。",
//                                 @"大涨小调，小涨不调，不涨大调。",
//                                 @"处于涨势或者跌势的时候，其趋势一般将延续。",
//                                 @"跌有多深则涨也将会有多高；量足则价升。",
//                                 @"价窄而量缩往往预示着大行情的来临。",
//                                 @"行情发展到极端状态时将朝着它的反向运行。",
//                                 @"当长期和短期的趋势都一致时其威力最大。",
//                                 @"当短期和长期趋势发生矛盾时可能会变盘。",
//                                 @"当买入的成本小于市场成本时风险较小。",
//                                 @"牛市不言顶，熊市不言底。",
//                                 @"多头不死，跌势不止；空头不死，涨势不止。",
//                                 @"涨要涨过头，跌要跌过头。",
//                                 @"天量之后出天价，地量之后出地价。",
//                                 @"横起来有多长，竖起来有多高。",
//                                 @"牛市慢涨急跌，熊市急涨慢跌。",
//                                 @"该涨不涨必有下跌，该跌不跌必有上涨。",
//                                 @"利好出尽是利空，利空出尽是利好。",
//                                 @"大涨三日不追，大跌三日不杀，跳三空气数尽。",
//                                 @"强者更强，弱者更弱。",
//                                 @"涨时重势，跌时重质。",
//                                 @"牛市不杀跌，熊市不追涨。",
//                                 @"买入靠信心，持有靠耐心，卖出靠决心。",
//                                 @"人弃我取，人取我予。",
//                                 @"市场没有专家，只有赢家和输家。",
//                                 @"反弹不是底，是底不反弹。",
//                                 @"不怕下跌而怕放量，尤其是在相对高位放巨量。",
//                                 @"股市上什么都能骗人，唯有成交量不能骗人。",
//                                 @"有庄的股是个宝，无庄的股是棵草。",
//                                 @"会买的是徒弟，会卖的才是师傅。",
//                                 @"底部买入，不动如山。",
//                                 @"别人恐惧时我贪婪，别人贪婪时我恐惧。",
//                                 @"新手看价，老手看量，高手看势。",
//                                 @"先学会做空，再学会做多。",
//                                 @"君子问凶不问吉，高手看盘先看跌。",
//                                 @"长线是金，短线是银，波段操作是钻石。",
//                                 @"股性是否活跃，是选股的重要标准之一。",
//                                 @"当媒体的观点一边倒时，应冷静地站到对立面。",
//                                 @"耐心是致胜的关键，信心是成功的保障。",
//                                 @"老手多等待，新手多无耐。",
//                                 @"英雄是时代的产物，龙头是行情的需要。",
//                                 @"下降通道抢反弹，无异于刀口舔血。",
//                                 @"适可而止，见好就收，一旦有变，落袋为安。",
//                                 @"买股时勿冲动，卖股时要果断。",
//                                 ];
        [[NSUserDefaults standardUserDefaults]setObject:_stateLabelDataArray forKey:StateLabelDataArray];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return _stateLabelDataArray;
}

@end
