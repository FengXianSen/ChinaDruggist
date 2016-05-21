//
//  peripheralViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "peripheralViewController.h"
#import <MapKit/MapKit.h>
@interface peripheralViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property(nonatomic,retain)CLLocationManager*magner;
@property(nonatomic,retain)MKMapView *mpview;
@property(nonatomic,strong)UIActivityIndicatorView *actvity;
@end

@implementation peripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createmanger];
    [self createmap];
    [self search];
}

-(void)search{
    [self.actvity startAnimating];
    MKLocalSearchRequest*qs=[[MKLocalSearchRequest alloc]init];
    qs.naturalLanguageQuery=@"药店";
    qs.region=_mpview.region;
    [_mpview removeAnnotations:_mpview.annotations];
    MKLocalSearch*sc =[[MKLocalSearch alloc]initWithRequest:qs];
    [sc startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error==nil) {
            for (MKMapItem *itm in response.mapItems) {
                MKPointAnnotation *pointan=[[MKPointAnnotation alloc]init];
                pointan.title=itm.name;
                pointan.subtitle=itm.phoneNumber;
                pointan.coordinate=itm.placemark.coordinate;
                [_mpview addAnnotation:pointan];
            }
            [self.actvity stopAnimating];
        }else{

            NSLog(@"%@",error);
        }
    }];


}



-(void)createmanger{
    _magner=[[CLLocationManager alloc]init];
    _magner.delegate=self;
    _magner.distanceFilter=1000.f;
    //设置精确度
    _magner.desiredAccuracy=kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        [_magner requestWhenInUseAuthorization];

    }
    _magner.delegate=self;
    [_magner startUpdatingLocation];
}
-(UIActivityIndicatorView *)actvity{
    if (_actvity==nil) {
        _actvity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _actvity.frame=CGRectMake(100, 100, 0, 0);
        _actvity.transform=CGAffineTransformMakeScale(5, 5);
        _actvity.color=[UIColor blueColor];
        _actvity.center=CGPointMake(180, 200);
        [self.view addSubview:_actvity];
    }
    return _actvity;
}
//-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    MKAnnotationView *anota=[mapView dequeueReusableAnnotationViewWithIdentifier:@"map"];
//    if (!anota) {
//        anota=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"map"];
//    }
//
//    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    img.image=[UIImage imageNamed:@"location@2x副本"];
//    anota.image=[UIImage imageNamed:@"location@2x副本"];
//    anota.canShowCallout=YES;
//    return anota;
//}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    MKPointAnnotation *annottation=view.annotation;
}



-(void)createmap{
    _mpview=[[MKMapView alloc]initWithFrame:self.view.bounds];
    //[self.view addSubview:_mpview];
    _mpview.delegate=self;
    _mpview.centerCoordinate=CLLocationCoordinate2DMake(31.380974, 121.487365);
    _mpview.region=MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(31.380974, 121.487365), 1000, 1000);
    _mpview.mapType=MKMapTypeStandard;

    MKCoordinateSpan span=MKCoordinateSpanMake(0.001, 0.001);
    MKCoordinateRegion regione=MKCoordinateRegionMake(CLLocationCoordinate2DMake(31.380974, 121.487365), span);
    _mpview.region=regione;
    MKPointAnnotation *ank=[[MKPointAnnotation alloc]init];

    ank.coordinate=CLLocationCoordinate2DMake(31.380974, 121.487365);

    [_mpview addAnnotation:ank];
    [self.view addSubview:self.mpview];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
