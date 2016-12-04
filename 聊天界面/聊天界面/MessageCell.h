//
//  AppDelegate.h
//  聊天界面
//
//  Created by  王伟 on 2016/12/4.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@interface MessageCell : UITableViewCell
@property (nonatomic , copy) Message *message;
@end
