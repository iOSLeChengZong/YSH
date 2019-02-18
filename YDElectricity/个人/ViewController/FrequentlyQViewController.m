//
//  FreqentlyQViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "FrequentlyQViewController.h"

#import "FrequentlyQCollectionView.h"

#import "FrequentlyQGroupModel.h"
#import "FrequentlyQChildModel.h"

@interface FrequentlyQViewController ()

@property (nonatomic, strong) NSMutableArray<FrequentlyQGroupModel *> *models;
@end

@implementation FrequentlyQViewController
#pragma mark -- 懒加载
- (NSMutableArray<FrequentlyQGroupModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FrequentlyQData" ofType:@"plist"]];
        if (array) {
            for (NSDictionary *dict in array) {
                FrequentlyQGroupModel *model = [FrequentlyQGroupModel new];
                model.name = dict[@"name"];
                // 这里需要用 boolValue转一下, 如果直接 model.open = dict[@"open"] 会得到 YES
                model.open = [dict[@"open"] boolValue];
                model.foldable = [dict[@"foldable"] boolValue];
                NSArray *childArray = dict[@"childs"];
                for (NSDictionary *childDict in childArray) {
                    FrequentlyQChildModel *childModel = [FrequentlyQChildModel new];
                    childModel.name = childDict[@"name"];
                    
                    childModel.originalGroupNumber  = [array indexOfObject:dict];
                    childModel.originalIndexAtGroup = [childArray indexOfObject:childDict];
                    
                    [model.childModels addObject:childModel];
                }
                [_models addObject:model];
            }
        }
    }
    return _models;
}



#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    self.title = @"常见问题";
    
    FrequentlyQCollectionView *collectionView = [FrequentlyQCollectionView collectionView];
    collectionView.frame = CGRectMake(0, 18, self.view.bounds.size.width, self.view.bounds.size.height-18);
    collectionView.groupModels = self.models;
    [self.view addSubview:collectionView];
}

#pragma mark -- 代理


- (IBAction)frequentlyVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
