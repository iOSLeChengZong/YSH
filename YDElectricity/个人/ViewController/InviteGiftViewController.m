//
//  InviteGiftViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/25.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "InviteGiftViewController.h"
#import "InviteGiftTextCell.h"

#define kInviteGiftTextCell @"InviteGiftTextCell"

@interface InviteGiftViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *inviteGiftTextCollectionV;
@property (nonatomic,strong)NSArray<NSString *> *textArr;

@end

@implementation InviteGiftViewController


-(NSArray<NSString *> *)textArr{
    if (!_textArr) {
        _textArr = @[@".每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金",
                     @".每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金,.每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金",
                     @".每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金",
                     @".每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金.每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金",
                     @".每成功邀请一位好友可获得 20 成长值 和 10元 金币奖励,如何好友首次下单并完成付款,还可获得 30 成长值 和 15 元币的奖励,同时额外获得商品分享奖金"];
        
    }
    return _textArr;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_inviteGiftTextCollectionV registerNib:[UINib nibWithNibName:kInviteGiftTextCell bundle:nil] forCellWithReuseIdentifier:kInviteGiftTextCell];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.textArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteGiftTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInviteGiftTextCell forIndexPath:indexPath];
    cell.textLabel.text = self.textArr[indexPath.row];
    return cell;
}


#pragma  mark --  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIFont *font = [UIFont systemFontOfSize:12 * kWidthScall weight:UIFontWeightMedium];//[UIFont fontWithName:@"苹方-简" size:12 * kWidthScall];
    CGSize size = [self.textArr[indexPath.row] sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    NSInteger scale = ceilf(size.width / collectionView.bounds.size.width);
    
    return CGSizeMake(collectionView.frame.size.width, 17 * kWidthScall * scale);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 12 * kWidthScall, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 12 * kWidthScall;
}


//立即邀请Btn
- (IBAction)inviteBtnClick:(id)sender {
    
}


- (IBAction)inviteGiftVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
