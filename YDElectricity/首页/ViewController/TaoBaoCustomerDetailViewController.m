//
//  TaoBaoCustomerDetailViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "TaoBaoCustomerDetailViewController.h"
#import "CustomerHeaderCell.h"
#import "DetailInfoCell.h"
#import "ShopDetailCell.h"
#import "ShareViewController.h"
#import "TaoBaoCustomerHTMLVC.h"

#define kCustomerHeaderCell @"CustomerHeaderCell"
#define kDetailInfoCell @"DetailInfoCell"
#define kShopDetailCell @"ShopDetailCell"
#define kTaoBaoCustomerHTMLVC @"TaoBaoCustomerHTMLVC"


@interface TaoBaoCustomerDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TaoBaoCustomerHTMLVCDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIView *server;
@property (weak, nonatomic) IBOutlet UIView *buyView;
@property (weak, nonatomic) IBOutlet UIView *shareView;


@end

@implementation TaoBaoCustomerDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionV.backgroundColor = kViewBGColor;
    [self registerCell];
 
}

#pragma mark -- UICollectionViewDelegate

//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"class:%@,indextPath:%lu",[self class],indexPath.row);
}


#pragma mark -- UICollectionViewDataSource
//每个分区有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

//每个item的外观
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0)
    {
        DetailInfoCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:kDetailInfoCell forIndexPath:indexPath];
        cell.imageName.image = [UIImage imageNamed:self.tbkVM.imageName];
        cell.title.text = self.tbkVM.title;
        cell.discountPrice.text = self.tbkVM.discountPrice;
        cell.originalPrice.text = self.tbkVM.originalPrice;
        cell.monthSaleNum.text = self.tbkVM.monthSaleNum;
        cell.couponPrice.text = self.tbkVM.couponPrice;
        cell.serviceLife.text = self.tbkVM.serviceLife;
        [cell viewcornerRadius:5 borderWith:0.05 clearColor:NO];
        [cell addClickHandler:^{
            //跳转网页
            //加载分享赚VC
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDHome bundle:nil];
            
            TaoBaoCustomerHTMLVC *htmlVC = [storyboard instantiateViewControllerWithIdentifier:kTaoBaoCustomerHTMLVC];
            htmlVC.navigationItem.title = @"详情";
//            htmlVC.taoBaoURL = [NSURL URLWithString:self.tbkVM.buyURL];
            htmlVC.delegate = self;
            htmlVC.taoBaoVM = self.tbkVM;
            [self.navigationController pushViewController:htmlVC animated:YES];
        }];
        
        return cell;
    }
    else{
        ShopDetailCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:kShopDetailCell forIndexPath:indexPath];
        [cell viewcornerRadius:5 borderWith:0.05 clearColor:NO];
        return cell;
    }
    
}

//复用视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    CustomerHeaderCell *header = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCustomerHeaderCell forIndexPath:indexPath];
    header.imageURLStringsGroup = self.tbkVM.imageURLS;
    if (!iPhoneX) {
        CGRect frame = header.frame;
        frame.origin.y -= STATUS_BAR_HEIGHT;
        header.frame = frame;
    }
    
    return header;

}

#pragma mark -- UICollectionViewDelegateFlowLayout
//每个item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //在这里对6以前的高度也要适配下
        return CGSizeMake(357 * kWidthScall, 180);
    }
    
    else{
        return CGSizeMake(357 * kWidthScall, 100);
    }
    
}

//分区间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
//
//
//    if (indexPath.row == 0) {
//        return UIEdgeInsetsZero;
//    }
    if (!iPhoneX) {
        return UIEdgeInsetsMake(-STATUS_BAR_HEIGHT+6, 9, 6, 9);
    }else{
        return UIEdgeInsetsMake(6, 9, 6, 9);
    }
    
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}

//头部复用大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(375 * kWidthScall, 407);
}
////脚部复用大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeZero;
//}

#pragma mark -- TaoBaoCustomerHTMLVCDelegate
-(void)GetModel:(TaoBaoKeDetailViewModel *)model{
    self.tbkVM = model;
}

#pragma mark -- 方法
-(void)registerCell{
    [self.collectionV registerNib:[UINib nibWithNibName:kCustomerHeaderCell bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCustomerHeaderCell];
    [self.collectionV registerNib:[UINib nibWithNibName:kDetailInfoCell bundle:nil] forCellWithReuseIdentifier:kDetailInfoCell];
    [self.collectionV registerNib:[UINib nibWithNibName:kShopDetailCell bundle:nil] forCellWithReuseIdentifier:kShopDetailCell];
}



//分享赚
- (IBAction)ShareTap:(UITapGestureRecognizer *)sender {
    NSLog(@"ShareTap:%@",sender.view);
    //加载分享赚VC
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
    
    ShareViewController *shareVC = [storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    shareVC.navigationItem.title = @"分享赚";
    if (self.tbkVM) {
        NSLog(@"数据不为空222%@",self.tbkVM.imageURLS[0]);
    }else{
        NSLog(@"数据是空的");
    }
    shareVC.tbkVM = self.tbkVM;
    [self.navigationController pushViewController:shareVC animated:YES];
}


//返回
- (IBAction)popViewVC:(id)sender {
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
