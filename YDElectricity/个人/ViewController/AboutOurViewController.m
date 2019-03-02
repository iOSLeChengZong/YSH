//
//  AboutOurViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/25.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "AboutOurViewController.h"
#import <QMapKit/QMapKit.h>


//#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

@interface AboutOurViewController ()<QMapViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) QMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *mapParentView;



@end

@implementation AboutOurViewController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.mapParentView viewcornerRadius:5 borderWith:0.01 clearColor:NO];
    
}

- (void)initMap {
    _mapView = [[QMapView alloc]
                initWithFrame:CGRectMake(0,0,self.mapParentView.frame.size.width,self.mapParentView.frame.size.height)];
    
    self.mapView.delegate = self;
    _mapView.userTrackingMode = QUserTrackingModeFollow;
    _mapView.showsUserLocation = TRUE;
    _mapView.showsUserLocation = TRUE;
    [self.mapParentView addSubview:self.mapView];
    //初始化设置地图中心点坐标需要异步加入到主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(22.6564576552,114.0374207497)
                            zoomLevel:13.01
                             animated:NO];
    });
    //由于zoomLevel的调用区间是左闭右开的，在调用某一级别的图片时，
    //实际调用的是上级的最大缩放级别，底图有可能会看到锯齿，
    //此时可以在缩放级别上加上0.01使用高级别底图
    [_mapView setZoomLevel:13.01];
    NSLog(@"maxLevel:%lf",_mapView.maxZoomLevel);
    
    //添加手势识别
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(gestureAction:)];
    [gestureRecognizer setDelegate:self];
    [_mapView addGestureRecognizer:gestureRecognizer];
    
    
    
    
    //    //开启定位功能
    [_mapView setShowsUserLocation:YES];

    //定义pointAnnotation
    QPointAnnotation *yinke = [[QPointAnnotation alloc] init];
    yinke.title = @"中执时代广场";
    yinke.coordinate = CLLocationCoordinate2DMake(22.6564576552,114.0374207497);

    //向mapview添加annotation
    [_mapView addAnnotation:yinke];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMap];
    
    
    
}


- (IBAction)aboubVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    NSLog(@"开始定位");
    NSLog(@"Region:\ncenter:[%f,%f]\nspan:[%f,%f]",
          _mapView.region.center.latitude,
          _mapView.region.center.longitude,
          _mapView.region.span.latitudeDelta,
          _mapView.region.span.longitudeDelta);
    //获取开始定位的状态
   
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    NSLog(@"结束定位");
    //获取停止定位的状态
  
  
}



- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //刷新位置
    NSLog(@"位置改变中");
}
- (void)mapViewDidFailLoadingMap:(QMapView *)mapView withError:(NSError *)error{
    NSLog(@"地图失败");
    NSLog(@"%@",error.localizedDescription);
}

-(QAnnotationView *)mapView:(QMapView *)mapView
          viewForAnnotation:(id<QAnnotation>)annotation {
    static NSString *pointReuseIndentifier = @"pointReuseIdentifier";
    NSLog(@"-------------");
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        NSLog(@"-------------111111");
        //添加默认pinAnnotation
        QPinAnnotationView *annotationView = (QPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[QPinAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:pointReuseIndentifier];
        }
        //显示气泡，默认NO
        annotationView.canShowCallout = YES;
        //设置大头针颜色
        annotationView.pinColor = QPinAnnotationColorRed;
        //添加左侧信息窗附件
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.leftCalloutAccessoryView = btn;
        //可以拖动
        annotationView.draggable = YES;
        //自定义annotation图标
        UIImage *image1 = [UIImage imageNamed:@"location_orange"];
        annotationView.image = image1;
//        annotationView.userInteractionEnabled = TRUE;

//        annotationView.centerOffset = CGPointMake(0, -image1.size.height * 0.5);
        return annotationView;
            
        
       
    }
    return nil;
}





-(void)gestureAction:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationOfTouch:0 inView:_mapView];
    NSLog(@"Tap at:%f,%f", point.x, point.y);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
