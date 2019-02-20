//
//  MyIdentifyViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "MyIdentifyViewController.h"
//#import "IdentityTopReusableView.h"
#import "IdentityDefaultReusableView.h"
#import "IdentityCell.h"
#import "MyPrerogativeModel.h"
#import "TYAttributedLabel.h"

#define kIdentityDefaultReusableView @"IdentityDefaultReusableView"
#define kIdentityCell @"IdentityCell"
#define kItmeWidth (355 / 3) * kWidthScall

@interface MyIdentifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (nonatomic,strong)MyPrerogativeModel *prerogativeModel;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionVWidthC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightC;






@end

@implementation MyIdentifyViewController

#pragma mark -- 懒加载
- (MyPrerogativeModel *)prerogativeModel{
    if (!_prerogativeModel) {
        _prerogativeModel = [[MyPrerogativeModel alloc] init];
    }
    return _prerogativeModel;
}


#pragma mark -- 生命周期
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.backgroundColor = kViewBGColor;
    
    
    self.collectionV.backgroundColor = kViewBGColor;
    self.collectionVWidthC.constant *= kWidthScall;
    self.collectionHeightC.constant *= kWidthScall;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self registerCell];

}

-(void)registerCell{
//    [self.collectionV registerNib:[UINib nibWithNibName:@"IdentityTopReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IdentityTopReusableView"];
    [self.collectionV registerNib:[UINib nibWithNibName:@"IdentityDefaultReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IdentityDefaultReusableView"];
    [self.collectionV registerNib:[UINib nibWithNibName:@"IdentityCell" bundle:nil] forCellWithReuseIdentifier:@"IdentityCell"];
}

- (IBAction)dismissViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- UICollectionViewDelegate
//选择某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,%ld",[self class],indexPath.row);
}

#pragma mark -- UICollectionViewDataSource
//每个分区item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return self.prerogativeModel.prerogativeNames.count;
}

//cell样式
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IdentityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentityCell forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:self.prerogativeModel.prerogativeImageNames[indexPath.row]];
    cell.label.text = self.prerogativeModel.prerogativeNames[indexPath.row];
    return cell;
}

//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    IdentityDefaultReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kIdentityDefaultReusableView forIndexPath:indexPath];
    return head;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return CGSizeMake(kItmeWidth, kItmeWidth);
}
//分区之间的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1*kWidthScall, 0, 1*kWidthScall, 0);
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//header的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
   return CGSizeMake(357 * kWidthScall, 50 * kWidthScall);
    
}
//footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
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
