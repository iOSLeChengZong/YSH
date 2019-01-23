//
//  menuTableViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "menuTableViewController.h"
#import "leftTagModel.h"
#import "noHeadRightModel.h"
#import "leftTableCell.h"
#import "rightCollectionViewCell.h"
#import "titleView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface menuTableViewController ()<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>


@property (strong, nonatomic) UITableView *myTableView;
//左边列表的数据源
@property (nonatomic, strong) NSMutableArray *dataList;
//右边列表的过滤数据源
@property(nonatomic,strong)NSMutableArray *rightdataList;
//右边列表数据源
@property(nonatomic,strong)NSMutableArray *allRightDataList;
//当前被选中的ID值
@property(strong,nonatomic)leftTagModel *curSelectModel;
//右边列表
@property (strong, nonatomic) UICollectionView *myCollectionView;
//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;
@property(assign,nonatomic) BOOL isReturnLastOffset;
@property(assign,nonatomic) NSInteger selectIndex;
@property(assign,nonatomic) NSIndexPath *oldIndextPath;

@property(assign,nonatomic)CGFloat oldCellY;
@property(assign,nonatomic)CGFloat selectCellY;
@end

//表格的宽度
static const CGFloat tableWidthSize=80;
//行的高度
static const CGFloat tableCellHeight=44;
//表格跟集合列表的空隙
static const CGFloat leftMargin =10;

@implementation menuTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldIndextPath = nil;
    //初始化
    self.view.backgroundColor=[UIColor whiteColor];
    self.dataList=[[NSMutableArray alloc]init];
    self.rightdataList=[[NSMutableArray alloc]init];
    self.allRightDataList=[[NSMutableArray alloc]init];
    self.isReturnLastOffset=YES;
    //是否允许右位保持滚动位置
    self.isKeepScrollState=YES;
    //测试数据
    for (int i=0; i<50; i++) {
        
        //左边列表数据
        leftTagModel *item=[[leftTagModel alloc]init];
        item.tagID=i;
        item.tagName=[NSString stringWithFormat:@"第%d层",i];
        [self.dataList addObject:item];
        
        //右边列表数据
        for (int j=0; j<55; j++) {
            noHeadRightModel *model=[[noHeadRightModel alloc]init];
            model.tagID=i;
            model.roomID=j;
            model.roomName=[NSString stringWithFormat:@"%d层房%d",i,j];
            model.roomImageUrl=[NSString stringWithFormat:@"room%d",j%5];
            [self.allRightDataList addObject:model];
        }
    }
    
    //创建列表
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,tableWidthSize, kScreenHeight) style:UITableViewStylePlain];
        _myTableView.backgroundColor=[UIColor grayColor];
        _myTableView.showsVerticalScrollIndicator = YES;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableFooterView=[[UIView alloc]init];
        _myTableView.separatorColor= [UIColor colorWithRed:52.0f/255.0f green:53.0f/255.0f blue:61.0f/255.0f alpha:1];
        [_myTableView registerClass:[leftTableCell class] forCellReuseIdentifier:NSStringFromClass([leftTableCell class])];
        
        if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            self.myTableView.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            self.myTableView.separatorInset=UIEdgeInsetsZero;
        }
        [self.view addSubview:_myTableView];
    }
    
    
    
    //创建集合表格
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(tableWidthSize+leftMargin,64, kScreenWidth-tableWidthSize-2*leftMargin, kScreenHeight) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor=[UIColor whiteColor];
        self.myCollectionView.showsHorizontalScrollIndicator=NO;
        self.myCollectionView.showsVerticalScrollIndicator=NO;
        [self.myCollectionView registerClass:[rightCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([rightCollectionViewCell class])];
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        [self.view addSubview:self.myCollectionView];
    }
    
    self.selectIndex=0;
    //默认选择第一个
    if (self.dataList.count>0) {
        self.curSelectModel=[self.dataList objectAtIndex:self.selectIndex];
        [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.myTableView reloadData];
        
        //右边数据加载
        [self predicateDataSoure];
    }

    

}

/**
 *  @author wujunyang, 15-10-11 20:10:28
 *
 *  @brief  过滤右边集合的数据
 *
 *  @since <#version number#>
 */
-(void)predicateDataSoure
{
    //过滤右边的集合数据
    NSPredicate *pre=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"tagID=%ld",self.curSelectModel.tagID]];
    self.rightdataList=[[self.allRightDataList filteredArrayUsingPredicate:pre] mutableCopy];
    [self.myCollectionView reloadData];
}

#pragma mark UITableViewDataSource, UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _oldIndextPath = indexPath;
    }
    leftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([leftTableCell class]) forIndexPath:indexPath];
    cell.curLeftTagModel = [self.dataList objectAtIndex:indexPath.section];
    cell.hasBeenSelected = (cell.curLeftTagModel==self.curSelectModel);
    
    //修改表格行默认分隔线存空隙的问题
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectIndex=indexPath.section;
    self.curSelectModel=[self.dataList objectAtIndex:indexPath.section];
    [self adjustMyTabaleViewOffset:indexPath];
    
    [self predicateDataSoure];
    //处理点击在滚动置顶的问题
//    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    
    self.isReturnLastOffset=NO;
    
    if (self.isKeepScrollState) {
        [self.myCollectionView scrollRectToVisible:CGRectMake(0, self.curSelectModel.offsetScorller, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:NO];
    }
    else{
        
        [self.myCollectionView scrollRectToVisible:CGRectMake(0, 0, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:NO];
    }
}



//集合列表的UICollectionViewDataSource, UICollectionViewDelegate实现

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.rightdataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    rightCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([rightCollectionViewCell class]) forIndexPath:indexPath];
    noHeadRightModel *model=[self.rightdataList objectAtIndex:indexPath.row];
    ccell.curNoHeadRightModel=model;
    return ccell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [rightCollectionViewCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    noHeadRightModel *model=[self.rightdataList objectAtIndex:indexPath.row];
    NSLog(@"你选择的%@",model.roomName);
}

#pragma mark---记录滑动的坐标(把右边滚动的Y值记录在列表的一个属性中)

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.myCollectionView]) {
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.myCollectionView]) {
        leftTagModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.myCollectionView]) {
        leftTagModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.myCollectionView] && self.isReturnLastOffset) {
        leftTagModel * item=self.dataList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(void) adjustMyTabaleViewOffset:(NSIndexPath *) selectIndextPath
{
    if (_oldIndextPath == selectIndextPath) {
        return;
    }
    leftTableCell *currentCell = [_myTableView cellForRowAtIndexPath:selectIndextPath];
    leftTableCell *oldCell = [_myTableView cellForRowAtIndexPath:_oldIndextPath];
     _oldIndextPath = selectIndextPath;
    
    //判断是需要滚动
    if (_myTableView.contentSize.height > _myTableView.frame.size.height){
        
        //偏移量
        CGFloat offSetY = currentCell.center.y - _myTableView.frame.size.height * 0.5;
        
        //最大偏移量
        CGFloat maxOffSetY = _myTableView.contentSize.height - _myTableView.frame.size.height;
        if (maxOffSetY < 0) {
            maxOffSetY = 0;
        }
        
        if (offSetY > maxOffSetY) {
            offSetY = maxOffSetY;
        }
        
        
        if (offSetY <= 0) {
            offSetY = 0;
            
            currentCell.hasBeenSelected = YES;
            oldCell.hasBeenSelected = NO;
            
            return;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.myTableView setContentOffset:CGPointMake(0.0, offSetY)];
        } completion:^(BOOL finished) {
            currentCell.hasBeenSelected = YES;
            oldCell.hasBeenSelected = NO;
            
        }];
        
    }
    
    else if (_myTableView.contentSize.height < _myTableView.frame.size.height){
        currentCell.hasBeenSelected = YES;
        oldCell.hasBeenSelected = NO;
    }
}

@end
