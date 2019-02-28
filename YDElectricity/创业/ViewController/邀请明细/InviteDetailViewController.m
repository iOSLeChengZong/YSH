//
//  InviteDetailViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "InviteDetailViewController.h"
#import "InviteDetailCell.h"
#import "RHFiltrateView.h"
#import "InviteRecordViewModel.h"

#define kInviteDetailCell @"InviteDetailCell"
#define kTagValue 1000
#define kSelectViewH 100

@interface InviteDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,RHFiltrateViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *inviteDetailCollectionV;
@property (nonatomic,assign) BOOL isShowSelect;
@property (nonatomic,strong)UIView *maskView;

@property (strong,nonatomic) RHFiltrateView * filtrateView;

@property (strong,nonatomic)InviteRecordViewModel *inviteVM;
@property (nonatomic,assign)InviteReRecordRequestMode requestMode;
@property (nonatomic,strong)NSArray<NSString *> *requestTimeStrs;
@property (nonatomic,strong)NSArray<NSString *> *sortStrs;
@property (nonatomic,strong)NSString *addTime;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *oldAddTime;
@property (nonatomic,strong)NSString *oldType;



@end

@implementation InviteDetailViewController

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _maskView.tag = kTagValue;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];//[UIColor colorWithWhite:0.3 alpha:0.6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
        tap.delegate = self;
        [_maskView addGestureRecognizer:tap];
        _maskView.alpha = 0.1;
    }
    return _maskView;
}

-(RHFiltrateView *)filtrateView{
    if (!_filtrateView) {
        
        _filtrateView = [[RHFiltrateView alloc] initWithTitles:@[@"",@""] items:@[@[@"近七天", @"近30天", @"近3个月", @"近半年"], @[@"默认", @"团队成员", @"贡献额"]]];
        _filtrateView.frame = CGRectMake(0, 0, kScreenW, 0);
        _filtrateView.delegate = self;
    }
    
    return _filtrateView;
}

-(InviteRecordViewModel *)inviteVM{
    if (!_inviteVM) {
        _inviteVM = [InviteRecordViewModel new];
    }
    return _inviteVM;
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
    self.inviteDetailCollectionV.backgroundColor = kViewBGColor;
    //注册cell
    [self.inviteDetailCollectionV registerNib:[UINib nibWithNibName:kInviteDetailCell bundle:nil] forCellWithReuseIdentifier:kInviteDetailCell];
    //初始化数据
    [self InitData];
    //请求数据
    [self requestData];
    //添加头部视图
    [self addHeaderAndFooterRefresh];
    

}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.inviteVM.recordList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInviteDetailCell forIndexPath:indexPath];
    [cell.headImage sd_setImageWithURL:[self.inviteVM headURLAtIndexpath:indexPath]];
    [cell.headImage viewcornerRadius:cell.headImage.bounds.size.height * 0.5 borderWith:0.02 clearColor:NO];
    cell.userName.text = [self.inviteVM userNameAtIndexpath:indexPath];
    cell.addTime.text = [self.inviteVM inviteTimeAtindexPath:indexPath];
    cell.teamPeopleNum.text = [self.inviteVM teamPeopleNumAtIndexPath:indexPath];
    cell.contributeNum.text = [self.inviteVM contributeNumAtIndexPath:indexPath];
//    [cell.rankImageView sd_setImageWithURL:nil];
    return cell;
    
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidthScall * 357, 63 * kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(18 * kWidthScall, (kScreenW - kWidthScall * 357)*0.5, 3,(kScreenW - kWidthScall * 357)*0.5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3 * kWidthScall;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}


#pragma mark -- RHFiltrateViewDelegate
- (void)filtrateView:(RHFiltrateView *)filtrateView didSelectAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld", indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
        self.addTime = self.requestTimeStrs[indexPath.row];
    }else{
        self.type = self.sortStrs[indexPath.row];
    }
}


- (IBAction)inviteDetailVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SelectBtnClick:(id)sender {
    self.isShowSelect = !self.isShowSelect;
    if (self.isShowSelect) {
        [self showMaskView];
    }else{
        [self hideMaskView];
        
    }
    
    
}

- (void)showMaskView
{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.filtrateView];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 1;
        CGRect frame = self.filtrateView.frame;
        frame.size.height = kSelectViewH;
        self.filtrateView.frame = frame;
    }];
}

- (void)hideMaskView
{
  
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0;
        CGRect frame = self.filtrateView.frame;
        frame.size.height = 0;
        self.filtrateView.frame = frame;
    }completion:^(BOOL finished) {
        [self.filtrateView removeFromSuperview];
        [self.maskView removeFromSuperview];
        //请求数据
        if ([self.oldAddTime isEqualToString:self.addTime] && [self.oldType isEqualToString:self.type]) {
            return;
        }else{
            self.requestMode = InviteReRecordRequestModeRefresh;
        }
        [self requestData];
        
    }];
}


- (void)hideAction
{
    NSLog(@"hideAction");
    //请求数据
    if ([self.oldAddTime isEqualToString:self.addTime] && [self.oldType isEqualToString:self.type]) {
        return;
    }else{
        self.requestMode = InviteReRecordRequestModeRefresh;
    }
    [self requestData];
    
}



#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    UIView *view = [touch.view viewWithTag:kTagValue];
    if (view) {
        [self SelectBtnClick:nil];
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    return  YES;
}


-(void)addHeaderAndFooterRefresh{
    WK(weakSelf)
    //添加头部刷新
    [self.inviteDetailCollectionV addHeaderRefreshingBlock:^{
        weakSelf.requestMode = InviteReRecordRequestModeRefresh;
        [weakSelf requestData];
        
    }];
    
    //添加脚部刷新
    [self.inviteDetailCollectionV addFooterBackRefresh:^{
        weakSelf.requestMode = InviteReRecordRequestModeMore;
        
        if (self.inviteVM.totalPage == self.inviteVM.pageNum) {
            return ;
        }
        
        [weakSelf requestData];
    }];
}

-(void)requestData{
    [self.view showBusyHUD];
    WK(weakSelf)
    [self.inviteVM getUserInviteRecordWithPageSize:20 orderType:self.type addTime:self.addTime requestMode:self.requestMode completionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf.inviteDetailCollectionV reloadData];
            [weakSelf.inviteDetailCollectionV reloadData];
            [weakSelf.inviteDetailCollectionV endHeaderRefresh];
            [weakSelf.inviteDetailCollectionV endFooterRefresh];
            [weakSelf.view hideBusyHUD];
            weakSelf.oldType = self.type;
            weakSelf.oldAddTime = self.addTime;
        }
    }];
}

-(void)InitData{
    self.requestMode = InviteReRecordRequestModeRefresh;
    self.requestTimeStrs = @[@"week",@"month",@"90",@"180"];
    self.sortStrs = @[@"time",@"userCount",@"grandTotalIncome"];
    self.addTime = self.requestTimeStrs[0];
    self.type = self.sortStrs[0];
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
