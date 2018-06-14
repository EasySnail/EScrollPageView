//
//  Test4ItemView.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/14.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "Test4ItemView.h"



@implementation Test3ItemView

- (void)didAppeared{
    [self webView];
}
- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds];
        
        NSString *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"htm"];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]]];
        [self addSubview:_webView];
    }
    return _webView;
}
@end







@implementation Test4ItemView

- (void)didAppeared{
    [self fview];
}
- (EWaterFallView *)fview{
    if (_fview == nil) {
        __weak Test4ItemView *weakSelf = self;
        _fview = [[EWaterFallView alloc] initWithFrame:self.bounds];
        //注册cell,默认 UICollectionViewCell
        _fview.registerClassCell = @"TestCell";
        
        //设置参数
        _fview.setParamBlock = ^(EWaterFallLayout *layout) {
            //设置三列
            layout.columnCount = 3;
            //设置间距
            layout.rowSpacing = 5;
            layout.columnSpacing = 5;
            //设置偏移
            layout.sectionInset = UIEdgeInsetsZero;
        };
        //返回每个item的高度
        _fview.itemHeightBlock = ^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
            return [weakSelf.dataArray[indexPath.row][@"ratio"] floatValue] *itemWidth + 20;
        };
        //返回总个数
        _fview.numberOfRowsBlock = ^NSInteger{
            return weakSelf.dataArray.count;
        };
        //返回设置cell
        _fview.cellDataBlock = ^id(UICollectionViewCell *cell, NSIndexPath *indexPath) {
            /*
             1.直接设置cell
             或者
             2.也可以在cell遵循协议执行方法：
             - (void)updateData:(id)data indexPath:(NSIndexPath *)indexPath;
             */
            return weakSelf.dataArray[indexPath.row];
        };
        
        //点击cell
        _fview.didSelectAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            NSLog(@"%ld",indexPath.row);
        };
        
        [self addSubview:_fview];
        
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock(_fview.collectionView, self.index);
        }
        
        //获取数据后刷新
        [_fview reloadData];
    }
    return _fview;
}



- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
        NSArray *colors = @[RGBColor(0xFFF68F),
                            RGBColor(0xFFC1C1),
                            RGBColor(0xFFB90F),
                            RGBColor(0xFF83FA),
                            RGBColor(0xC1FFC1),
                            RGBColor(0x8B864E),
                            RGBColor(0x71C671),
                            RGBColor(0xEECFA1),
                            RGBColor(0xCDCD00)];
        for (int i = 0; i < 100; ++i) {
            int index = arc4random()%9;
            float ratio = ((arc4random() % 13) + 3.0) / 10.0;
            [self.dataArray addObject:@{@"title":[NSString stringWithFormat:@"第%d个",i],
                                        @"image":colors[index],
                                        @"ratio":[NSString stringWithFormat:@"%f",ratio]}];
        }
    }
    return _dataArray;
}


@end

/******************************** cell *****************************************/

@implementation TestCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
- (void)updateData:(id)data indexPath:(NSIndexPath *)indexPath{
    NSDictionary *dc = data;
    
    self.imageView.backgroundColor = dc[@"image"];
    self.titleLabel.text = dc[@"title"];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    
    
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
@end
