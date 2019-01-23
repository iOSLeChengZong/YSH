//
//  EditorAddressViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "EditorAddressViewController.h"
#import <BRPickerView.h>

@interface EditorAddressViewController ()<UITextFieldDelegate>
@property (nonatomic,copy) NSString* navTitle;
@property (nonatomic,strong) AddressDataModel* dataModel;
@property (nonatomic,assign) BOOL defaultAddrSelect;
@property (weak, nonatomic) IBOutlet UITextField *textField0;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIView *defaultBtnParent;


@end

@implementation EditorAddressViewController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpSubView];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    // Do any additional setup after loading the view.
    
}


#pragma mark - 获取地区数据源
- (NSArray *)getAddressDataSource {
    // 加载地区数据源（实际开发中这里可以写网络请求，从服务端请求数据。可以把 BRCity.json 文件的数据放到服务端去维护，通过接口获取这个数据源数组）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BRCity.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return dataSource;
}

#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 1 || textField.tag == 2 || textField.tag == 4 ) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 1 || textField.tag == 2 || textField.tag == 4) {
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
    NSLog(@"结束编辑:%@,tag:%ld", textField.text,textField.tag);
    switch (textField.tag) {
        case 0:
        {
            self.dataModel.name = textField.text;
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
        case 1:
        {
            self.dataModel.telphone = textField.text;
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
            
        case 2:
        {
            self.dataModel.postCode = textField.text;
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
            
        case 4:
        {
            self.dataModel.areaStr = textField.text;
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 处理点击事件
- (void)handlerTextFieldSelect:(UITextField *)textField {
    
    if (textField.tag == 3) {
        // 【转换】：以@" "自字符串为基准将字符串分离成数组，如：@"浙江省 杭州市 西湖区" ——》@[@"浙江省", @"杭州市", @"西湖区"]
        NSArray *defaultSelArr = [textField.text componentsSeparatedByString:@" "];
        //             NSArray *dataSource = [weakSelf getAddressDataSource];  //从外部传入地区数据源
        NSArray *dataSource = nil; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
            NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
            NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
            NSLog(@"--------------------");
            self.dataModel.detailAddr = self.textField3.text = [[province.name stringByAppendingString:city.name] stringByAppendingString:area.name];
//            self.dataModel.defaultStr = [[province.name stringByAppendingString:city.name] stringByAppendingString:area.name];
            [self.textField3 setTextColor:kFONTSlectRGB];
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    }
    
}

-(void)setUpSubView{
    //设置nav标题
    self.navigationItem.title = self.navTitle;
    if (self.dataModel.name) {
        self.textField0.text = self.dataModel.name;
        self.textField1.text = self.dataModel.telphone;
        self.textField2.text = self.dataModel.postCode;
        self.textField3.text = self.dataModel.detailAddr;
        self.textField4.text = self.dataModel.areaStr;
    }
    
    if ([self.dataModel.defaultStr isEqualToString:@"默认"]) {
        [self.defaultBtn setImage:[UIImage imageNamed:@"y_p_choose1"] forState:UIControlStateNormal];
    }
}

-(void)setUpViewContent:(AddressDataModel *)dataModel{
    if (!dataModel) {
        self.dataModel = [[AddressDataModel alloc]init];
        self.navTitle = @"新增地址";
    }else{
        self.dataModel = dataModel;
        self.navTitle = @"编辑地址";
    }
}


- (IBAction)editorAddressBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)defaultAddrBtnClick:(id)sender {
    self.defaultAddrSelect = !self.defaultAddrSelect;
    if ([self.dataModel.defaultStr isEqualToString:@"默认"]) {
        return;
    }
    
    [(UIButton *)sender setImage:[UIImage imageNamed:self.defaultAddrSelect ? @"y_p_choose1":@"y_p_choose0"] forState:UIControlStateNormal];
    self.dataModel.defaultStr = self.defaultAddrSelect ? @"默认":@"";
    if(self.defaultAddrSelect){
        self.dataModel.defaultStr = @"默认";
    }else{
        self.dataModel.defaultStr = @"";
    }
    
}


- (IBAction)saveBtnClick:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"-----%@,%@,%@,%@,%@",self.dataModel.name,self.dataModel.telphone,self.dataModel.postCode,self.dataModel.detailAddr,self.dataModel.areaStr);
    if (self.dataModel.name &&
        self.dataModel.telphone &&
        self.dataModel.postCode &&
        self.dataModel.detailAddr &&
        self.dataModel.areaStr) {
        if (self.delegate) {
            [self.delegate fetchNewAddr:self.dataModel];
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    }else{
        //提示输入完整信息
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入完整信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:TRUE completion:nil];
    }
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
