//
//  DrawingView.m
//  chapter13
//
//  Created by 张理想 on 2022/5/11.
//

#import "DrawingView.h"

#define BRUSH_SIZE 32

@interface DrawingView()
/** path */
@property(nonatomic, strong)UIBezierPath *path;
@end

@implementation DrawingView

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.path = [[UIBezierPath alloc] init];
//        self.path.lineJoinStyle = kCGLineJoinRound;
//        self.path.lineCapStyle = kCGLineCapRound;
//        self.path.lineWidth = 5;
//    }
//    return self;
//}

/// 用CAShapeLayer重新实现绘图应用
- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        // create a mutable path
        self.path = [[UIBezierPath alloc] init];
        
        // configure the layer
        CAShapeLayer *shaperLayer = (CAShapeLayer *)self.layer;
        shaperLayer.strokeColor = [UIColor redColor].CGColor;
        shaperLayer.fillColor = [UIColor clearColor].CGColor;
        shaperLayer.lineJoin = kCALineJoinRound;
        shaperLayer.lineCap = kCALineCapRound;
        shaperLayer.lineWidth = 5;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    // move the path drawing curor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    // add a new line segment to our path
    [self.path addLineToPoint:point];
    
    // redraw the view
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // draw path
    [[UIColor clearColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}

+ (Class)layerClass {
    // this makes our view create a cashapelayer
    // instead of a calayer for its backing layer
    return [CAShapeLayer class];
}

@end
