//
//  IdearResponseRoViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/12.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "IdearResponseRoViewController.h"
#import "IdeaResponseCell.h"
#import "KKPhotoPickerManager.h"
#import <BRPickerView.h>
#import "PlaceholderTextView.h"
#import "Factory.h"
#import "IdearResponseViewModel.h"


#define kIdeaResponseCell @"IdeaResponseCell"

@interface IdearResponseRoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@property (weak, nonatomic) IBOutlet UITextField *textField0;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imageArray;
@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) IdearResponseViewModel *idearVM;

@property (nonatomic,strong) MBProgressHUD *HUD;
@property (nonatomic,strong) NSDictionary *responseType;


@end

@implementation IdearResponseRoViewController

#pragma mark -- 懒加载
-(IdearResponseViewModel *)idearVM{
    if (!_idearVM) {
        _idearVM = [IdearResponseViewModel new];
    }
    return _idearVM;
}


-(MBProgressHUD *)HUD{
    if (!_HUD) {
         _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _HUD.mode = MBProgressHUDModeAnnularDeterminate;
        _HUD.label.text = @"上传";
        _HUD.label.font = [UIFont systemFontOfSize:12];
        _HUD.bezelView.alpha = 0.9;
        
        _HUD.margin = 15;
        [self.HUD showAnimated:YES];
    }
    return _HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    [self.imageCollectionView registerNib:[UINib nibWithNibName:kIdeaResponseCell bundle:nil] forCellWithReuseIdentifier:kIdeaResponseCell];
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    self.imageArray = [NSMutableArray array];
//    _textView.placeholder = @"写下你遇到的问题，或告诉我们你的宝贵意见~";
    self.responseType = @{@"商品相关":@"1",@"物流状况":@"2",@"客户服务":@"3",@"优惠活动":@"4",@"产品体验":@"5",@"产品功能":@"6",@"其它":@"7"};//[@"商品相关", @"物流状况", @"客户服务",@"优惠活动", @"产品体验",@"产品功能",@"其它"]
}




#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tttttttt%@,%ld",[self class],[collectionView cellForItemAtIndexPath:indexPath].tag);
    self.indexPath = indexPath;
    if (self.imageArray.count > 5) {
        YDAlertView *alertV = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"图片数量超过5张" confrimBolck:nil cancelBlock:nil];
        [alertV show];
    }else{
        if ([collectionView cellForItemAtIndexPath:indexPath].tag == 11) {
            [[KKPhotoPickerManager shareInstace] showActionSheetInView:self.view fromController:self completionBlock:^(NSMutableArray *imageArray) {
                [self.imageCollectionView reloadData];
                for (int i = 0; i<imageArray.count; i++) {
                    if (self.imageArray.count < 6) {
                        UIImage *image = imageArray[i];
                        [self.imageArray addObject:image]; //上传图片保存到数组
                    }
                }
            }];
        }
    }
    
    
    
}
#pragma mark -- #pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 6;
    return self.imageArray.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IdeaResponseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdeaResponseCell forIndexPath:indexPath];
   
    //清空子控件,解决重用问题
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }

    
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    cell.tag = 11; //根据tag值设定是否可点击
    cell.imageView = imageView;
    cell.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"y_p_add"];
    
    
    KKButton *cancleBtn = [[KKButton alloc]init];
    cell.cancleBtn1 = cancleBtn;
    [cell.contentView addSubview: cancleBtn];
    [cancleBtn setImage:[UIImage imageNamed:@"y_p_delete"] forState:UIControlStateNormal];
    cancleBtn.hidden = YES;
    
    cell.imageView.frame = CGRectMake(0, 0, 70, 70);
    cell.cancleBtn1.frame = CGRectMake(0, 0, 20, 20);
    
    
    if (self.imageArray.count > indexPath.row) {
        if ([self.imageArray[indexPath.row] isKindOfClass:[UIImage class]]) {
            cell.imageView.image = nil;
            cell.imageView.image = self.imageArray[indexPath.row];
            [cell.cancleBtn1 setHidden:NO];
            [cell bringSubviewToFront:cell.cancleBtn1];
            cell.tag = 10;
        }
    }
    
    
    cell.cancleBtn1.indexPath = indexPath;

    
    [cell.cancleBtn1 addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70 , 70);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 10, 8, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}



#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        _textView.placeholder = @"";
        [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        return YES; // 当前 textField 可以编辑
    } else {
        [self.view endEditing:YES];
        [self handlerTextFieldSelect:textField];
        return NO; // 当前 textField 不可编辑，可以响应点击事件
    }
}

#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    NSLog(@"结束编辑:%@", textField.text);
    switch (textField.tag) {
        case 0:
        {
            
            
        }
            break;
        case 3:
        {
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 处理点击事件
- (void)handlerTextFieldSelect:(UITextField *)textField {
    switch (textField.tag) {
        case 0://反馈类型
        {
            [BRStringPickerView showStringPickerWithTitle:@"反馈类型" dataSource:@[@"商品相关", @"物流状况", @"客户服务",@"优惠活动", @"产品体验",@"产品功能",@"其它"] defaultSelValue:textField.text resultBlock:^(id selectValue) {
                textField.text = selectValue;
                [textField setTextColor:kFONTSlectRGB];
            }];
        }
            break;
        case 2:
        {
           
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark  删除图片
- (void)cancleBtnClick:(KKButton *)sender{
    if (sender.indexPath.row < self.imageArray.count) {
        if (self.imageArray[sender.indexPath.row] != nil) {
            [self.imageArray removeObjectAtIndex:sender.indexPath.row];
            sender.hidden = YES;
            [self.imageCollectionView cellForItemAtIndexPath:sender.indexPath].tag = 11;
            [self.imageCollectionView reloadData];
        }
    }
}


#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text=@"";
    textView.textColor = KFontDefaultRGB;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.textColor = kFONTSlectRGB;
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/100",(long)wordCount];
    [self wordLimit:textView];
}


#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 100) {
//        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}

- (IBAction)IdearResponseBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
 
}

- (IBAction)sendBtnClick:(id)sender {
    if (self.textView.text.length == 0) {

        UIAlertController *alertLength = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的信息为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *suer = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertLength addAction:suer];
        [self presentViewController:alertLength animated:YES completion:nil];
    }
    else{

        //验证手机号 ^ 邮箱
        BOOL isPhoneOrEmail = [Factory isValidateEmail:self.textField1.text]^[Factory isPhoneNumber:self.textField1.text];
        if (isPhoneOrEmail) {

            [self.idearVM postUserIdearReponseWithIdearType:self.responseType[self.textField0.text] idearContent:self.textView.text contactMethod:self.textField1.text idearImages:[self handleUploadImage] progress:^(NSProgress * _Nonnull progress) {
            
                
            /*
             
            totalUnitCount: 总单元, 用来记载某个任务的总单元数 (可以理解为某个任务正常结束时, 需要完成的任务总量)
            completedUnitCount: 已完成单元数量, 记载某个任务执行过程中已经完成的单元数量 (可以理解为, 某一个任务在执行过程中已经完成的任务量)
            fractionCompleted: 某个任务已完成单元量占总单元量的比例
            localizedDescription: 通过字符串的形式描述当前任务完成度

                格式: 100% completed

            localizedAdditionalDescription: 同localizedDescription一样, 用来描述当前任务的完成度

                格式: 9 of 10 (总任务量为10, 已完成任务量为9, 即 完成量/总量)
             
             */
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.HUD.progress = progress.completedUnitCount / progress.totalUnitCount;
                    NSLog(@"ppp%f",self.HUD.progress);
                });
                

            } CompletionHandler:^(NSError * _Nonnull error) {
                [self.HUD hideAnimated:YES];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"意见反馈" message:@"亲你的意见我们已经收到，我们会尽快处理" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *album = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:album];
                [alertController addAction:cancel];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }];
        }
        else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"通知" message:@"你输入的邮箱，QQ号或者手机号错误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:alertAction];
            [self presentViewController:alertC animated:YES completion:nil];

        }


    }
    
    
}

- (void)showHudTitle:(NSString *)hudString toView:(UIView *)view
{
    // 显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(hudString, @"HUD message title");
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.bezelView.alpha = 0.9;
    
    hud.margin = 12;
    [hud hideAnimated:YES afterDelay:1.2];
}

//头像上传
-(NSArray<UploadParam *> *)handleUploadImage
{
    
    NSMutableArray *marr = [NSMutableArray new];
    for (int i = 0; i < self.imageArray.count; ++i) {
        UIImage *image = self.imageArray[i];
        NSData *data = UIImageJPEGRepresentation(image, 0.7);
        UploadParam *param = [UploadParam new];
        param.data = data;
        param.name = @"file";
        param.filename = [@"response" stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
        param.mimeType = @"png/jepg";
        [marr addObject:param];
    }
    return marr;
    
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
