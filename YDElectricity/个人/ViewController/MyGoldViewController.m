//
//  MyGoldViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "MyGoldViewController.h"
#import "MyGoldReusableView.h"
#import "GoldTaskCollectionViewCell.h"

#define kMyGoldReusableView @"MyGoldReusableView"
#define kGoldTaskCollectionViewCell @"GoldTaskCollectionViewCell"


@interface MyGoldViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *goldCollectionView;

@end

@implementation MyGoldViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"====%@",self.navigationController.navigationBar.hidden ? @"隐藏":@"没有隐藏");
    [self goldCollectionViewRegisterCell];
}

- (IBAction)popVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)goldCollectionViewRegisterCell{
    [self.goldCollectionView registerNib:[UINib nibWithNibName:kMyGoldReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMyGoldReusableView];
    [self.goldCollectionView registerNib:[UINib nibWithNibName:kGoldTaskCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kGoldTaskCollectionViewCell];
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,---%ld",[self class],indexPath.row);
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoldTaskCollectionViewCell *cell = [self.goldCollectionView dequeueReusableCellWithReuseIdentifier:kGoldTaskCollectionViewCell forIndexPath:indexPath];
//    cell.nameImage.image = [UIImage imageNamed:self.cellImageNames[indexPath.row]];
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MyGoldReusableView *header = [self.goldCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMyGoldReusableView forIndexPath:indexPath];
//    CGRect frame = header.frame;
//    frame.origin.y -= STATUS_BAR_HEIGHT;
//    header.frame = frame;
    return header;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW, 63);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(7, 0, 3, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, 155);
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
