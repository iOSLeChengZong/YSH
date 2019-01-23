//
//  TestViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/29.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "TestViewController.h"

#import "TestModel.h"

#import "YDIntroHeaderCell.h"
#import "YDPopTopOutView.h"
#import "YDAlertView.h"

@interface TestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) TestModel *tm;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tm = [TestModel new];
    NSLog(@"tm%ld:",self.tm.colorArr.count);
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDIntroHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"YDIntroHeaderCell"];
    [self.view addSubview:self.collectionView];
    
    //商品掉落从上向下弹出动画
//    YDPopTopOutView *popView = [[YDPopTopOutView alloc] initWithFrame:CGRectMake(25, -kScreenH, kScreenW -50, 500)];
//    [popView addAnimateViewFromTop];
    
    //弹出提示框
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 200, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn bk_addEventHandler:^(id sender) {
        YDAlertView *allertView = [[YDAlertView alloc] initWithFrame:CGRectMake(0, 0, 250, 170) withTitle:@"TTTT" alertMessage:@"该操作会注销IP：211.100.57.197  中国，北京 Chrome的登录状态，请确认。" confrimBolck:^{
            NSLog(@"点击了确认");
        } cancelBlock:^{
            NSLog(@"点击了取消");
        }];
        [allertView show];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}

#pragma mark -- UICollectionView Datasouce
//设置headerh和footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

//分区数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分区item数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

//每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YDIntroHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YDIntroHeaderCell" forIndexPath:indexPath];
    cell.colorArr = self.tm.colorArr;
    return cell;
}


#pragma mark -- UICollectionView Delegate
//点击item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark -- UICollectionView DelegateFlowLayout
//分区头尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

//item尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(kScreenW, kScreenW/ 375 * 207 + 110);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

////每个分区与其它控件的距离(上 \ 左 \ 下 \ 右)
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
