//
//  LockScreenViewController.m
//  Scrolls
//
//  Created by Nathan Borror on 4/28/14.
//  Copyright (c) 2014 Nathan Borror. All rights reserved.
//

#import "LockScreenViewController.h"
#import "NotificationCell.h"

@implementation LockScreenViewController {
  UIScrollView *_pager;
  UITableView *_table;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.view setBackgroundColor:[UIColor whiteColor]];

  _pager = [UIScrollView new];
  [_pager setScrollEnabled:YES];
  [_pager setPagingEnabled:YES];
  [_pager setShowsHorizontalScrollIndicator:NO];
  [self.view addSubview:_pager];

  _table = [UITableView new];
  [_table registerClass:[NotificationCell class] forCellReuseIdentifier:@"NotificationCell"];
  [_table setDelegate:self];
  [_table setDataSource:self];
  [_table setRowHeight:128.0];
  [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [_pager addSubview:_table];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];

  [_table setFrame:self.view.bounds];

  [_pager setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
  [_pager setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds)*2, CGRectGetHeight(self.view.bounds))];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
  [cell setDelegate:self];
  return cell;
}

#pragma mark - NotificationCellDelegate

- (void)scrollingCellDidBeginPulling:(NotificationCell *)cell
{
  [_pager setScrollEnabled:NO];
}

- (void)scrollingCell:(NotificationCell *)cell didChangePullOffset:(CGFloat)offset
{
  [_pager setContentOffset:CGPointMake(offset, 0)];
}

- (void)scrollingCellDidEndPulling:(NotificationCell *)cell
{
  [_pager setScrollEnabled:YES];
}

@end
