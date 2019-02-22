//
//  VersionExplainViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "VersionExplainViewController.h"
#import "VersionExplainCell.h"
#import "VersionEmptyHeader.h"
#import "VersionExplainChildCollectionView.h"

#define kVersionExplainCell @"VersionExplainCell"
#define kVersionEmptyHeader @"VersionEmptyHeader"

@interface VersionExplainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *versionExplainCollectionV;
@property (nonatomic,strong)NSArray *arr;
@end

@implementation VersionExplainViewController



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.versionExplainCollectionV viewcornerRadius:5 * kWidthScall borderWith:0.01 clearColor:NO];
    [self.versionExplainCollectionV registerNib:[UINib nibWithNibName:kVersionExplainCell bundle:nil] forCellWithReuseIdentifier:kVersionExplainCell];
    [self.versionExplainCollectionV registerNib:[UINib nibWithNibName:kVersionEmptyHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kVersionEmptyHeader];
    self.arr =  @[@"1.AAAAAAA",@"2.BBBBBB",@"3.CCCCCC",@"4.DDDDDDD",@"5.EEEEEE"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VersionExplainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVersionExplainCell forIndexPath:indexPath];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //itemSize
    layout.itemSize = CGSizeMake(285 * kWidthScall, 17 * kWidthScall);
    //间距
    layout.sectionInset = UIEdgeInsetsZero;
    //最小行间距
    layout.minimumLineSpacing = 5 * kWidthScall;
    //最大行间距
    layout.minimumInteritemSpacing = 0;
    
    UIView *view = [cell viewWithTag:188];
    if (view) {
        [view removeFromSuperview];
    }
    VersionExplainChildCollectionView *cv = [[VersionExplainChildCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout data:self.arr];
    cv.tag = 188;
    [cell.subviews[0] addSubview:cv];
    
    [cell viewcornerRadius:5*kWidthScall borderWith:0.01 clearColor:YES];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    VersionEmptyHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kVersionEmptyHeader forIndexPath:indexPath];
    return header;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(357 * kWidthScall, (148 + 17*self.arr.count) * kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0 , 0, 7 * kWidthScall, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(357*kWidthScall, 161 * kWidthScall);
}

- (IBAction)versionExplainVCBackBtnClick:(id)sender {
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
