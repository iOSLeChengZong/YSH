//
//  MyOrderChildViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "MyOrderChildViewController.h"
#import "MyOrderCollectionViewCell.h"
#import "TaoBaoKeDetailViewModel.h"
#import "TaoBaoCustomerDetailViewController.h"
#import "UserOrderViewModel.h"
#import "UserIdendityViewModel.h"


#define kMyOrderCollectionViewCell @"MyOrderCollectionViewCell"


@interface MyOrderChildViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSString *requestStr;

@property(nonatomic,strong)UICollectionView *secondSkillcollecV;
@property (nonatomic,strong) HomeViewModel *homeVM;



@property (nonatomic,assign)OrderRequestMode orderRequestM;

@end

@implementation MyOrderChildViewController

#pragma mark -- 懒加载
-(UICollectionView *)secondSkillcollecV{
    
    if (!_secondSkillcollecV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _secondSkillcollecV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenW,kScreenH - NAVIGATION_BAR_HEIGHT - 50) collectionViewLayout:layout];
        _secondSkillcollecV.backgroundColor = kViewBGColor;
        
        _secondSkillcollecV.delegate = self;
        _secondSkillcollecV.dataSource = self;
        
        //itemSize
        layout.itemSize = CGSizeMake(357 * kWidthScall, 133 * kWidthScall);
        //间距
        layout.sectionInset = UIEdgeInsetsMake(3 * kHightScall, 9 * kWidthScall, 6 * kHightScall, 9 * kHightScall);
        //最小行间距
        layout.minimumLineSpacing = 3;
        //最大行间距
        layout.minimumInteritemSpacing = 0;
        
        //注册cell
        [_secondSkillcollecV registerNib:[UINib nibWithNibName:kMyOrderCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kMyOrderCollectionViewCell];
        
        [self.view addSubview:_secondSkillcollecV];
        
    }
    return _secondSkillcollecV;
}


-(UserOrderViewModel *)orderViewModel{
    if (!_orderViewModel) {
        _orderViewModel = [UserOrderViewModel new];
    }
    return _orderViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
}

#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.orderViewModel goodsNum];
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyOrderCollectionViewCell forIndexPath:indexPath];
    [cell viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [cell.mainImageView sd_setImageWithURL:[self.orderViewModel goodsImageURLAtIndexpath:indexPath]];
    cell.goodsTitle.text = [self.orderViewModel goodsTitleAtIndexpath:indexPath];
    cell.orderLabel.text = [self.orderViewModel orderNumAtIndexpath:indexPath];
    cell.orderTimeLabel.text = [self.orderViewModel orderTimeAtIndexpath:indexPath];
    cell.orderStateLabel.text = [self.orderViewModel orderStateAtIndexpath:indexPath];
    cell.afterDiscountLabel.text = [self.orderViewModel goodsPriceAtIndexpath:indexPath];
    cell.estimatePriceLabel.text = [self.orderViewModel estimateAwardAtIndexpath:indexPath];
    

    return cell;
    
    
}

//分区数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath:%lu",indexPath.row);
    if (indexPath.section != 0) {
        //跳转淘宝客
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
        TaoBaoCustomerDetailViewController *taoBaoVc = [storyboard instantiateViewControllerWithIdentifier:@"TaoBaoCustomerDetailViewController"];
//        TaoBaoKeDetailViewModel *tbkVM = [[TaoBaoKeDetailViewModel alloc] initWithPageList:self.orderViewModel.orderList[indexPath.row]];
//        taoBaoVc.tbkVM =  tbkVM;
        [self.navigationController pushViewController:taoBaoVc animated:YES];
    }
    
}

#pragma mark -- collectionViewDelegateFlowLayout
//item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(357 * kWidthScall, 133 * kWidthScall);
}

//分区之间间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(3*kWidthScall,(kScreenW - 357 * kWidthScall) * 0.5, 6*kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5);
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3 * kWidthScall;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


-(void)request{
    
    self.orderRequestM = OrderRequestModeRefresh;
    //请求数据
    [self requestData];
    //添加头部脚部刷新
    [self addHeaderAndFooterRefresh];
}

-(void)requestData{
    [self.view showBusyHUD];

    
    
    [self.orderViewModel getUserOrderListWithRequestMode:self.orderRequestM pageSize:20 orderMode:self.orderMode userPID:[[UserIdendityViewModel sharedUserIdendityModel] userPid] completionHandler:^(NSError * _Nonnull error) {
       
        
        if (!error) {
//            YDAlertView *alertV =  [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"请求数据" alertMessage:@"请求数据成功" confrimBolck:^{
//
//            } cancelBlock:^{
//
//            }];
//            [alertV show];
            [self.secondSkillcollecV reloadData];
            [self.view hideBusyHUD];
            [self.secondSkillcollecV endHeaderRefresh];
            [self.secondSkillcollecV endFooterRefresh];
            
        }else{
//            YDAlertView *alertV =  [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"请求数据" alertMessage:@"请求数据失败" confrimBolck:^{
//
//            } cancelBlock:^{
//
//            }];
//            [alertV show];
        }
    }];
}


-(void)addHeaderAndFooterRefresh{
    WK(weakSelf)
    //添加头部刷新
    [self.secondSkillcollecV addHeaderRefreshingBlock:^{
        weakSelf.orderRequestM = OrderRequestModeRefresh;
        [weakSelf requestData];
        
    }];
    
    //添加脚部刷新
    [self.secondSkillcollecV addFooterBackRefresh:^{
        weakSelf.orderRequestM = OrderRequestModeMore;
        [weakSelf requestData];
    }];
}
@end
