//
//  NotificationCell.h
//  Scrolls
//
//  Created by Nathan Borror on 4/29/14.
//  Copyright (c) 2014 Nathan Borror. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotificationCellDelegate;

@interface NotificationCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, weak) id<NotificationCellDelegate> delegate;

@end

@protocol NotificationCellDelegate <NSObject>

- (void)scrollingCellDidBeginPulling:(NotificationCell *)cell;
- (void)scrollingCell:(NotificationCell *)cell didChangePullOffset:(CGFloat)offset;
- (void)scrollingCellDidEndPulling:(NotificationCell *)cell;

@end