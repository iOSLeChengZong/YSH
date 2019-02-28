//
//  PersonalSystemMessageViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/2.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "PersonalSystemMessageViewController.h"
#import "SystemMessage.h"
#import "UserMessageViewModel.h"

#define kSystemMessage @"SystemMessage"

@interface PersonalSystemMessageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *systemMessageCollectionV;
@property(nonatomic,strong)UserMessageViewModel *messageVM;

@property (nonatomic,assign) RequestMode requestMode;

@end

@implementation PersonalSystemMessageViewController

#pragma mark -- 懒加载
-(UserMessageViewModel *)messageVM{
    if (!_messageVM) {
        _messageVM = [UserMessageViewModel new];
    }
    
    return _messageVM;
}

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
    
    self.requestMode = RequestModeRefresh;
    [self systemMessageCollectionVregisterCell];
    //添加脚部刷新
    [self addHeaderAndFooterRefresh];
    //请求数据
    [self requestMessageData];
}



#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.messageVM.itemCount;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SystemMessage *cell = [self.systemMessageCollectionV dequeueReusableCellWithReuseIdentifier:kSystemMessage forIndexPath:indexPath];
    cell.messageTitle.text = [self.messageVM itemTitleAtIndextPath:indexPath];
    cell.messageTime.text = [self.messageVM itemTimeAtIndexPath:indexPath];
    cell.message.text = [self.messageVM itemMessageAtIndexPath:indexPath];
    
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW, 130*kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10*kWidthScall, 0, 3*kWidthScall, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(kScreenW, 130);
//}


#pragma mark -- 方法
-(void)systemMessageCollectionVregisterCell{
    
    [self.systemMessageCollectionV registerNib:[UINib nibWithNibName:kSystemMessage bundle:nil] forCellWithReuseIdentifier:kSystemMessage];
}


- (IBAction)personalBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -- 方法
-(void)requestMessageData{
    [self.view showBusyHUD];
    WK(weakSelf)
    
    NSString *userID = [[VefifyRegisterViewModel sharedVefifyRegisterViewModel] userID];
    [self.messageVM getSystemUserMessageRequestMode:self.requestMode pageSize:20 userID:userID CompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf.systemMessageCollectionV reloadData];
            [weakSelf.systemMessageCollectionV endHeaderRefresh];
            [weakSelf.systemMessageCollectionV endFooterRefresh];
            [self.view hideBusyHUD];
        }
        
    }];
}

-(void)addHeaderAndFooterRefresh{
    WK(weakSelf)
    //添加头部刷新
    [self.systemMessageCollectionV addHeaderRefreshingBlock:^{
        weakSelf.requestMode = RequestModeRefresh;
        [weakSelf requestMessageData];
        
    }];
    
    //添加脚部刷新
    [self.systemMessageCollectionV addFooterBackRefresh:^{
        weakSelf.requestMode = RequestModeMore;
        if (weakSelf.messageVM.pageNum == weakSelf.messageVM.totalPage) {
            [weakSelf.systemMessageCollectionV endFooterRefresh];
            return ;
        }
        
        [weakSelf requestMessageData];
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
