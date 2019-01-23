//
//  SecondSkillChildViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "SecondSkillChildViewController.h"
#import "SecondSkillCell.h"
#import "TaoBaoCustomerDetailViewController.h"
#import "SecondSkillColumnViewModel.h"

#define kSecondSkillCell @"SecondSkillCell"

@interface SecondSkillChildViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collecV;
@property (nonatomic,strong) SecondSkillColumnViewModel *secondVM;
@property (nonatomic,assign) SecondKillRequestMode requestMode;
@property (nonatomic,strong) NSString *time;


@end

@implementation SecondSkillChildViewController

#pragma mark -- 懒加载
- (UICollectionView *)collecV{
    if (!_collecV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collecV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenW,kScreenH - NAVIGATION_BAR_HEIGHT - 50) collectionViewLayout:layout];
        _collecV.backgroundColor = kViewBGColor;
        
        _collecV.delegate = self;
        _collecV.dataSource = self;
        
        //itemSize
        layout.itemSize = CGSizeMake((kScreenW - 18) * kWidthScall, 133);
        //间距
        layout.sectionInset = UIEdgeInsetsMake(3 * kHightScall, 9 * kWidthScall, 6 * kHightScall, 9 * kHightScall);
        //最小行间距
        layout.minimumLineSpacing = 3;
        //最大行间距
        layout.minimumInteritemSpacing = 0;
        
        //注册cell
        [_collecV registerNib:[UINib nibWithNibName:kSecondSkillCell bundle:nil] forCellWithReuseIdentifier:kSecondSkillCell];
        
        [self.view addSubview:_collecV];
        
        
    }
    return _collecV;
}

-(SecondSkillColumnViewModel *)secondVM{
    if (!_secondVM) {
        _secondVM = [SecondSkillColumnViewModel new];
    }
    return _secondVM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}



#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"??????%ld",[self.secondVM itemNumber]);
    return [self.secondVM itemNumber];//[self.homeVM goodCollectionVItemNum];
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        SecondSkillCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSecondSkillCell forIndexPath:indexPath];
        [cell viewcornerRadius:5 borderWith:0.02 clearColor:NO];

        //商品主图
        [cell.mainImage sd_setImageWithURL:[self.secondVM goodImageURLAtIndexPath:indexPath] placeholderImage:[UIImage imageNamed:@""]];
        //商品标题
        cell.title.text = [self.secondVM goodNameAtIndexPath:indexPath];
    
        //商品原价
        cell.originalPrice.text = [self.secondVM goodOriginalPriceAtIndexPath:indexPath];

        //现价
        cell.currentPrice.text = [self.secondVM goodCurrentPriceAtIndexPath:indexPath];
    
        //商品总量
        cell.totalNum.text = [self.secondVM goodTotalNumAtIndexPath:indexPath];
    
        //已抢购
        cell.currentNum.text = [self.secondVM goodCurrentNumAtIndexPath:indexPath];
    
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
//        TaoBaoKeDetailViewModel *tbkVM = [[TaoBaoKeDetailViewModel alloc] initWithPageList:self.secondVM.pageList[indexPath.row]];
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
    
    return UIEdgeInsetsMake(3 * kWidthScall, (kScreenW -357 * kWidthScall)*0.5, 6 * kWidthScall, (kScreenW -357 * kWidthScall)*0.5);
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3 * kWidthScall;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



//请求数据
-(void)requestData:(NSString *)parameter{
    self.time = parameter;
    self.requestMode = SecondKillRequestModeRefresh;
    
    //请求数据
    [self requestData];

    //添加头部脚部刷新
    [self addHeaderAndFooterRefresh];
    
}



-(void)addHeaderAndFooterRefresh{
    WK(weakSelf)
    //添加头部刷新
    [self.collecV addHeaderRefreshingBlock:^{
        weakSelf.requestMode = SecondKillRequestModeRefresh;
        [weakSelf requestData];
        
    }];
    
    //添加脚部刷新
    [self.collecV addFooterBackRefresh:^{
        weakSelf.requestMode = SecondKillRequestModeMore;
        [weakSelf requestData];
    }];
}

-(void)requestData{
    [self.view showBusyHUD];
    WK(weakSelf)

    [self.secondVM getSecondSkillListModelDataRequestMode:self.requestMode timeInterverl:self.time pageSize:20 completionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf.collecV reloadData];
            [weakSelf.collecV endHeaderRefresh];
            [weakSelf.collecV endFooterRefresh];
            [weakSelf.view hideBusyHUD];
        }
    }];
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
