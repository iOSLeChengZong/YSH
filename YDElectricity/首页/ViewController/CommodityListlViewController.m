//
//  CommodityListlViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "CommodityListlViewController.h"
#import "MenuHeaderView.h"
#import "HomeProductCell.h"

#import "HomeProductCellOne.h"
#import "TaoBaoCustomerDetailViewController.h"


#define kHomeProductCell @"HomeProductCell"
#define kHomeProductCellOne @"HomeProductCellOne"

@interface CommodityListlViewController ()<MenuHeaderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *commodityListCollectionView;

@property (nonatomic,strong) HomeViewModel *homeVM;
@property (nonatomic,assign) HotOrRecomend hotOrRecomend;
@property (nonatomic,assign) HomeRequestMode requestMode;
@property (nonatomic,assign) BOOL isVertical;

//请求字段
@property(nonatomic,strong) NSString *requestWord;
//请求参数
@property(nonatomic,strong) NSString *requestPram;

@end

@implementation CommodityListlViewController

#pragma mark -- 懒加载
-(UICollectionView *)commodityListCollectionView{
    
    if (!_commodityListCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _commodityListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 44,kScreenW,kScreenH - NAVIGATION_BAR_HEIGHT -44) collectionViewLayout:layout];
        _commodityListCollectionView.backgroundColor = kViewBGColor;
       
        _commodityListCollectionView.delegate = self;
        _commodityListCollectionView.dataSource = self;
        
        if (!_isVertical) {
            //itemSize
            layout.itemSize = CGSizeMake(357 * kWidthScall,kWidthScall * 133);
            //间距
            layout.sectionInset = UIEdgeInsetsMake(3 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5, 6 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5);
            //最小行间距
            layout.minimumLineSpacing = 3;
            //最大行间距
            layout.minimumInteritemSpacing = 0;
            
            //注册cell
            [_commodityListCollectionView registerNib:[UINib nibWithNibName:kHomeProductCell bundle:nil] forCellWithReuseIdentifier:kHomeProductCell];
        }else{
            //itemSize
            layout.itemSize = CGSizeMake(176 * kWidthScall,kWidthScall * 280);
            
            //间距
            layout.sectionInset = UIEdgeInsetsMake(4, (kScreenW - 2 * layout.itemSize.width)/3 , 6 , (kScreenW - 2 * layout.itemSize.width)/3);
            //最小行间距
            layout.minimumLineSpacing = 3;
            //最小行间距
            layout.minimumInteritemSpacing = 5;
            
            //注册cell
            [_commodityListCollectionView registerNib:[UINib nibWithNibName:kHomeProductCellOne bundle:nil] forCellWithReuseIdentifier:kHomeProductCellOne];
        }
        
        
    }
    return _commodityListCollectionView;
}


-(HomeViewModel *)homeVM
{
    if (!_homeVM) {
        _homeVM = [HomeViewModel new];
    }
    return _homeVM;
}

#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MenuHeaderView *headerView = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, 44)];
    headerView.delegate = self;
    
    [self.view addSubview:headerView];
    
    [self.view addSubview:self.commodityListCollectionView];
    
    self.requestMode = HomeRequestModeRefresh;
    self.hotOrRecomend = HotOrRecomendR;
    self.requestWord = @"complex_order_by";
    self.requestPram = @"coupon_price_desc";
    
    //请求数据
    [self requestData];
    
    //添加头部脚部刷新
    [self addHeaderAndFooterRefresh];
    
    
   
}


#pragma mark -- MenuHeaderViewDelegate
- (NSArray<MenuModel *> *)dataSourceOfView:(MenuHeaderView *)headerView
{
    NSMutableArray *list = [NSMutableArray array];
    NSArray *arr = @[@"综合",@"券后价",@"销量",@""];
    for (int i=0; i<arr.count; i++) {
        MenuModel *model = [[MenuModel alloc] init];
        model.title = arr[i];
        model.index = i;
        if (i==0 ) {
            model.imageType = ImageTypeList;
            model.listData = @[@"综合排序",@"优惠券面值由高到低",@"优惠券面值由低到高",@"预估佣金由高到低"];
            model.requestWord = @"complex_order_by";
            model.requestParameters = @[@"coupon_price_desc",@"coupon_price_desc",@"coupon_price_asc",@"commission_desc"];
        }
        if (i==1) {
            model.imageType = ImageTypeUpAndDown;
            model.requestWord = @"qhPrice_order_by";
            model.requestParameters = @[@"desc",@"asc"];
        }
        if (i==2) {
            model.imageType = ImageTypeUpAndDown;//ImageTypeNone;
            model.requestWord = @"volume_order_by";
            model.requestParameters = @[@"desc",@"asc"];
        }
        if (i==3) {
            model.imageType = ImageTypeChoose;
        }
        [list addObject:model];
    }
    
    return list;
}

- (void)didSelectedIndexPath:(GXIndexPath *)indexPath imageType:(ButtonImageType)imageType forView:(nonnull MenuHeaderView *)headerView
{
    NSArray *list = [self dataSourceOfView:headerView];
    MenuModel *model = list[indexPath.column];
    if (model.imageType == ImageTypeList) {
        //获取请求字段 和请求参数
        NSLog(@"当前点击的是== %@ ,%@",model.title,model.listData[indexPath.row]);
        self.requestWord = model.requestWord;
        self.requestPram = model.requestParameters[indexPath.row];
        [self requestData];
    }else if (model.imageType == ImageTypeUpAndDown) {
        NSLog(@"当前点击的是== %@ ,%@",model.title,indexPath.row == 0 ? @"上" : @"下");
        self.requestWord = model.requestWord;
        self.requestPram = model.requestParameters[indexPath.row == 0 ? 0 : 1];
        NSLog(@"requestPram:%@",model.requestParameters[indexPath.row == 0 ? 0 : 1]);
        [self requestData];
    }else{
        NSLog(@"当前点击的是布局== %@",model.title);
        self.isVertical = !self.isVertical;
        [self resetCollectionViewLayout];
    }
    
}

- (void)didChooseCompletionWithData:(NSArray *)array
{
    NSLog(@"筛选条件= %@",array);
}



#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[self class]);
    //跳转淘宝客
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
    TaoBaoCustomerDetailViewController *taoBaoVc = [storyboard instantiateViewControllerWithIdentifier:@"TaoBaoCustomerDetailViewController"];
    TaoBaoKeDetailViewModel *tbkVM = [[TaoBaoKeDetailViewModel alloc] initWithPageList:self.homeVM.pageList[indexPath.row]];
    taoBaoVc.tbkVM =  tbkVM;
    [self.navigationController pushViewController:taoBaoVc animated:YES];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"------%ld",[self.homeVM goodCollectionVItemNum]);
    return [self.homeVM goodCollectionVItemNum];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isVertical) {
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
    }else{
        HomeProductCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeProductCellOne forIndexPath:indexPath];
        [cell viewcornerRadius:5 borderWith:0.02 clearColor:NO];
        //商品主图
        [cell.productImageView viewcornerRadius:5 borderWith:0.02 clearColor:NO];
        [cell.productImageView sd_setImageWithURL:[self.homeVM goodCollectionVItemImageURLAtIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@""]];
        //商品标题
        cell.productTitleLabel0.text = [self.homeVM goodCollectionVItemMainTitleAtIndexPath:indexPath];
        //商品优惠
        cell.productTitleLabel1.text = [self.homeVM goodCollectionVItemSecondTitleAtIndexPath:indexPath];
        //商品原价  贯穿线
        cell.productFromMoneyLabel.text = [self.homeVM goodCollectionVItemSoursePriceAtIndexPath:indexPath];
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:cell.productFromMoneyLabel.text];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        cell.productFromMoneyLabel.attributedText = newPrice;
        
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



#pragma mark -- 方法
-(void)requestData{
    [self.view showBusyHUD];
    WK(weakSelf)
    [self.homeVM getCommodityModelDataRequestMode:self.requestMode requestWord:self.requestWord requestPram:self.requestPram goodListState:self.listState classID:self.goodID pageSize:20 CompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf.commodityListCollectionView reloadData];
            [weakSelf.commodityListCollectionView endHeaderRefresh];
            [weakSelf.commodityListCollectionView endFooterRefresh];
            [weakSelf.view hideBusyHUD];
        }
    }];
}

-(void)addHeaderAndFooterRefresh{
    WK(weakSelf)
    //添加头部刷新
    [self.commodityListCollectionView addHeaderRefreshingBlock:^{
        weakSelf.requestMode = HomeRequestModeRefresh;
        [weakSelf requestData];
        
    }];
    
    //添加脚部刷新
    [self.commodityListCollectionView addFooterBackRefresh:^{
        weakSelf.requestMode = HomeRequestModeMore;
        if (weakSelf.homeVM.pageNum == weakSelf.homeVM.totalPage) {
            [weakSelf.commodityListCollectionView endFooterRefresh];
            return ;
        }
        
        [weakSelf requestData];
    }];
}


- (void)resetCollectionViewLayout{
    [self.commodityListCollectionView removeFromSuperview];
     self.commodityListCollectionView = nil;
    [self.view addSubview:self.commodityListCollectionView];
    [self.commodityListCollectionView reloadData];
}

- (IBAction)CommodityListVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
