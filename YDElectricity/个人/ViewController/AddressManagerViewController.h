//
//  AddressManagerViewController.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressManagerViewControllerDelegate <NSObject>

-(void)fetchNewAddr:(NSString*)addrStr;

@end

@interface AddressManagerViewController : UIViewController
@property (nonatomic,weak) id<AddressManagerViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
