//
//  MenuHeaderView.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "MenuHeaderView.h"
#import "MenuButton.h"
//#import "DrawerView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TableViewHeight  44*4



@implementation GXIndexPath

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row
{
    if (self = [super init]) {
        _column = column;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row
{
    return [[self alloc] initWithColumn:column row:row];
}

@end


@implementation MenuListCell

+ (instancetype)createMenuListCellWithTableView:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(ScreenWidth - 36, 15, 14, 14);
        [self.contentView addSubview:_imgView];
    }
    return self;
}

@end



@interface MenuHeaderView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate/*,DrawerDelegate*/>

@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) MenuButton *currentTapBtn;
@property (nonatomic,strong) MenuButton *chooseBtn; //筛选
@property (nonatomic,strong) GXIndexPath *selectedIndexPath;

//@property (nonatomic,strong) DrawerView *drawerView;

@end


@implementation MenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectedIndexPath = [[GXIndexPath alloc] initWithColumn:0 row:0];
    }
    return self;
}

- (void)setDelegate:(id<MenuHeaderViewDelegate>)delegate
{
    _delegate = delegate;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceOfView:)]) {
        _titles = [NSMutableArray arrayWithArray:[self.delegate dataSourceOfView:self]];
    }
    _buttons = [NSMutableArray array];
    for (NSInteger i = 0; i< _titles.count; i++) {
        MenuButton *itemBtn = [MenuButton buttonWithType:UIButtonTypeCustom];
        CGFloat itemWidth = ScreenWidth/(_titles.count + 1) ;
        CGFloat itemHeight = self.bounds.size.height;
        if (_titles.count <= 4) {
            if (i==_titles.count-1) {//最后一个的位置
                itemBtn.frame = CGRectMake(ScreenWidth * 0.8/*0.75*/, 0, itemWidth, itemHeight);
                
            }else{
                itemWidth = ScreenWidth * 0.75 /(_titles.count - 1);
                itemBtn.frame = CGRectMake(itemWidth * i, 0, itemWidth, itemHeight);
            }
        }else{
            itemBtn.frame = CGRectMake(i*itemWidth, 0, itemWidth, itemHeight);
        }
        
        MenuModel *model = _titles[i];
        if (self.selectedIndexPath.column == i) {//第一个btn被选中
            model.state = @"1";
            self.currentTapBtn = itemBtn;
        }
        itemBtn.model = model;//给每一个btn 的 模型赋值,设置 title 颜色
        [self addSubview:itemBtn];
        
        /*
        if (model.imageType == ImageTypeChoose) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 1, itemHeight-30)];
            lineView.backgroundColor = [UIColor redColor];
            [itemBtn addSubview:lineView];
            
            [itemBtn addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [itemBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttons addObject:itemBtn];
        }*/
        
        [itemBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_buttons addObject:itemBtn];
    }
    
}

#pragma mark 筛选事件
- (void)chooseButtonClicked:(MenuButton *)btn
{
    self.chooseBtn = btn;
    for (MenuButton *item in _buttons) {
        if (item.model.imageType == ImageTypeList) {
            if([item.model.state isEqualToString:@"2"]){
                item.model.state = @"1";
            }
            item.model = item.model;
            [self hideMaskView];
        }
    }
//    [self.drawerView showRightView];
}

#pragma mark  点击事件、
- (void)clicked:(MenuButton *)btn
{
    self.currentTapBtn = btn;
    MenuModel *_menuModel = btn.model;
    
    //重置所有按钮状态 默认
    for (MenuButton *item in _buttons) {
        
        if (item.model.index != btn.model.index) {
            if (item.model.imageType != ImageTypeChoose) {
                item.model.state = @"0";
                item.model = item.model;//设置其它按钮的文字图片
            }
            
        }
    }
    
    switch (_menuModel.imageType) {
        case ImageTypeNone:
            _menuModel.state = @"1";
            btn.model = _menuModel;
            [self hideMaskView];
            self.selectedIndexPath = [GXIndexPath indexPathWithColumn:_menuModel.index row:-1];
            break;
        case ImageTypeList:
            if ([_menuModel.state isEqualToString:@"0"]) {
                self.selectedIndexPath = [GXIndexPath indexPathWithColumn:_menuModel.index row:_menuModel.selectedIndex];
                _menuModel.state = @"1";
                [self hideMaskView];
            }else if ([_menuModel.state isEqualToString:@"1"]){
                _menuModel.state = @"2";
                [self showMaskView];
            }else if ([_menuModel.state isEqualToString:@"2"]){
                _menuModel.state = @"1";
                [self hideMaskView];
            }
            btn.model = _menuModel;
            break;
        case ImageTypeUpAndDown:
            if ([_menuModel.state isEqualToString:@"0"]) {
                _menuModel.state = @"1";
            }else if ([_menuModel.state isEqualToString:@"1"]){
                _menuModel.state = @"2";
            }else if ([_menuModel.state isEqualToString:@"2"]){
                _menuModel.state = @"1";
            }
            self.selectedIndexPath = [GXIndexPath indexPathWithColumn:_menuModel.index row:[_menuModel.state isEqualToString:@"1"] ? 0 : 1];
            btn.model = _menuModel;
            [self hideMaskView];
            
            break;
        default:
            if ([_menuModel.state isEqualToString:@"0"]) {
                _menuModel.state = @"1";
            }else if ([_menuModel.state isEqualToString:@"1"]){
                _menuModel.state = @"0";
            }
            self.selectedIndexPath = [GXIndexPath indexPathWithColumn:_menuModel.index row:[_menuModel.state isEqualToString:@"1"] ? 0 : 1];
            btn.model = _menuModel;
            [self hideMaskView];
            break;
    }
    
}

#pragma mark  当前具体选中位置
- (void)setSelectedIndexPath:(GXIndexPath *)selectedIndexPath
{
    _selectedIndexPath = selectedIndexPath;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedIndexPath: imageType: forView:)]) {
        [self.delegate didSelectedIndexPath:selectedIndexPath imageType:self.currentTapBtn.model.imageType forView:self];
    }
    
}


#pragma mark ---- DrawerView-delegate
- (void)sendChooseDataArray:(NSArray *)array
{
    self.chooseBtn.model.state = array.count ? @"1" : @"0";
    self.chooseBtn.model = self.chooseBtn.model;
    if ([self.delegate respondsToSelector:@selector(didChooseCompletionWithData:)]) {
        [self.delegate didChooseCompletionWithData:array];
    }
}
/*
#pragma mark 右侧弹出筛选view
- (DrawerView *)drawerView
{
    if (!_drawerView) {
        _drawerView = [[DrawerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _drawerView.delegate = self;
    }
    return _drawerView;
}

#pragma mark 设置右侧弹出菜单是否支持手势
- (void)setDrawerCanPan:(BOOL)drawerCanPan
{
    _drawerCanPan = drawerCanPan;
    if (_drawerCanPan) {
        self.drawerView.supportPan = _drawerCanPan;
    }
}
*/

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentTapBtn.model.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListCell *cell = [MenuListCell createMenuListCellWithTableView:tableView];
    cell.textLabel.text = self.currentTapBtn.model.listData[indexPath.row];
    if (indexPath.row == self.currentTapBtn.model.selectedIndex && self.selectedIndexPath.column == self.currentTapBtn.model.index) {
        cell.textLabel.textColor = self.currentTapBtn.model.selectedColor;
        cell.imgView.image = [UIImage imageNamed:@"y_h_chose0"];
    }else{
        cell.textLabel.textColor = kRGBA(114, 113, 113, 1.0);
        cell.imgView.image = [UIImage imageNamed:@""];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = [GXIndexPath indexPathWithColumn:self.currentTapBtn.model.index row:indexPath.row];
    self.currentTapBtn.model.title = self.currentTapBtn.model.listData[indexPath.row];
    self.currentTapBtn.model.state = @"1";
    self.currentTapBtn.model.selectedIndex = indexPath.row;
    self.currentTapBtn.model = self.currentTapBtn.model;
    [self hideMaskView];
    //向服务器请求数据
}


- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y, ScreenWidth, ScreenHeight)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];//[UIColor colorWithWhite:0.3 alpha:0.6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
        tap.delegate = self;
        [_maskView addGestureRecognizer:tap];
        _maskView.alpha = 0.1;
    }
    return _maskView;
}

- (void)hideAction
{
    [self clicked:self.currentTapBtn];
//    [self hideMaskView];
}

- (void)showMaskView
{
    [self.superview addSubview:self.maskView];
    [self.maskView addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 1;
        CGRect frame = self.tableView.frame;
        frame.size.height = TableViewHeight;
        self.tableView.frame = frame;
       
    }];
}

- (void)hideMaskView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0;
        CGRect frame = self.tableView.frame;
        frame.size.height = 0;
        self.tableView.frame = frame;
    }completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self.maskView removeFromSuperview];
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    return  YES;
}


@end
