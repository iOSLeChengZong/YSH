//
//  FreqentlyQViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "FreqentlyQViewController.h"
#import "FreqentlyQModel.h"
#import "FrequentlyQHeader.h"
#import "FrequentlyQCell.h"

#define kFrequentlyQHeader @"FrequentlyQHeader"
#define kFrequentlyQCell @"FrequentlyQCell"

@interface FreqentlyQViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *frequentlyQCollectionView;


@property(nonatomic,strong)NSMutableArray<FreqentlyQModel *> *dataArray;
@end

@implementation FreqentlyQViewController
#pragma mark -- 懒加载

-(NSMutableArray<FreqentlyQModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 1; i < 6; ++i) {
            FreqentlyQModel *model = [FreqentlyQModel new];
            model.isOpen = NO;
            if (i == 1) {
                model.name = @"1.如何邀请成员注册到我的名下?";
                model.content = @"登陆进入APP,在\"个人中心\"进入\"推荐邀请\",把邀请码提供给注册好友填写,注册成功即成为团队成员.";
            }
           else if (i == 2) {
               model.name = @"2.获得资金如何体现?";
               model.content = @"登陆进入APP,在\"个人中心\"进入\"推荐邀请\",把邀请码提供给注册好友填写,注册成功即成为团队成员.";
            }
            else if (i == 3) {
                model.name = @"3.商品券怎么使用?";
                model.content = @"登陆进入APP,在\"个人中心\"进入\"推荐邀请\",把邀请码提供给注册好友填写,注册成功即成为团队成员.";
            }
            else if (i == 4) {
                model.name = @"4.如何开发票?";
                model.content = @"登陆进入APP,在\"个人中心\"进入\"推荐邀请\",把邀请码提供给注册好友填写,注册成功即成为团队成员.";
            }
            else if (i == 5) {
                model.name = @"5.资金到账没?";
                model.content = @"登陆进入APP,在\"个人中心\"进入\"推荐邀请\",把邀请码提供给注册好友填写,注册成功即成为团队成员.";
            }
           
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}


#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self frequentlyQVCRegisterCell];
}

#pragma mark -- 代理
#pragma mark == UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FreqentlyQModel *model = self.dataArray[section];
    if (model.isOpen) {
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FrequentlyQCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFrequentlyQCell forIndexPath:indexPath];
    cell.answerTextView.text = self.dataArray[indexPath.section].content;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataArray.count;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    FrequentlyQHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFrequentlyQHeader forIndexPath:indexPath];
    header.questionLabel.text = self.dataArray[indexPath.section].name;
    header.indexPath = indexPath;
    header.isOpen = self.dataArray[indexPath.section].isOpen;
    
    
//    if (header.isOpen) {
//        header.parentView.backgroundColor = kRGBA(253, 207, 218, 1.0);
//        header.indicatorImageView.transform = CGAffineTransformRotate(header.indicatorImageView.transform, M_PI / 2);
//    }else{
//        header.parentView.backgroundColor = [UIColor whiteColor];
//        header.indicatorImageView.transform = CGAffineTransformRotate(header.indicatorImageView.transform, M_PI / 2);
//    }
    WK(weakSelf)
    header.openblock = ^(NSIndexPath *indexPath) {
        [weakSelf openSection:indexPath];
    };
    header.closeblock = ^(NSIndexPath *indexPath) {
        [weakSelf closeSection:indexPath];
    };
    
    return header;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray[indexPath.section].isOpen) {
        return kItemSize;
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return kUIEdgeInsets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 56*kWidthScall);
}

- (IBAction)frequentltyQVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 方法
-(void)frequentlyQVCRegisterCell{
    [_frequentlyQCollectionView registerNib:[UINib nibWithNibName:kFrequentlyQCell bundle:nil] forCellWithReuseIdentifier:kFrequentlyQCell];
    [_frequentlyQCollectionView registerNib:[UINib nibWithNibName:kFrequentlyQHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFrequentlyQHeader];
}

- (void)openSection:(NSIndexPath *)indexPath{
    FreqentlyQModel *model = self.dataArray[indexPath.section];
    model.isOpen = !model.isOpen;

    [self.frequentlyQCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
}

- (void)closeSection:(NSIndexPath *)indexPath{
    FreqentlyQModel *model = self.dataArray[indexPath.section];
    model.isOpen = !model.isOpen;
    [self.frequentlyQCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
   
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
