//
//  AddressListCell.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDataModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AddressListCellDelegate <NSObject>
//删除
-(void)onAddrDelWithIndex:(NSInteger)index;
//编辑
-(void)onAddrEditWithIndex:(NSInteger)index;
//设置默认
-(void)onSetDefaultAddrWithIndex:(NSInteger)index click:(id)sender;

@end

@interface AddressListCell : UICollectionViewCell
@property(nonatomic,copy)AddressDataModel *addrModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;




@property (nonatomic,assign) BOOL isDefault;
@property (nonatomic) NSInteger index;
@property (nonatomic,weak) id<AddressListCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
