//
//  TextCell.h
//  MapDemo
//
//  Created by zhouzhongmao on 2019/11/16.
//  Copyright © 2019 zhouzhongmao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TextCellDelegate <NSObject>

- (void)qqAction;


@end

@interface TextCell : UITableViewCell

@property (nonatomic, weak)id<TextCellDelegate> delegate;

-(void)configDataModelisOpen:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
