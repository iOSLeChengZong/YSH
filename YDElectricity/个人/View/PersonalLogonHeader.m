//
//  PersonalLogonHeader.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PersonalLogonHeader.h"
#import "YDUserInfo.h"

@interface PersonalLogonHeader ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *userIdendityView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *userIdendityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@end

@implementation PersonalLogonHeader


-(void)setNickName:(NSString *)nickName{
    _nickName = nickName;
    _nickLabel.text = _nickName;
}

-(void)setRanckName:(NSString *)ranckName{
    _ranckName = ranckName;
    _userIdendityLabel.text = _ranckName;
}

-(void)setImageUrl:(NSURL *)imageUrl{
    _imageUrl = imageUrl;
//    if (!_imageUrl) {//如果为空
//        //本地加载
//        if ([self LoadLocalHeadImage]) {
//            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:[self LoadLocalHeadImage]];
//            [self.headerImage viewcornerRadius:self.headerImage.frame.size.height*0.5 borderWith:0.02 clearColor:YES];
//            [self.headerImage setImage:savedImage];
//        }else{
//            [self.headerImage setImage:[UIImage imageNamed:@"y_p_avatar"]];
//        }
//    }else{
//
////      [_headerImage sd_setImageWithURL:_imageUrl];
//        [_headerImage sd_setImageWithURL:_imageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (error) {
//               [self.headerImage setImage:[UIImage imageNamed:@"y_p_avatar"]];
//            }
//        }];
//    }
    
    if (!_imageUrl) {
        [_headerImage sd_setImageWithURL:_imageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                [self.headerImage setImage:[UIImage imageNamed:@"y_p_avatar"]];
            }
        }];
    }else{
        [self.headerImage setImage:[UIImage imageNamed:@"y_p_avatar"]];
    }
    
   
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([YDUserInfo sharedYDUserInfo].login) {//如何用户登陆了
        self.loginBtn.hidden = [YDUserInfo sharedYDUserInfo].login;
        self.nickNameLabel.hidden = !self.loginBtn.hidden;
        self.userIdendityView.hidden = self.nickNameLabel.hidden;
        
    }else{
        self.loginBtn.hidden = [YDUserInfo sharedYDUserInfo].login;
        self.nickNameLabel.hidden = !self.loginBtn.hidden;
        self.userIdendityView.hidden = self.nickNameLabel.hidden;
    }
    
    
    
    
}

-(NSString *)LoadLocalHeadImage{
    //从沙盒拿
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    if ([fileManager fileExistsAtPath:fullPath]) {
        return fullPath;
    }else{
        
        return nil;
    }
}

//消息
- (IBAction)OnMessageBtnClick:(id)sender {
    NSLog(@"OnMessageBtnClick");
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickMessage);
}


//编辑
- (IBAction)OnEditorBtnClick:(id)sender {
    NSLog(@"OnEditorBtnClick");
    
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickEditor);
}


//去登陆
- (IBAction)OnLoginBtnClick:(id)sender {
    NSLog(@"OnLoginBtnClick");
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickLogin);
    
    
}

- (IBAction)OnOrderBtnClick:(id)sender {
    NSLog(@"OnOrderBtnClick");
    !_personalClickHander ?: _personalClickHander(PersonalLogonHeaderClickOrder);
}



-(void)addClickHandler:(void (^)(PersonalLogonHeaderClick))handler{
    _personalClickHander = handler;
}


@end
