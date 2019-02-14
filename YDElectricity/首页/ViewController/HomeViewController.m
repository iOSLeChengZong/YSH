//
//  HomeViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+ButtonToBarButtonItem.h"
#import "SearchBarView.h"
#import "HomeHeaderCollectionViewCell.h"
#import "HomeSectionHeaderView.h"
#import "HomeProductCell.h"
#import "CategoryViewController.h"
#import "HomeViewModel.h"
#import "InHomeHeaderCell.h"
#import "Factory.h"
#import "GSCustomNavBar.h"
#import "TaoBaoCustomerDetailViewController.h"
#import "CommodityListlViewController.h"
#import "SecondSkillViewController.h"
#import "YDAlertView.h"
#import "YDCustomButton.h"


#define kHomeHeaderCollectionViewCell @"HomeHeaderCollectionViewCell"
#define kHomeSectionHeaderView @"HomeSectionHeaderView"
#define kHomeProductCell @"HomeProductCell"
#define kInHomeHeaderCell @"InHomeHeaderCell"
#define kSecondSkillViewController @"SecondSkillViewController"
#define kCommodityListlViewController @"CommodityListlViewController"
#define kTaoBaoCustomerDetailViewController @"TaoBaoCustomerDetailViewController"



@interface HomeViewController ()<SearchBarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet GSCustomNavBar *topView;


@property (nonatomic,strong) HomeViewModel *homeVM;
@property (nonatomic,assign) HotOrRecomend hotOrRecomend;
@property (nonatomic,assign) HomeRequestMode requestMode;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewTopC;



@end

@implementation HomeViewController
{
    //根据alpha - 改变透明度的背景View
    UIView *_topBackView;
    
    //不被alpha影响 - 放控件的View
    UIView *_navigationView;
    
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UITextField *_textField;
    UIButton *_searchBtn;
    //顶部状态栏颜色
    UIStatusBarStyle _statusBarStyle;

}

#pragma mark -- 懒加载
-(HomeViewModel *)homeVM
{
    if (!_homeVM) {
        _homeVM = [HomeViewModel new];
    }
    return _homeVM;
}



#pragma mark -- 生命周期
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionViewTopC.constant = -STATUS_BAR_HEIGHT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareNavigation];
    
    self.collectionView.backgroundColor = kViewBGColor;
    self.topView.hidden = YES;
   
    self.navigationController.navigationBar.translucent = YES;
    
    //注册collectionViewCell
    [self collectionRegisterCell];
    self.requestMode = HomeRequestModeRefresh;
    self.hotOrRecomend = HotOrRecomendR;
    
    //请求数据
    [self.view showBusyHUD];
    [self requestData];

    //添加头部脚部刷新
    [self addHeaderAndFooterRefresh];
    //设置顶部导航栏
    [self setUpNavigagionItem];

}


#pragma mark -- SearchBarViewDelegate
-(void)searchBarSearchBtnClicked:(id)searchBarView{
    NSLog(@"SearchBarBtn被点击:%@",[searchBarView class]);
}

#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return [self.homeVM goodCollectionVItemNum];
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        HomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeHeaderCollectionViewCell forIndexPath:indexPath];
        [cell.collectionV registerNib:[UINib nibWithNibName:kInHomeHeaderCell bundle:nil] forCellWithReuseIdentifier:kInHomeHeaderCell];
        cell.homeVM = self.homeVM;
        WK(weakSelf)
        
        [cell addClickHandler:^(NSString * _Nonnull goodID, NSString * _Nonnull title, HomeHeaderPushModel pushModel) {
            if (pushModel == HomeHeaderPushModelGoodList) {
                UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
                CommodityListlViewController *CLVC = [storybord instantiateViewControllerWithIdentifier:kCommodityListlViewController];
                CLVC.title = title;
                CLVC.goodID = goodID;
                CLVC.listState = GoodListStateColumn;
                [weakSelf.navigationController pushViewController:CLVC animated:YES];
            }
            
            else if(pushModel == HomeHeaderPushModelSeconSkill){//秒杀商品
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDHome bundle:nil];
                SecondSkillViewController *skillVc = [storyboard instantiateViewControllerWithIdentifier:kSecondSkillViewController];
                [self.navigationController pushViewController:skillVc animated:YES];
                
                
            }
            
            else if (pushModel == HomeHeaderPushModelTaoBaoKeDetail){
                //跳转淘宝客
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDHome bundle:nil];
                TaoBaoCustomerDetailViewController *taoBaoVc = [storyboard instantiateViewControllerWithIdentifier:kTaoBaoCustomerDetailViewController];
                TaoBaoKeDetailViewModel *tbkVM = [[TaoBaoKeDetailViewModel alloc] initWithSpikeList:self.homeVM.goodSpikeMuArr[0]];
                tbkVM.isSpike = YES;
                taoBaoVc.tbkVM =  tbkVM;
                [self.navigationController pushViewController:taoBaoVc animated:YES];
            }
        }];
        return cell;
    }else{
        HomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeProductCell forIndexPath:indexPath];
        [cell viewcornerRadius:5 borderWith:0.02 clearColor:NO];
        
        //商品主图
        [cell.productImageView sd_setImageWithURL:[self.homeVM goodCollectionVItemImageURLAtIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@""]];
        //商品标题
        cell.productTitleLabel0.text = [self.homeVM goodCollectionVItemMainTitleAtIndexPath:indexPath];
        //商品优惠
        cell.productTitleLabel1.text = [self.homeVM goodCollectionVItemSecondTitleAtIndexPath:indexPath];
        //商品原价
        cell.productFromMoneyLabel.text = [self.homeVM goodCollectionVItemSoursePriceAtIndexPath:indexPath];
        //商品销量
        cell.saleNum.text = [self.homeVM goodCollectionVItemMonthSaleNumAtIndexPath:indexPath];
        //优惠券
        cell.productFromeSaleMoneyLabel.text = [self.homeVM goodCollectionVitemTicketPriceAtIndexPath:indexPath];
        //折后价
        cell.productAfterSaleMoneyLabel.text = [self.homeVM goodCollectionVItemAfterSalePriceAtIndexPath:indexPath];
        //收益
        cell.profitMoney.text = [self.homeVM goodCollectionVItemProfitAtIndexPath:indexPath];
        return cell;
    }
    
}

//分区数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}


//分区头部和脚部视图
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kHomeSectionHeaderView;
    }else{
        reuseIdentifier = kHomeSectionHeaderView;
    }
    
    HomeSectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [view viewcornerRadius:5 borderWith:0.01 clearColor:NO];
    [view addClickHandler:^(HomeRequestMode requestMode,HotOrRecomend hotOrRecomend) {
        
        if (/*self.requestMode == requestMode &*/ self.hotOrRecomend == hotOrRecomend) {
            return ;
        }
        self.requestMode = requestMode;
        self.hotOrRecomend = hotOrRecomend;
        //忙提示
        [self.view showBusyHUD];
        [self.homeVM getHomeGoodModelDataRequestMode:HomeRequestModeRefresh pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.view hideBusyHUD];
                return ;
            }
            [self.view showWarning:@"网络错误首页"];
        }];
        
    }];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
    
        
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        view.frame = CGRectZero;
        
    }
    
    return view;
}

#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath:%lu",indexPath.row);
    if (indexPath.section != 0) {
        //跳转淘宝客
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
        TaoBaoCustomerDetailViewController *taoBaoVc = [storyboard instantiateViewControllerWithIdentifier:@"TaoBaoCustomerDetailViewController"];
        TaoBaoKeDetailViewModel *tbkVM = [[TaoBaoKeDetailViewModel alloc] initWithPageList:self.homeVM.pageList[indexPath.row]];
        tbkVM.isSpike = NO;
        taoBaoVc.tbkVM =  tbkVM;
        [self.navigationController pushViewController:taoBaoVc animated:YES];
    }
   
}

#pragma mark -- collectionViewDelegateFlowLayout
//item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenW, 436 * kWidthScall);
    }
    return CGSizeMake(357 * kWidthScall, 133 * kWidthScall);
}

//分区之间间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0)
    {
        return UIEdgeInsetsMake(0/*-STATUS_BAR_HEIGHT*/,0, 6 * kHightScall, 0);
    }
    return UIEdgeInsetsMake(3 * kHightScall, (kScreenW - 357 * kWidthScall) * 0.5, 6 * kHightScall, (kScreenW - 357 * kWidthScall) * 0.5);
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//分区头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(357 * kWidthScall, 50*kWidthScall);
}

//分区脚部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark -- UIScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static CGFloat tagOffsetY = 300.0;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = offsetY / tagOffsetY;
    _topBackView.alpha = alpha;
    
    
    if (_topBackView.alpha >= 1) {
        
        //开始导航条变化
        //        _topBackView.backgroundColor = [UIColor darkGrayColor];
        [_rightBtn setImage:[UIImage imageNamed:@"y_h_shoppingCar0"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"y_h_sort0"] forState:UIControlStateNormal];
        _textField.backgroundColor = [UIColor whiteColor];
        _statusBarStyle = UIStatusBarStyleLightContent;
    }
    else{
        
        //默认导航条样式
        _topBackView.backgroundColor = [UIColor darkGrayColor];
        [_rightBtn setImage:[UIImage imageNamed:@"y_h_shoppingCar0"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"y_h_sort0"] forState:UIControlStateNormal];
        _textField.backgroundColor = [UIColor lightGrayColor];
        _statusBarStyle = UIStatusBarStyleDefault;
    }
    //设置状态栏刷新
    [self setNeedsStatusBarAppearanceUpdate];
    
}

//设置顶部状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return _statusBarStyle;
}

#pragma mark -- 方法
-(void)setUpNavigagionItem{
    //设置背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];

    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"y_h_sort2" highlightImageName:@"y_h_sort2" title:@"分类" target:self action:@selector(categoryBtnClick)];

    //设置右侧按钮 y_h_shoppingCar1  购物车
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"y_h_sort2" highlightImageName:@"y_h_sort2" title:@"分类" target:self action:@selector(shopCarBtnClick)];
    
    
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"y_h_sort2" highlightImageName:@"y_h_sort2" title:@"分类" target:self action:@selector(categoryBtnClick)];
//    self.navigationItem.rightBarButtonItems = [UIBarButtonItem LeftBarButtomItems:NO ImageName:@"y_h_shoppingCar1" highlightImageName:@"y_h_shoppingCar1" title:@"购物车" target:self action:@selector(shopCarBtnClick)];
    
    [Factory addSearchItemToVC:self clickHandler:^{
        NSLog(@"搜索被点击了");
        YDAlertView *allertView = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"即将开放!" confrimBolck:^{
            NSLog(@"点击了确认");
        } cancelBlock:^{
            NSLog(@"点击了取消");
        }];
        [allertView show];
    }];
    

}

-(void)categoryBtnClick{
    NSLog(@"首页分类按钮被点击了");
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
//    [self showViewController:cvc sender:nil];
    [self.navigationController pushViewController:cvc animated:YES];
    
}

-(void)shopCarBtnClick{
    NSLog(@"购物车按钮被点击了");
}


- (void)prepareNavigation{
    
    //0.背景View
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, kScreenW, NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:backView];
    _topBackView = backView;
    
    //1.naviView
    UIView *naviView = [[UIView alloc]init];
    naviView.frame = CGRectMake(0, STATUS_BAR_HEIGHT , kScreenW, NAVI_BAR_HEIGHT);
    [self.view addSubview:naviView];
    _navigationView = naviView;
    
    //2.左边按钮
    CGFloat btnW = 38;
    CGFloat btnH = 30;
    CGFloat btnY = 5;
    CGFloat leftMargin = 15;
    YDCustomButton *leftBtn = [[YDCustomButton alloc] initWithBtnFrame:CGRectMake(leftMargin, btnY, btnW, btnH) btnType:ButtonImageTop titleAndImageSpace:5 imageSizeWidth:0 imageSizeHeight:0];
    [leftBtn setImage:[UIImage imageNamed:@"y_h_sort0"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitle:@"分类" forState:UIControlStateNormal];
    WK(weakSelf)
    [leftBtn bk_addEventHandler:^(id sender) {
        [weakSelf categoryBtnClick];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [naviView addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    //3.右边按钮
    YDCustomButton *rightBtn = [[YDCustomButton alloc] initWithBtnFrame:CGRectMake(kScreenW - leftMargin - btnW, btnY, btnW, btnH) btnType:ButtonImageTop titleAndImageSpace:5 imageSizeWidth:0 imageSizeHeight:0];
    [rightBtn setImage:[UIImage imageNamed:@"y_h_shoppingCar0"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [rightBtn bk_addEventHandler:^(id sender) {
        YDAlertView *allertView = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"即将开放!" confrimBolck:^{
            NSLog(@"点击了确认");
        } cancelBlock:^{
            NSLog(@"点击了取消");
        }];
        [allertView show];
    } forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    //4.搜索框
    CGFloat searchTextFW = 200;
    CGFloat searchTextFH = 30;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake((kScreenW - searchTextFW)*0.5, (NAVI_BAR_HEIGHT - searchTextFH)*0.5, searchTextFW, searchTextFH);
    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang0"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang1"] forState:UIControlStateHighlighted];
    [naviView addSubview:btn];
    [btn bk_addEventHandler:^(id sender) {
        YDAlertView *allertView = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"即将开放!" confrimBolck:^{
            NSLog(@"点击了确认");
        } cancelBlock:^{
            NSLog(@"点击了取消");
        }];
        [allertView show];
    } forControlEvents:UIControlEventTouchUpInside];
    _searchBtn = btn;
}


-(void)collectionRegisterCell{
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeHeaderCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kHomeHeaderCollectionViewCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeSectionHeaderView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderView];
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeProductCell bundle:nil] forCellWithReuseIdentifier:kHomeProductCell];
}

-(void)addHeaderAndFooterRefresh{
    //添加头部刷新
    [self.collectionView addHeaderRefreshingBlock:^{
        [self requestData];
        
    }];
    
    //添加脚部刷新
    [self.collectionView addFooterBackRefresh:^{
        
        if (self.homeVM.pageNum == self.homeVM.totalPage) {
            [self.collectionView endFooterRefresh];
            return ;
        }
        [self.homeVM getHomeGoodModelDataRequestMode:HomeRequestModeMore pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
            
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endFooterRefresh];
            }
        }];
    }];
}

-(void)requestData{
    
    //请求头部数据
    [self.homeVM getHomeHeaderModelDataCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [self.homeVM getHomeGoodModelDataRequestMode:self.requestMode pageSize:20 state:self.hotOrRecomend CompletionHandler:^(NSError * _Nonnull error) {
                if (!error) {
                    [self.view hideBusyHUD];
                    [self.collectionView endHeaderRefresh];
                    [self.collectionView reloadData];

                }else{
                    [self.view showWarning:@"网络错误商品"];
                }
                
            }];

        }
      
    }];

}
     

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
}



@end
