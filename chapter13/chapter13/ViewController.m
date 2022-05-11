//
//  ViewController.m
//  chapter13
//
//  Created by 张理想 on 2022/5/11.
//
// 13. 高效绘图

#import "ViewController.h"
#import "DrawingView.h"
#import "DrawingView2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    DrawingView *view = [[DrawingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    // 简单的类似黑板的应用
//    DrawingView2 *view =  [[DrawingView2 alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
}


@end
