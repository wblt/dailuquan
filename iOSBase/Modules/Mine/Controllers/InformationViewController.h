//
//  InformationViewController.h
//  iOSBase
//
//  Created by wb on 2018/7/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^ImageBlock)(void);
@interface InformationViewController : BaseViewController
@property (nonatomic, strong) ImageBlock imgBlock;
@property (nonatomic,copy) NSString *type;
@end
