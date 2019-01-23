//
//  PersonalViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalLogonHeader.h"
#import "PersonCollectionViewCell.h"
#import "MyGoldViewController.h"
#import "MyTeacherViewController.h"
#import "PersonalSystemMessageViewController.h"
#import "PersonalEditorDataViewController.h"
#import "LoginViewController.h"
#import "MyOrderViewController.h"
#import "SystemSettingViewController.h"
#import "UserIdendityViewModel.h"

#define kPersonalLogonHeader @"PersonalLogonHeader"
#define kPersonCollectionViewCell @"PersonCollectionViewCell"


@interface PersonalViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *personalCollectionView;
@property (nonatomic,strong) NSArray *cellImageNames;
@property (nonatomic,strong) UserIdendityViewModel *idendityVM;

@end

@implementation PersonalViewController

#pragma mark -- 懒加载

-(UserIdendityViewModel *)idendityVM{
    if (!_idendityVM) {
        _idendityVM = [UserIdendityViewModel new];
    }
    return _idendityVM;
}

-(NSArray *)cellImageNames{
    if (!_cellImageNames) {
        _cellImageNames = @[@"y_p_我的金币icon",@"y_p_我的导师icon",@"y_p_服务中心",@"y_p_邀请有礼icon",@"y_p_系统设置icon"];
    }
    return _cellImageNames;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalCollectionView.backgroundColor = kViewBGColor;
    
    //注册cell
    [self registerCell];
    
    if (iPhoneX) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, kScreenW, STATUS_BAR_HEIGHT + 20)];
        v.backgroundColor = kFONTSlectRGB;
        [self.personalCollectionView addSubview:v];
    }
    
    [self requestData];
    
    

    
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,---%ld",[self class],indexPath.row);
    
    if (![YDUserInfo sharedYDUserInfo].login) {//提示用户跳转到登陆注册界面
        [self userNoneLoginTip];
        return;
    }
    if (indexPath.row == 0) {//我的金币
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
        MyGoldViewController *goldVC = [storyboard instantiateViewControllerWithIdentifier:@"MyGoldViewController"];
        [self.navigationController pushViewController:goldVC animated:YES];
    }
    
    else if (indexPath.row == 1)//我的导师
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
        MyTeacherViewController *teacherVC = [storyboard instantiateViewControllerWithIdentifier:@"MyTeacherViewController"];
        [self.navigationController pushViewController:teacherVC animated:YES];
    }
    
    else if (indexPath.row == 2){//服务中心
        [Factory showWaittingForOpened];
    }
    else if (indexPath.row == 3){//邀请有礼
        [Factory showWaittingForOpened];
    }
    else if (indexPath.row == 4){//系统设置
        //systemSetting
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDPersonal" bundle:nil];
        SystemSettingViewController *systemSettingVC = [storyboard instantiateViewControllerWithIdentifier:@"SystemSettingViewController"];
        [self.navigationController pushViewController:systemSettingVC animated:YES];
    }
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonCollectionViewCell *cell = [self.personalCollectionView dequeueReusableCellWithReuseIdentifier:kPersonCollectionViewCell forIndexPath:indexPath];
    if (![YDUserInfo sharedYDUserInfo].login) {
        cell.nameImage.image = [UIImage imageNamed:self.cellImageNames[indexPath.row]];
    }
    
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PersonalLogonHeader *header = [self.personalCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalLogonHeader forIndexPath:indexPath];
    if (!iPhoneX) {
        CGRect frame = header.frame;
        frame.origin = CGPointMake(0, -STATUS_BAR_HEIGHT);
        header.frame = frame;
        
    }
    
    if (![YDUserInfo sharedYDUserInfo].login) {
        header.nickName = [self.idendityVM userNickName];
        header.ranckName = [self.idendityVM userRankName];
        //    header.imageUrl = [self.idendityVM userHeadImageURL];
    }

    [header addClickHandler:^(PersonalLogonHeaderClick click) {
        NSLog(@"在这里完成消息界面跳转");
        if (![YDUserInfo sharedYDUserInfo].login) {//提示用户跳转到登陆注册界面
            [self userNoneLoginTip];
            return;
        }
        
        if (click == PersonalLogonHeaderClickMessage) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
            PersonalSystemMessageViewController *systemMeVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalSystemMessageViewController"];
            [self.navigationController pushViewController:systemMeVC animated:YES];
            
        }
        
        else if (click == PersonalLogonHeaderClickEditor) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
            PersonalEditorDataViewController *editorVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalEditorDataViewController"];
            [self.navigationController pushViewController:editorVC animated:YES];
        }
        
        else if (click == PersonalLogonHeaderClickLogin){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kLogin bundle:nil];
            LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:kLogin];
            [[[UIApplication sharedApplication] delegate] window].rootViewController = loginVC;
        }
        
        else if (click == PersonalLogonHeaderClickOrder){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
            MyOrderViewController *myOrderVC = [storyboard instantiateViewControllerWithIdentifier:@"MyOrderViewController"];
            myOrderVC.userPid = self.idendityVM.userPid;
            [self.navigationController pushViewController:myOrderVC animated:YES];
        }
        
    }];

    return header;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW, 50 * kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (!iPhoneX) {
        return UIEdgeInsetsMake(-STATUS_BAR_HEIGHT+6, 9, 6, 9);
    }else{
        return UIEdgeInsetsMake(6, 9, 6, 9);
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(kScreenW, iPhoneX ? 326 + STATUS_BAR_HEIGHT : 326 * kWidthScall);
return CGSizeMake(kScreenW, 320);
}


#pragma mark -- 方法
-(void)registerCell{
    [self.personalCollectionView registerNib:[UINib nibWithNibName:kPersonalLogonHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPersonalLogonHeader];
    [self.personalCollectionView registerNib:[UINib nibWithNibName:kPersonCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kPersonCollectionViewCell];
}

-(void)userNoneLoginTip{
    [Factory noneLoginTipConfrimBolck:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kLogin bundle:nil];
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:kLogin];
        [[[UIApplication sharedApplication] delegate] window].rootViewController = loginVC;
    } CancelBlock:^{
        
    }];
}

-(void)requestData{
    WK(weakSelf)
    if (![YDUserInfo sharedYDUserInfo].login) {
        [self.personalCollectionView reloadData];
        return;
    }
    [self.view showBusyHUD];
    [self.idendityVM getUserIdendityCompletionHandler:^(NSError * _Nonnull error) {
        
        if (!error) {
            [weakSelf.personalCollectionView reloadData];
        }else{
            [weakSelf.view showWarning:@"请求错误"];
        }
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
