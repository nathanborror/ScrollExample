//
//  NotificationCell.m
//  Scrolls
//
//  Created by Nathan Borror on 4/29/14.
//  Copyright (c) 2014 Nathan Borror. All rights reserved.
//

#import "NotificationCell.h"

#define PULL_THRESHOLD 96

@implementation NotificationCell {
  UIScrollView *_scroll;
  UIView *_bar;
  CALayer *_divider;
  BOOL _pulling;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    _scroll = [UIScrollView new];
    [_scroll setDelegate:self];
    [_scroll setPagingEnabled:YES];
    [_scroll setShowsHorizontalScrollIndicator:NO];
    [self addSubview:_scroll];

    _bar = [UIView new];
    [_bar setBackgroundColor:[UIColor grayColor]];
    [_scroll addSubview:_bar];
  }
  return self;
}

- (void)layoutSubviews
{
  [_scroll setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds)+PULL_THRESHOLD, CGRectGetHeight(self.bounds))];
  [_scroll setContentSize:CGSizeMake((CGRectGetWidth(self.bounds)+PULL_THRESHOLD)*2, CGRectGetHeight(self.bounds))];

  [_bar setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-1)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat offset = scrollView.contentOffset.x;

  // Did we start pulling?
  if (offset > PULL_THRESHOLD && !_pulling) {
    [_delegate scrollingCellDidBeginPulling:self];
    _pulling = YES;
  }

  if (_pulling) {
    CGFloat pullOffset = MAX(0, offset - PULL_THRESHOLD);
    [_delegate scrollingCell:self didChangePullOffset:pullOffset];
    [scrollView setTransform:CGAffineTransformMakeTranslation(pullOffset, 0)];
  }
}

- (void)scrollingEnded
{
  [_delegate scrollingCellDidEndPulling:self];
  _pulling = NO;
  [_scroll setContentOffset:CGPointZero];
  [_scroll setTransform:CGAffineTransformIdentity];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if (!decelerate) {
    [self scrollingEnded];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self scrollingEnded];
}

@end
