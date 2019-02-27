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
#import "UserIdendityViewModel.h"

#define kIdentityDefaultReusableView @"IdentityDefaultReusableView"
#define kIdentityCell @"IdentityCell"
#define kItmeWidth (355 / 3) * kWidthScall

@interface MyIdentifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *headParentView;

//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

//用户昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

//用户身份
@property (weak, nonatomic) IBOutlet UILabel *userIdentity;

//消费者图片
@property (weak, nonatomic) IBOutlet UIImageView *customerImage;
//消费者名称
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;


//创业者图片
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;

//到创业者进度背景
@property (weak, nonatomic) IBOutlet UIView *businessProgressBg;

//到创业者进度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *businessProgressBarWidthC;
//创业者名称
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;


//总经理图片
@property (weak, nonatomic) IBOutlet UIImageView *managerImage;

//到总经理总进度背景
@property (weak, nonatomic) IBOutlet UIView *managerProgressBg;
//到总经理进度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *managerProgressBarWidthC;
//总经理名称
@property (weak, nonatomic) IBOutlet UILabel *managerNameLabel;

//合伙人图片
@property (weak, nonatomic) IBOutlet UIImageView *partnerImage;
//到合伙人总进度背景
@property (weak, nonatomic) IBOutlet UIView *partnerProgressBg;
//到合伙人进度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *partnerProgressBarWidthC;
//合伙人名称
@property (weak, nonatomic) IBOutlet UILabel *partnerNameLabel;

//我的成长值Btn
@property (weak, nonatomic) IBOutlet UIButton *myGrowthBtn;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIView *collectionVBgView;

@property (nonatomic,strong)MyPrerogativeModel *prerogativeModel;
@property (nonatomic,strong) UserIdendityViewModel *idendityVM;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionVParentVHeightC;

//顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myIdendityTopViewHeightC;
@property (weak, nonatomic) IBOutlet UIView *myIdendityTopView;




@end

@implementation MyIdentifyViewController

#pragma mark -- 懒加载
//我的特权
- (MyPrerogativeModel *)prerogativeModel{
    if (!_prerogativeModel) {
        _prerogativeModel = [[MyPrerogativeModel alloc] init];
    }
    return _prerogativeModel;
}

//我的身份
-(UserIdendityViewModel *)idendityVM{
    if (!_idendityVM) {
        _idendityVM = [UserIdendityViewModel sharedUserIdendityModel];
    }
    return _idendityVM;
}


#pragma mark -- 生命周期
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.backgroundColor = kViewBGColor;

    self.collectionV.backgroundColor = [UIColor clearColor];//kViewBGColor;
    self.collectionVBgView.backgroundColor = kViewBGColor;

    //适配iphoneX顶部
    if (iPhoneX) {
        self.myIdendityTopViewHeightC.constant = 20;
        self.myIdendityTopView.backgroundColor = kFONTSlectRGB;
    }else{
        self.myIdendityTopViewHeightC.constant = 0;
        self.myIdendityTopView.backgroundColor = [UIColor clearColor];
    }
    
    
    
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

    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    //注册
    [self registerCell];
    //请求数据
    [self requestData];

}

-(void)registerCell{
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
   
    return CGSizeMake((collectionView.frame.size.width - 2)/3, (collectionView.frame.size.width - 2)/3);
    
}
//分区之间的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1, 0, 1, 0);
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


#pragma mark -- 方法
-(void)requestData{
    WK(weakSelf)
    if (![YDUserInfo sharedYDUserInfo].login) {
        
        return;
    }
    [self.view showBusyHUD];
    [self.idendityVM getUserIdendityCompletionHandler:^(NSError * _Nonnull error) {
        
        if (!error) {
//           //设置用户头像
//
//            [weakSelf.headerImage.superview viewcornerRadius:weakSelf.headerImage.superview.bounds.size.width * 0.5 borderWith:0.1 clearColor:NO];
//            UIImage *headerImage = [[YDUserInfo sharedYDUserInfo] getUserHeaderImage];
//            if (headerImage) {
//                weakSelf.headerImage.image = headerImage;
//            }else{
//                [weakSelf.headerImage sd_setImageWithURL:[weakSelf.idendityVM userHeadImageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                    if (error) {
//                        weakSelf.headerImage.image = [UIImage imageNamed:@"y_p_avatar"];
//                    }
//                }];
//            }
            
            
            [weakSelf.headerImage.superview viewcornerRadius:weakSelf.headerImage.superview.bounds.size.width * 0.5 borderWith:0.1 clearColor:NO];
            [weakSelf.headerImage sd_setImageWithURL:[weakSelf.idendityVM userHeadImageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                   weakSelf.headerImage.image = [UIImage imageNamed:@"y_p_avatar"];
                }
            }];
            
            //设置昵称
            weakSelf.nickNameLabel.text = [self.idendityVM userNickName];
            //设置身份
            weakSelf.userIdentity.text = [self.idendityVM userRankName];
            
            //设置身份进程
            [weakSelf setUpUserIdentifierProgress];
            
            [weakSelf.myGrowthBtn setTitle:[[@"我的成长值" stringByAppendingString:[weakSelf.idendityVM userGrowth]]stringByAppendingString:@" >"] forState:UIControlStateNormal];
//            [weakSelf.myGrowthBtn.titleLabel setFont:[UIFont fontWithName:@"苹方-简" size:14 * kWidthScall]];
            
            //设置距离下个身份还差
            [weakSelf setUpNexRankNotice];

        }else{
            [weakSelf.view showWarning:@"请求错误"];
        }
        [weakSelf.view hideBusyHUD];
    }];
}

-(void)setUpUserIdentifierProgress{
    [self setUpCustomer];
    [self setUpBusiness];
    [self setUpManager];
    [self setUpPartner];
}

//消费者
-(void)setUpCustomer{
    //设置消费者图片 名称颜色 进度
    self.customerImage.image = [self.idendityVM getCustomerImage];
    [self.customerNameLabel setTextColor:[self.idendityVM getCustomerNameColor]];
    self.businessProgressBarWidthC.constant = self.businessProgressBg.bounds.size.width * ([self.idendityVM toBusinessScale]);
}

//创业者
-(void)setUpBusiness{
    //设置创业者图片 名称颜色 进度
    self.businessImage.image = [self.idendityVM getBusinessImage];
    [self.businessNameLabel setTextColor:[self.idendityVM getBusinessNameColor]];
    self.managerProgressBarWidthC.constant = self.managerProgressBg.bounds.size.width * ([self.idendityVM toManagerScale]);
}

//总经理
-(void)setUpManager{
    self.managerImage.image = [self.idendityVM getManagerImage];
    [self.managerNameLabel setTextColor:[self.idendityVM getManagerNameColor]];
    self.partnerProgressBarWidthC.constant = self.partnerProgressBg.bounds.size.width *([self.idendityVM toPartnerScale]);
}

//合伙人
-(void)setUpPartner{
    //设置总经理图片 名称颜色 进度
    self.partnerImage.image = [self.idendityVM getPartnerImage];
    [self.partnerNameLabel setTextColor:[self.idendityVM getPartnerNameColor]];
    
}

//距离下个身份还差
-(void)setUpNexRankNotice{
    //设置距离下个身份差值
    NSString *str = [NSString stringWithFormat:@"距离下个身份还差 %@ 成长值",[self.idendityVM lessThanNextRank]];
    UIFont *font = [UIFont fontWithName:@"苹方-简" size:14 * kWidthScall];
    CGSize strSize = [str sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel *label0  = [[UILabel alloc] initWithFrame:CGRectMake((self.headParentView.bounds.size.width - strSize.width) * 0.5, self.headParentView.bounds.size.height - strSize.height, strSize.width, strSize.height)];
    label0.backgroundColor = [UIColor clearColor ];
    label0.font = font;
    label0.textAlignment = NSTextAlignmentCenter;
    label0.numberOfLines = 0;
    
    
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    // 修改富文本中的不同文字的样式
    [attri addAttribute:NSForegroundColorAttributeName value:KFontDefaultRGB range:NSMakeRange(0, 8)];
    [attri addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 8)];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:kFONTSlectRGB range:NSMakeRange(9, str.length -13)];
    [attri addAttribute:NSFontAttributeName value:font range:NSMakeRange(9, str.length -13)];
    
    [attri addAttribute:NSForegroundColorAttributeName value:KFontDefaultRGB range:NSMakeRange(str.length -3, 3)];
    [attri addAttribute:NSFontAttributeName value:font range:NSMakeRange(str.length -3, 3)];
    label0.attributedText = attri;
    [self.headParentView addSubview:label0];
    
    CGRect rect = CGRectMake(CGRectGetMinX(label0.frame)  - 10 * kWidthScall - strSize.height, self.headParentView.bounds.size.height - strSize.height, strSize.height, strSize.height);
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:rect];
    imageV.image = [UIImage imageNamed:@"y_b_notice0"];
    [self.headParentView addSubview:imageV];


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
