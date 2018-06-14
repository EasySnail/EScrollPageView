//
//  Test4ItemView.h
//  EScrollPageView
//
//  Created by Easy on 2018/6/14.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "EScrollPageView.h"
#import "EWaterFallView.h"
#import <WebKit/WebKit.h>
#define RGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Test4ItemView : EScrollPageItemBaseView
@property(nonatomic,strong)EWaterFallView *fview;
@property(nonatomic,retain)NSMutableArray *dataArray;
@end



@interface Test3ItemView:EScrollPageItemBaseView
@property(nonatomic,retain) WKWebView *webView;
@end



@interface TestCell:UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;

@end
