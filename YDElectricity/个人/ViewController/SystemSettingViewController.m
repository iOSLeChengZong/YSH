//
//  SystemSettingViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/12.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "IdearResponseRoViewController.h"

#define kIdearResponseRoViewController @"IdearResponseRoViewController"

@interface SystemSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;

@end

@implementation SystemSettingViewController


#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%.1fM",[self readCacheSize]];
}



//清除缓存
- (IBAction)clearCache:(id)sender {
//    [Factory showWaittingForOpened];
    YDAlertView *alertV = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"你确定要清除缓存吗?" confrimBolck:^{
        [self clearFile];
    } cancelBlock:^{
        
    }];
    [alertV show];
    
}

//版本说明
- (IBAction)versionDetail:(id)sender {
    [Factory showWaittingForOpened];
}


//意见反馈
- (IBAction)IdearResponseBtcnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    IdearResponseRoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:kIdearResponseRoViewController];
    [self.navigationController pushViewController:ivc animated:YES];
}

//修改密码
- (IBAction)updateCode:(id)sender {
    [Factory showWaittingForOpened];
}

//关于我们
- (IBAction)aboutOur:(id)sender {
    [Factory showWaittingForOpened];
    
}



//返回
- (IBAction)systemSettingBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



//1. 获取缓存文件的大小
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}


//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}



// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}



//2. 清除缓存
- (void)clearFile
{
    [self.view showBusyHUD];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
    float cacheSize = [self readCacheSize] *1024;
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%.1fKB",cacheSize];
    [self.view hideBusyHUD];
    [self.view showWarning:@"已完成"];
    
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
