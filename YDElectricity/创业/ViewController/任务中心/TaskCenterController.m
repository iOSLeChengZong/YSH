//
//  TaskCenterController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/15.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "TaskCenterController.h"
#import "HomeSectionHeaderView.h"
#import "TaskCell.h"
#import "GrowthRecordViewController.h"
#import "MyGoldViewController.h"
#import "UserTaskViewModel.h"

#define kHomeSectionHeaderView @"HomeSectionHeaderView"
#define kTaskCell @"TaskCell"
#define kGrowthRecordViewController @"GrowthRecordViewController"
#define kMyGoldViewController @"MyGoldViewController"

@interface TaskCenterController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *taskCollectionView;
@property (nonatomic,strong) UserTaskViewModel *taskViewVM;
@property (nonatomic,assign) USERTASKTYPE taskType;

@property (weak, nonatomic) IBOutlet UILabel *goldNamel;
@property (weak, nonatomic) IBOutlet UILabel *growthLabel;



@end

@implementation TaskCenterController

#pragma mark -- 懒加载
-(UserTaskViewModel *)taskViewVM{
    if (!_taskViewVM) {
        _taskViewVM = [UserTaskViewModel new];
    }
    return _taskViewVM;
}


#pragma mark -- 生命周期

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    self.taskCollectionView.backgroundColor = [UIColor clearColor];
    [self taskCenterRegisterCell];
//    [self.taskCollectionView addHeaderRefreshingBlock:^{
//
//    }];
//
//    [self.taskCollectionView addFooterBackRefresh:^{
//
//    }];
    self.taskType = USERTASKTYPENEWPLAYERTASK;
    self.goldNamel.text = [[VefifyRegisterViewModel sharedVefifyRegisterViewModel] userGold];
    self.growthLabel.text = [[VefifyRegisterViewModel sharedVefifyRegisterViewModel] userGrowth];
    [self retquestData];
}



#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.taskViewVM getTaskNum:self.taskType];
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTaskCell forIndexPath:indexPath];
    cell.taskNameLabel.text = [self.taskViewVM itemForTaskNameAtIndexPath:indexPath userTaskType:self.taskType];
    cell.growthLabel.text = [self.taskViewVM itemForGrowthAtIndexPath:indexPath userTaskType:self.taskType];
    cell.goldLabel.text = [self.taskViewVM itemForGoldAtIndexPath:indexPath userTaskType:self.taskType];
//    [cell.taskStateBtn setImage:[UIImage imageNamed:[self.taskViewVM itemForTastkCompletionStateAtIndexPath:indexPath userTaskType:self.taskType]] forState:UIControlStateNormal];
    return cell;
    
}


//分区头部和脚部视图
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HomeSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderView forIndexPath:indexPath];
    [header.introBtn setTitle:@"新手任务" forState:UIControlStateNormal];
    [header.hotBtn setTitle:@"日常任务" forState:UIControlStateNormal];
    
    WK(weakSelf)
    [header addClickHandler:^(HomeRequestMode requestMode,HotOrRecomend hotOrRecomend) {
        
        NSInteger type0 =  (NSInteger)hotOrRecomend;
        NSInteger type1 = (NSInteger)self.taskType;
        if (type0 == type1) {
            return;
        }
        
        if (hotOrRecomend == HotOrRecomendR) {
            self.taskType = USERTASKTYPENEWPLAYERTASK;
        }else{
            self.taskType = USERTASKTYPEDAILYTASK;
        }
        
        [weakSelf retquestData];

    }];
    
    return header;

}

#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark -- collectionViewDelegateFlowLayout
//item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return kItemSize;
}

//分区之间间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return kUIEdgeInsets;
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//分区头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    layout.sectionHeadersPinToVisibleBounds = YES;
    return CGSizeMake(357 * kWidthScall, 42*kWidthScall);
}

//分区脚部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}


#pragma mark -- 方法
-(void)taskCenterRegisterCell{
    [self.taskCollectionView registerNib:[UINib nibWithNibName:kTaskCell bundle:nil] forCellWithReuseIdentifier:kTaskCell];
    [self.taskCollectionView registerNib:[UINib nibWithNibName:kHomeSectionHeaderView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomeSectionHeaderView];
}

-(void)retquestData{
    WK(weakSelf)
    [self.view showBusyHUD];
    [self.taskViewVM getUserTaskCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf.taskCollectionView reloadData];
            [weakSelf.view hideBusyHUD];
        }
    }];
}

//任务中心金币Btn
- (IBAction)GoldBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    MyGoldViewController *goldVC = [storyboard instantiateViewControllerWithIdentifier:kMyGoldViewController];
    [self.navigationController pushViewController:goldVC animated:YES];
}



//任务中心成长值Btn
- (IBAction)growthBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    GrowthRecordViewController *growthVC = [storyboard instantiateViewControllerWithIdentifier:kGrowthRecordViewController];
    [self.navigationController pushViewController:growthVC animated:YES];
}



- (IBAction)taskCenterVCBackBtnClick:(id)sender {
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
