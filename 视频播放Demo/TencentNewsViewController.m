//
//  TencentNewsViewController.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/28.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "TencentNewsViewController.h"
#import "AppDelegate.h"
#import "VideoCell.h"
#import "WMPlayer.h"
#import "PCH.h"
#import "Masonry.h"
#import "DetailViewController.h"
#import "MJRefresh.h"

@interface TencentNewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIApplicationDelegate,WMPlayerDelegate>
{
    BOOL isSmallScreen;

    
    WMPlayer *wmplay;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)VideoCell *currentVideoCell;


@end

@implementation TencentNewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        isSmallScreen = NO;
    }
    
    return self;
    
}

- (BOOL)prefersStatusBarHidden
{
    if (wmplay)
    {
        if (wmplay.isFullscreen)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //先移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    self.navigationController.navigationBarHidden = NO;
    
    //屏幕旋转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)onDeviceOrientationChange
{
    if (wmplay == nil || wmplay.superview == nil)
    {
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation )orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");

            break;
        }
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmplay.isFullscreen)
            {
                if (isSmallScreen)
                {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                else
                {
                    [self toCell];
                }
            }
            
            break;
        }
            
            
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            
            break;
        }
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            break;
        }
        default:
            break;
    }
    
}

- (void)toSmallScreen
{
    // 放在window上
    [wmplay removeFromSuperview];

    [UIView animateWithDuration:0.5f animations:^{
       
        wmplay.transform = CGAffineTransformIdentity;
        wmplay.frame = CGRectMake(kScreenWidth/2, kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75,kScreenWidth/2 ,(kScreenWidth/2)*0.75);
        wmplay.playerLayer.frame = wmplay.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmplay];
        
        [wmplay.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(wmplay).with.offset(0);
            make.right.equalTo(wmplay).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmplay).with.offset(0);
        }];
        [wmplay.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay).with.offset(0);
            make.right.equalTo(wmplay).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmplay).with.offset(0);
        }];
        [wmplay.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay.topView).with.offset(45);
            make.right.equalTo(wmplay.topView).with.offset(-45);
            make.center.equalTo(wmplay.topView);
            make.top.equalTo(wmplay.topView).with.offset(0);
        }];
        [wmplay.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmplay).with.offset(5);
            
        }];
        [wmplay.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmplay);
            make.width.equalTo(wmplay);
            make.height.equalTo(@30);
        }];

        
    }completion:^(BOOL finished) {
       
        wmplay.isFullscreen = NO;
        
        [self setNeedsStatusBarAppearanceUpdate];
        
        wmplay.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmplay];
        
    }];

    
}

- (void)toCell
{
    
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [wmplay removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        wmplay.transform = CGAffineTransformIdentity;
        wmplay.frame = currentCell.bgImageView.bounds;
        wmplay.playerLayer.frame =  wmplay.bounds;
        [currentCell.bgImageView addSubview:wmplay];
        [currentCell.bgImageView bringSubviewToFront:wmplay];
        [wmplay.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay).with.offset(0);
            make.right.equalTo(wmplay).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmplay).with.offset(0);
        }];
        [wmplay.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay).with.offset(0);
            make.right.equalTo(wmplay).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmplay).with.offset(0);
        }];
        [wmplay.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay.topView).with.offset(45);
            make.right.equalTo(wmplay.topView).with.offset(-45);
            make.center.equalTo(wmplay.topView);
            make.top.equalTo(wmplay.topView).with.offset(0);
        }];
        [wmplay.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmplay).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmplay).with.offset(5);
        }];
        [wmplay.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmplay);
            make.width.equalTo(wmplay);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmplay.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        isSmallScreen = NO;
        wmplay.fullScreenBtn.selected = NO;
        
    }];

}

#pragma mark- getter
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VideoCell"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

- (void)loadData
{
    [self.dataArray addObjectsFromArray:[AppDelegate shareAppDelegate].videoArray];
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    

    [self addMJRefresh];

}

- (void)addMJRefresh
{
    WS(weakSelf)
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [weakSelf addHudWithMessage:@"加载中..."];
        
        [[DataManager shareDataManager] getSidArrayWithUrlString:@"http://c.m.163.com/nc/video/home/0-10.html" success:^(NSArray *sidArray, NSArray *videoArray) {
            weakSelf.dataArray = [NSMutableArray arrayWithArray:videoArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentIndexPath.row > weakSelf.dataArray.count) {
                    [weakSelf releaseWMPlayer];
                }
                [weakSelf removeHud];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
                
                
            });
        } failed:^(id failed) {
            
            [weakSelf removeHud];
        }];
        
    }];
    
    
     // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header .automaticallyChangeAlpha = YES;
    
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      
        NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",weakSelf.dataArray.count - weakSelf.dataArray.count%10];
        [weakSelf addHudWithMessage:@"加载中..."];
        [[DataManager shareDataManager] getSidArrayWithUrlString:urlString success:^(NSArray *sidArray, NSArray *videoArray) {
            
            [weakSelf.dataArray addObjectsFromArray:videoArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf removeHud];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            });
           
        } failed:^(id failed) {
            
            [weakSelf removeHud];
        }];
        
        
        
        
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableView){
        if (wmplay==nil) {
            return;
        }
        
        if (wmplay.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            if (rectInSuperview.origin.y<-self.currentVideoCell.bgImageView.frame.size.height||rectInSuperview.origin.y>kScreenHeight-kNavbarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmplay]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentVideoCell.bgImageView.subviews containsObject:wmplay]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}


#pragma mark- UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];

    
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    if (wmplay&&wmplay.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmplay]) {
                wmplay.hidden = NO;
            }else{
                wmplay.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.bgImageView.subviews containsObject:wmplay]) {
                [cell.bgImageView addSubview:wmplay];
                
                [wmplay play];
                wmplay.hidden = NO;
            }
            
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 274.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
 
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.title = model.title;
    detailVC.URLString = model.m3u8_url;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)startPlayVideo:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    currentIndexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >=8 || [UIDevice currentDevice].systemVersion.floatValue<7) {
        
        self.currentVideoCell = (VideoCell *)btn.superview.superview;
    }
    else
    {//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentVideoCell = (VideoCell *)btn.superview.superview.superview;
    }
    
    VideoModel *mode = [self.dataArray objectAtIndex:btn.tag];
    
    if (isSmallScreen) {
        
        [self releaseWMPlayer];
        isSmallScreen = NO;
    }
    
     if(wmplay)
     {
         [self releaseWMPlayer];
         wmplay = [[WMPlayer alloc] initWithFrame:self.currentVideoCell.bgImageView.bounds];
         //设置代理
         wmplay.delegate = self;
         wmplay.closeBtnStyle = CloseBtnStyleClose;
         wmplay.URLString = mode.mp4_url;
         wmplay.titleLabel.text = mode.title;
     }
    else
     {
        wmplay = [[WMPlayer alloc] initWithFrame:self.currentVideoCell.bgImageView.bounds];
        //设置代理
        wmplay.delegate = self;
        wmplay.closeBtnStyle = CloseBtnStyleClose;
        wmplay.URLString = mode.mp4_url;
        wmplay.titleLabel.text = mode.title;
    }
    [self.currentVideoCell.bgImageView addSubview:wmplay];
    [self.currentVideoCell.bgImageView bringSubviewToFront:wmplay];
    [self.currentVideoCell.playBtn.superview sendSubviewToBack:self.currentVideoCell.playBtn];
    [self.tableView reloadData];
    
}

- (void)releaseWMPlayer
{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmplay pause];
    
    
    [wmplay removeFromSuperview];
    [wmplay.playerLayer removeFromSuperlayer];
    [wmplay.player replaceCurrentItemWithPlayerItem:nil];
    wmplay.player = nil;
    wmplay.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmplay.autoDismissTimer invalidate];
    wmplay.autoDismissTimer = nil;
    
    
    wmplay.playOrPauseBtn = nil;
    wmplay.playerLayer = nil;
    wmplay = nil;

}

#pragma mark- WMPlayerDelegate
//播放事件
- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn
{
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn
{
    if (fullScreenBtn.isSelected) {
        wmplayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
    else
    {
        if (isSmallScreen) {
            [self toSmallScreen];
        }
        else
        {
            [self toCell];
        }
    }
}

- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap
{
    NSLog(@"didSingleTaped");
}

- (void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap
{
    NSLog(@"didDoubleTaped");
}

//播放状态

- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    NSLog(@"wmplayerDidFailedPlay");
}

- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
     NSLog(@"wmplayerDidReadyToPlay");
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer
{
    NSLog(@"wmplayerDidFinishedPlay");
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];

}


-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [wmplay removeFromSuperview];
    wmplay.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmplay.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmplay.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmplay.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmplay.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [wmplay.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmplay.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmplay).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmplay.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmplay).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmplay).with.offset(5);
        
    }];
    
    [wmplay.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmplay.topView).with.offset(45);
        make.right.equalTo(wmplay.topView).with.offset(-45);
        make.center.equalTo(wmplay.topView);
        make.top.equalTo(wmplay.topView).with.offset(0);
    }];
    
    [wmplay.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmplay.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmplay.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmplay];
    
    wmplay.fullScreenBtn.selected = YES;
    [wmplay bringSubviewToFront:wmplay.bottomView];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
    
}
@end
