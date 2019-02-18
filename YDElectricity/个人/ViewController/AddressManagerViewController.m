//
//  AddressManagerViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "AddressListCell.h"
#import "AddAddressCell.h"
#import "EditorAddressViewController.h"

#define kAddressListCell @"AddressListCell"
#define kAddAddressCell @"AddAddressCell"
#define kEditorAddressViewController @"EditorAddressViewController"

@interface AddressManagerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EditorAddressViewControllerDelegate,AddressListCellDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *addressManagerCollectionV;
@property (nonatomic,strong) NSMutableArray<AddressDataModel *> *addrDataSrc;
@property (nonatomic,assign) BOOL editNotSave; //如果Ture则为编辑地址，否则为新建地址
@property (nonatomic) NSInteger curEditIndex;
@property (nonatomic,copy)NSString *defaultAddr;


@end

@implementation AddressManagerViewController

#pragma mark -- 懒加载

- (NSMutableArray<AddressDataModel *> *)addrDataSrc{
    if (!_addrDataSrc) {
        _addrDataSrc = [[NSMutableArray alloc]init];
        NSArray* array = [[NSUserDefaults standardUserDefaults]objectForKey:@"addrList"];
        for (NSData* data in array) {
            [self.addrDataSrc addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }

    return _addrDataSrc;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //禁止返回
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressManagerCollectionV.backgroundColor = kViewBGColor;
    //获取数据
    [self fetchAddrDataSrcFromDefault];
    //注册cell
    [self.addressManagerCollectionV registerNib:[UINib nibWithNibName:kAddressListCell bundle:nil] forCellWithReuseIdentifier:kAddressListCell];
    [self.addressManagerCollectionV registerNib:[UINib nibWithNibName:kAddAddressCell bundle:nil] forCellWithReuseIdentifier:kAddAddressCell];
}



#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.editNotSave = NO;
        [self pushToEditorVC:nil];
    }
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.addrDataSrc.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AddAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddAddressCell forIndexPath:indexPath];
        return cell;
    }
    AddressListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddressListCell forIndexPath:indexPath];
    cell.addrModel = [_addrDataSrc objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(357 * kWidthScall, 70 * kWidthScall);
    }
    
    return CGSizeMake(357 * kWidthScall, 126 * kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
    if (section == 0) {
        return UIEdgeInsetsMake(18, (kScreenW - 357 * kWidthScall)/2, 0, (kScreenW - 357 * kWidthScall)/2);
    }
    
    return UIEdgeInsetsMake(7, (kScreenW - 357 * kWidthScall)/2, 7, (kScreenW - 357 * kWidthScall)/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}

#pragma mark -- EditorAddressViewControllerDelegate
-(void)fetchNewAddr:(AddressDataModel *)dataModel{
    //保存数据
    if (!_editNotSave) {
        if ([dataModel.defaultStr isEqualToString:@"默认"]) {
            for (AddressDataModel *model in self.addrDataSrc) {
                model.defaultStr = @"";
            }
            
            [self.addrDataSrc insertObject:dataModel atIndex:0];
        }else{
           [self.addrDataSrc addObject:dataModel];
        }
 
    }else{
        //编辑地址
        if ([dataModel.defaultStr isEqualToString:@"默认"]) {
            AddressDataModel *mod = [[AddressDataModel alloc] init];
            mod.name = dataModel.name;
            mod.telphone = dataModel.telphone;
            mod.postCode = dataModel.postCode;
            mod.detailAddr = dataModel.detailAddr;
            mod.areaStr = dataModel.areaStr;
            mod.defaultStr = dataModel.defaultStr;
            
            [self.addrDataSrc insertObject:mod atIndex:0];
            [self.addrDataSrc removeObject:dataModel];
            
            for (int i = 1; i < self.addrDataSrc.count; ++i) {
                if ([self.addrDataSrc[i].defaultStr isEqualToString:@"默认"]) {
                    self.addrDataSrc[i].defaultStr = @"";
                    break;
                }
            }
        
        }else{
            [self.addrDataSrc replaceObjectAtIndex:self.curEditIndex withObject:dataModel];
        }
    
        
    }
    
    
    
    [self.addressManagerCollectionV reloadData];
    [self saveAddrDataSrc];
}

-(void)saveAddrDataSrc{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    NSData* data;
    for (AddressDataModel *dataModel in self.addrDataSrc) {
        data = [NSKeyedArchiver archivedDataWithRootObject:dataModel];
        [array addObject:data];
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSArray arrayWithArray:array] forKey:@"addrList"];
}

-(void)fetchAddrDataSrcFromDefault{

}

#pragma mark -- AddressListCellDelegate
//删除
-(void)onAddrDelWithIndex:(NSInteger)index{
    [self.addrDataSrc removeObjectAtIndex:index];
    [self saveAddrDataSrc];
    [self.addressManagerCollectionV reloadData];
}
//编辑
-(void)onAddrEditWithIndex:(NSInteger)index{
    self.curEditIndex = index;
    self.editNotSave = YES;
    [self pushToEditorVC:[self.addrDataSrc objectAtIndex:index]];
}

//设置默认
-(void)onSetDefaultAddrWithIndex:(NSInteger)index click:(id)sender{
    
    for (int i = 0; i < self.addrDataSrc.count; ++i) {
        if (index != i) {
            self.addrDataSrc[i].defaultStr = @"";

        }else{
            self.addrDataSrc[i].defaultStr = @"默认";
        }
    }
    
    AddressDataModel* dataModel = [self.addrDataSrc objectAtIndex:index];
    //让默认地址在第一位显示
    [self.addrDataSrc removeObjectAtIndex:index];
    [self.addrDataSrc insertObject:dataModel atIndex:0];
    [self saveAddrDataSrc];
    NSString *defaultAddr = [[dataModel.detailAddr stringByAppendingString:@" "] stringByAppendingString:dataModel.areaStr];
    [self saveDefaultAddr:defaultAddr];
    [self.addressManagerCollectionV reloadData];
}


-(void)pushToEditorVC:(AddressDataModel *)model{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    EditorAddressViewController *evc = [storyboard instantiateViewControllerWithIdentifier:kEditorAddressViewController];
    evc.delegate = self;
    [evc setUpViewContent:model];
    [self.navigationController pushViewController:evc animated:YES];
}



- (IBAction)addressManagerBackBtnClick:(id)sender {

    if (self.delegate) {
        [self.delegate fetchNewAddr:[self readDefaultAddr]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)saveDefaultAddr:(NSString *)str{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:str forKey:kDefauleAddr];
    [def synchronize];
}

-(NSString *)readDefaultAddr{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kDefauleAddr];
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
