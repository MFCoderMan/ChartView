//
//  ChartView.m
//  ChartDemo
//
//  Created by ZhangYunguang on 16/4/14.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "ChartView.h"
#import "ChartDefine.h"

@interface ChartView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView      *leftTableView;
@property (nonatomic, strong) UIScrollView     *contentScrollView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSMutableArray   *leftData;
@property (nonatomic, strong) NSMutableArray   *topTitleData;
@property (nonatomic, strong) NSMutableArray   *contentAllImages;
@property (nonatomic, strong) NSMutableArray   *contentAllTitles;
@property (nonatomic, strong) NSMutableArray   *contentImageData;
@property (nonatomic, strong) NSMutableArray   *contentTitleData;
@end

@implementation ChartView
#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemAllImageDatas:(NSArray *)allImages{
    if (self = [super initWithFrame:frame]) {
        _leftData          = [NSMutableArray arrayWithArray:leftTitles];
        _topTitleData      = [NSMutableArray arrayWithArray:topTitles];
        _contentAllImages  = [NSMutableArray arrayWithArray:allImages];
        [self customeChartOutlook];
        [self createLeftTableView];
        [self createContentCollectionView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemAllTitleDatas:(NSArray *)allTitles{
    if (self = [super initWithFrame:frame]) {
        _leftData          = [NSMutableArray arrayWithArray:leftTitles];
        _topTitleData      = [NSMutableArray arrayWithArray:topTitles];
        _contentAllTitles  = [NSMutableArray arrayWithArray:allTitles];
        [self customeChartOutlook];
        [self createLeftTableView];
        [self createContentCollectionView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemImageDatas:(NSArray *)imageItems{
    if (self = [super initWithFrame:frame]) {
        _leftData          = [NSMutableArray arrayWithArray:leftTitles];
        _topTitleData      = [NSMutableArray arrayWithArray:topTitles];
        _contentImageData  = [NSMutableArray arrayWithArray:imageItems];
        [self customeChartOutlook];
        [self createLeftTableView];
        [self createContentCollectionView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemTitleDatas:(NSArray *)titleItems{
    if (self = [super initWithFrame:frame]) {
        _leftData          = [NSMutableArray arrayWithArray:leftTitles];
        _topTitleData      = [NSMutableArray arrayWithArray:topTitles];
        _contentTitleData  = [NSMutableArray arrayWithArray:titleItems];
        [self customeChartOutlook];
        [self createLeftTableView];
        [self createContentCollectionView];
    }
    return self;
}
#pragma mark - 定制标格外观
-(void)customeChartOutlook{
    self.layer.borderWidth  = kChartBorderLineWidth;
    self.layer.borderColor  = kChartBorderColer;
    self.layer.cornerRadius = kChartCornerRadius;
    self.clipsToBounds      = YES;
}
#pragma mark - 左边标题栏
-(void)createLeftTableView{
    CGFloat tableHeight = kContentItemHeight * self.leftData.count;
    if (self.frame.size.height > tableHeight) {
        CGRect tempFrame      = self.frame;
        tempFrame.size.height = tableHeight;
        self.frame            = tempFrame;
    }else if (self.frame.size.height < tableHeight){
        tableHeight = self.frame.size.height;
    }
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(kChartBorderLineWidth, kChartBorderLineWidth, kLeftItemWidth, tableHeight) style:UITableViewStylePlain];
    self.leftTableView.dataSource                     = self;
    self.leftTableView.delegate                       = self;
    self.leftTableView.separatorInset                 = UIEdgeInsetsZero;
    self.leftTableView.layoutMargins                  = UIEdgeInsetsZero;
    self.leftTableView.bounces                        = NO;
    self.leftTableView.showsVerticalScrollIndicator   = NO;
    self.leftTableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.leftTableView];
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLeftTableViewCellId];
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(self.leftTableView.frame.origin.x + self.leftTableView.frame.size.width, self.leftTableView.frame.origin.y, kTitleContentSeperateLineWidth, self.leftTableView.frame.size.height)];
    vLine.backgroundColor = kLineInsideColer;
    [self addSubview:vLine];
}
#pragma mark - 右边内容栏
-(void)createContentCollectionView{
    CGFloat scrollX = self.leftTableView.frame.origin.x + self.leftTableView.frame.size.width + kTitleContentSeperateLineWidth;
    //减去0.5是为了消除黑线，如果调整了黑线的宽度，可以微调这个数来消除黑线
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX - 0.5, self.leftTableView.frame.origin.y - 0.5, self.frame.size.width - kChartBorderLineWidth - scrollX, self.leftTableView.frame.size.height)];
    //self.contentScrollView.backgroundColor = [UIColor orangeColor];
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width, kContentItemHeight * self.leftData.count);
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.contentScrollView];
    [self sendSubviewToBack:self.contentScrollView];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(kContentItemWidth, kContentItemHeight);
    self.contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentScrollView.frame.size.width, kContentItemHeight * self.leftData.count) collectionViewLayout:flow];
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.bounces = NO;
    self.contentCollectionView.showsVerticalScrollIndicator = NO;
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.contentScrollView addSubview:self.contentCollectionView];
    [self.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCollectionId];
}
#pragma mark-tableView Delegate相关
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftData.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return kContentItemHeight;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftTableViewCellId forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        title.text = self.leftData[indexPath.row];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = kLeftTitleColor;
        title.font = [UIFont systemFontOfSize:kLeftTitleFont];
        [cell.contentView addSubview:title];
        //cell.backgroundColor = [UIColor greenColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(chartViewDidSelecteTitleAtRow:)]) {
        [self.delegate chartViewDidSelecteTitleAtRow:indexPath.row];
    }
    NSLog(@"选中第%d个标题",(int)indexPath.row);
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma mark - UICollectionView dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.topTitleData.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.leftData.count;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ;
    }
    if (self.contentAllImages.count) {
        [self createChartAllImagesContentWith:cell indexpath:indexPath];
    }else if (self.contentAllTitles.count) {
        [self createChartAllTitlesContentWith:cell indexpath:indexPath];
    }else if (self.contentImageData.count) {
        [self createChartSpecialImagesContentWith:cell indexpath:indexPath];
    }else if (self.contentTitleData.count){
        [self createChartSpecialTitlesContentWith:cell indexpath:indexPath];
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.contentCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCollectionId forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        cell.layer.borderWidth = kContentLineWidth;
        cell.layer.borderColor = kLineInsideColer.CGColor;
        cell.clipsToBounds = YES;
        if (indexPath.row == 0) {
            UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
            content.font = [UIFont systemFontOfSize:kTopTitleFont];
            content.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:content];
            content.text = self.topTitleData[indexPath.section];
        }
        return cell;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.contentCollectionView) {
        if (indexPath.row != 0) {
            if ([self.delegate respondsToSelector:@selector(chartViewDidSelecteItemAtRow:column:)]) {
                [self.delegate chartViewDidSelecteItemAtRow:indexPath.row - 1 column:indexPath.section];
                //[self.delegate performSelector:@selector(chartViewDidSelecteItemAtRow:column:) withObject:nil];
            }
            NSLog(@"选中item：第%d行  %d列",indexPath.row - 1,indexPath.section);
        }
    }
    
}
#pragma mark - 创建表格内容视图
-(void)createChartAllImagesContentWith:(UICollectionViewCell *)cell indexpath:(NSIndexPath *)indexPath{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kContentItemHeight, kContentItemWidth)];
    image.image = [UIImage imageNamed:self.contentAllImages[indexPath.section * (self.leftData.count - 1) + indexPath.row - 1]];
    [cell.contentView addSubview:image];
}
-(void)createChartAllTitlesContentWith:(UICollectionViewCell *)cell indexpath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kContentItemHeight, kContentItemWidth)];
    label.text = self.contentAllTitles[indexPath.section * (self.leftData.count - 1) + indexPath.row - 1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:kContentTitleFont];
    label.textColor = kContentTitleColor;
    [cell.contentView addSubview:label];
}
-(void)createChartSpecialImagesContentWith:(UICollectionViewCell *)cell indexpath:(NSIndexPath *)indexPath{
    for (NSDictionary *dic in self.contentImageData) {
        NSArray *arr = dic.allKeys;
        NSMutableString *keyString = [NSMutableString stringWithString:arr[0]];
        NSArray *locationInfos = [keyString componentsSeparatedByString:@":"];
        if (([locationInfos[0] integerValue] == indexPath.row - 1) && [locationInfos[1] integerValue] == indexPath.section) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kContentItemHeight, kContentItemWidth)];
            image.image = [UIImage imageNamed:dic[keyString]];
            [cell.contentView addSubview:image];
        }
    }
}
-(void)createChartSpecialTitlesContentWith:(UICollectionViewCell *)cell indexpath:(NSIndexPath *)indexPath{
    for (NSDictionary *dic in self.contentTitleData) {
        NSArray *arr = dic.allKeys;
        NSMutableString *keyString = [NSMutableString stringWithString:arr[0]];
        NSArray *locationInfos = [keyString componentsSeparatedByString:@":"];
        if (([locationInfos[0] integerValue] == indexPath.row - 1) && [locationInfos[1] integerValue] == indexPath.section) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kContentItemHeight, kContentItemWidth)];
            label.text = dic[keyString];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:kContentTitleFont];
            label.textColor = kContentTitleColor;
            [cell.contentView addSubview:label];
        }
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.leftTableView) {
        self.contentScrollView.contentOffset = scrollView.contentOffset;
    }else if (scrollView == self.contentScrollView) {
        self.leftTableView.contentOffset = scrollView.contentOffset;
    }
}

@end
