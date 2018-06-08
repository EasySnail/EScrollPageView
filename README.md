# EScrollPageView

![image](https://github.com/EasySnail/EScrollPageView/blob/master/EScrollPageView/%E6%95%88%E6%9E%9C%E5%9B%BE/Page.gif)

----------------------------------------
### 框架整体介绍
- [x] 嵌套滚动的 ENestScrollPageView
- [x] 单独的分栏滚动 EScrollPageView
- [x] 分栏 EPageSegmentCT

### pods引用
```objc
pod 'EScrollPageView', '~> 0.0.1'
```
### 代码中调用 ENestScrollPageView
```objc
#import "ENestScrollPageView.h"
- (ENestScrollPageView *)pageView{
    if (_pageView == nil) {
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        EScrollPageItemBaseView *v1 = [[Test1ItemView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[Test1ItemView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"mine"];
        
        NSArray *vs = @[v1,v2,v3,v4,v5];
        //设置一些参数等等。。。
        ENestParam *param = [[ENestParam alloc] init];
        //从1开始
        param.scrollParam.segmentParam.startIndex = 1;
        //字体颜色等
        param.scrollParam.segmentParam.textColor = 0x000000;
        //分栏高度
        param.scrollParam.headerHeight = 40;
        //停留位置偏移
        param.yOffset = nvHeight;
        _pageView = [[ENestScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headView:self.headView subDataViews:vs setParam:param];
        __weak Test3VC *weakSelf = self;
        //头部滚动
        _pageView.didScrollBlock = ^(CGFloat dy) {
            [weakSelf didScroll:dy];
        };
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

```
![image](https://github.com/EasySnail/EScrollPageView/blob/master/EScrollPageView/%E6%95%88%E6%9E%9C%E5%9B%BE/simulator-11.png)
![image](https://github.com/EasySnail/EScrollPageView/blob/master/EScrollPageView/%E6%95%88%E6%9E%9C%E5%9B%BE/simulator-12.png)





### 代码中调用 EScrollPageView
```objc
#import "EScrollPageView.h"

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        EScrollPageItemBaseView *v1 = [[Test1ItemView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[Test1ItemView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"mine"];
        NSArray *vs = @[v1,v2,v3,v4,v5];
        EScrollPageParam *param = [[EScrollPageParam alloc] init];
        if (_type == 1) {
            EScrollPageItemBaseView *v6 = [[EScrollPageItemBaseView alloc] initWithPageTitle:@"小米"];
            v6.backgroundColor = [UIColor yellowColor];
            EScrollPageItemBaseView *v7 = [[EScrollPageItemBaseView alloc] initWithPageTitle:@"诺基亚"];
            v7.backgroundColor = [UIColor redColor];
            EScrollPageItemBaseView *v8 = [[Test1ItemView alloc] initWithPageTitle:@"iPhone"];
            vs = @[v1,v2,v3,v4,v5,v6,v7,v8];
            //头部高度
            param.headerHeight = 50;
            //默认第3个
            param.segmentParam.startIndex = 2;
            //排列类型
            param.segmentParam.type = EPageContentLeft;
            //每个宽度，在type == EPageContentLeft，生效
            param.segmentParam.itemWidth = 60;
            //底部线颜色
            param.segmentParam.lineColor = [UIColor purpleColor];
            //背景颜色
            param.segmentParam.bgColor = 0xeeeeee;
            //正常字体颜色
            param.segmentParam.textColor = 0x000000;
            //选中的颜色
            param.segmentParam.textSelectedColor = 0x0afbea;
        }
        _pageView = [[EScrollPageView alloc] initWithFrame:CGRectMake(0, statusBarH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-statusBarH) dataViews:vs setParam:param];
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

```
![image](https://github.com/EasySnail/EScrollPageView/blob/master/EScrollPageView/%E6%95%88%E6%9E%9C%E5%9B%BE/simulator-01.png)
![image](https://github.com/EasySnail/EScrollPageView/blob/master/EScrollPageView/%E6%95%88%E6%9E%9C%E5%9B%BE/simulator-02.png)


