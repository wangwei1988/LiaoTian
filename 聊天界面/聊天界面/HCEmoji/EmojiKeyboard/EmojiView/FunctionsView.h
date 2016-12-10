//
//  FunctionsView.h
//  聊天界面
//
//  Created by  王伟 on 2016/12/8.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chooseImg)();
@interface FunctionsView : UIView
@property (nonatomic , copy) chooseImg chooseImg;
@end
