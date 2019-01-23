//
//  EditorAddressViewController.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDataModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol EditorAddressViewControllerDelegate <NSObject>

-(void)fetchNewAddr:(AddressDataModel*)dataModel;

@end

@interface EditorAddressViewController : UIViewController
@property (nonatomic,weak) id<EditorAddressViewControllerDelegate> delegate;
-(void)setUpViewContent:(AddressDataModel*)dataModel;
@end

NS_ASSUME_NONNULL_END
