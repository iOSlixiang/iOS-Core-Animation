//
//  ViewController.m
//  chapter11
//
//  Created by 张理想 on 2022/5/11.
//
// 11. 基于定时器的动画

#import "ViewController.h"

@interface ViewController ()
/** dataFormat */
@property(nonatomic, strong)NSDateFormatter *dateFormatter;
/** myView */
@property (nonatomic, strong) UIView * myView;
/** beginTime */
@property (nonatomic, assign) NSTimeInterval beginTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setupDisplayLink];
}

#pragma mark - UI

- (void)drawUI {
    [self.view addSubview:self.myView];
}

#pragma mark - CADisplayLink

- (void)setupDisplayLink {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
    // 添加到runloop
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    // 或者其他写法
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    // 赋值开始时间
    self.beginTime = CACurrentMediaTime();
}

- (void)onDisplayLink:(CADisplayLink *)displayLink {
//    NSLog(@"display link callback:%@",[self.dateFormatter stringFromDate:[NSDate date]]);
    // 获取时间间隔
    NSTimeInterval currentTime = CACurrentMediaTime() - self.beginTime;
    CGPoint fromPoint = CGPointMake(30, 60);
    CGPoint toPoint = CGPointMake(300, 500);
    NSTimeInterval duration = 2.78;
    CGFloat percent = currentTime / duration;   // 百分比
    
    if (percent > 1) {  // stop
        percent = 1;
        [displayLink invalidate];
    }
    
    percent = [self easeIn:percent];
    
    // 计算X和Y值
    CGFloat x = [self interpolateFrom:fromPoint.x to:toPoint.x percent:percent];
    CGFloat y = [self interpolateFrom:fromPoint.y to:toPoint.y percent:percent];
    
    // 赋值
    self.myView.center = CGPointMake(x, y);
}

#pragma mark - private

- (CGFloat)interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent {
    return from + (to - from) * percent;
}

- (CGFloat)easeIn:(CGFloat)p {
    return p * p;
}

#pragma mark - lazy

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    }
    return _dateFormatter;
}

- (UIView *)myView {
    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, 80, 80)];
        _myView.backgroundColor = [UIColor yellowColor];
    }
    return _myView;
}

@end
