//
//  MainViewController.m
//  ChartDemo
//
//  Created by ZhangYunguang on 16/4/14.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "MainViewController.h"
#import "ChartView.h"

@interface MainViewController ()<ChartDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //取消半透明的导航栏对scrollview相关的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *leftTitles = @[@"时间",@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00"];
    NSArray *topTitles = @[@"4月1日",@"4月2日",@"4月3日",@"4月4日",@"4月5日",@"4月6日",@"4月7日",@"4月8日",@"4月9日"];
    ChartView *charView;
#if 0
    NSArray *itemImageDatas = @[@{@"0:1":@"fullOrdered"},@{@"3:3":@"ordered"}];
    charView = [[ChartView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, kscreenHeight - 290) leftTitles:leftTitles topTitles:topTitles itemImageDatas:itemImageDatas];
#elif 1
    NSArray *itemTitleDatas = @[@{@"0:1":@"item0-1"},@{@"3:3":@"item3-3"}];
    charView = [[ChartView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, kscreenHeight - 290) leftTitles:leftTitles topTitles:topTitles itemTitleDatas:itemTitleDatas];
#elif 1
    NSMutableArray *allTitles = [[NSMutableArray alloc] init];
    for (int i =0; i < (leftTitles.count - 1) * topTitles.count; i ++) {
        [allTitles addObject:[NSString stringWithFormat:@"%d",i]];
    }
    charView = [[ChartView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, kscreenHeight - 290) leftTitles:leftTitles topTitles:topTitles itemAllTitleDatas:allTitles];
#else
    //PS：下面的数据可能比表格的个数多，仅做测试用
    NSMutableArray *allImages = [NSMutableArray arrayWithCapacity:5];
    for (int i =0; i < (leftTitles.count - 1) * topTitles.count; i ++) {
        [allImages addObject:@"fullOrdered"];
        [allImages addObject:@"ordered"];
    }
    charView = [[ChartView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, 300) leftTitles:leftTitles topTitles:topTitles itemAllImageDatas:allImages];
#endif
    charView.delegate = self;
    [self.view addSubview:charView];
}
#pragma mark - ChartViewDelegate
-(void)chartViewDidSelecteItemAtRow:(NSInteger)row column:(NSInteger)column{
    NSLog(@"选中表格内容：%d行  -- %d列",row,column);
}
-(void)chartViewDidSelecteTitleAtRow:(NSInteger)row{
    NSLog(@"选中左边title：%d",row);
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
