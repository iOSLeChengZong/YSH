//
//  ShareOrderChildViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "ShareOrderChildViewController.h"
#import "ShareOrderCell.h"
#import "ShareOrderHeadreView.h"

#define kShareOrderCell @"ShareOrderCell"
#define kShareOrderHeadreView @"ShareOrderHeadreView"

@interface ShareOrderChildViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *shareOrderCollectionV;

@end

@implementation ShareOrderChildViewController


#pragma mark -- 懒加载
-(UICollectionView *)shareOrderCollectionV{
    if (!_shareOrderCollectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        NSLog(@"collectionViewY%lf",self.collectionViewY);
        _shareOrderCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - self.collectionViewY) collectionViewLayout:layout];
        _shareOrderCollectionV.backgroundColor = kViewBGColor;
        
        _shareOrderCollectionV.delegate = self;
        _shareOrderCollectionV.dataSource = self;
        
        //itemSize
        layout.itemSize = CGSizeMake(357 * kWidthScall, 63 * kWidthScall);
        //间距
        layout.sectionInset = UIEdgeInsetsMake(3 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5, 6 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5);
        //最小行间距
        layout.minimumLineSpacing = 3;
        //最大行间距
        layout.minimumInteritemSpacing = 0;
        //头部视图大小
        layout.headerReferenceSize = CGSizeMake(357 * kWidthScall, 30 * kWidthScall);
        layout.sectionHeadersPinToVisibleBounds = YES;
        
        //注册cell
        [_shareOrderCollectionV registerNib:[UINib nibWithNibName:kShareOrderCell bundle:nil] forCellWithReuseIdentifier:kShareOrderCell];
        [_shareOrderCollectionV registerNib:[UINib nibWithNibName:kShareOrderHeadreView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kShareOrderHeadreView];
        
        [self.view addSubview:_shareOrderCollectionV];
        
        
    }
    return _shareOrderCollectionV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    [self addHeaderAndFooterRefresh];
    [self.shareOrderCollectionV reloadData];
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,%ld",[self class],indexPath.row);
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareOrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShareOrderCell forIndexPath:indexPath];
    return cell;
}


// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ShareOrderHeadreView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kShareOrderHeadreView forIndexPath:indexPath];
    return headerV;
}


-(void)requestStr:(NSString *)prameter{
    
}

-(void)addHeaderAndFooterRefresh{
    [self.view showBusyHUD];
    WK(weakSelf)
    //添加头部刷新
    [self.shareOrderCollectionV addHeaderRefreshingBlock:^{
//        weakSelf.requestMode = InviteReRecordRequestModeRefresh;
//        [weakSelf requestData];
        [weakSelf.view hideBusyHUD];
        
    }];
    
    //添加脚部刷新
    [self.shareOrderCollectionV addFooterBackRefresh:^{
//        weakSelf.requestMode = InviteReRecordRequestModeMore;
//        [weakSelf requestData];
        [weakSelf.view hideBusyHUD];
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
