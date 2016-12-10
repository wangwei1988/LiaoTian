
//  Created by 51 on 16/2/1.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "UIColor+MyColor.h"

@implementation UIColor (MyColor)

+ (UIColor *)backgroundColor {
    return [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:247.0/255.0 alpha:1];
}

+ (UIColor *)borderColor {
    return [[UIColor alloc] initWithRed:201.0/255.0 green:203.0/255.0 blue:206.0/255.0 alpha:1];
}

+ (UIColor *)bigBorderColor {
    return [[UIColor alloc] initWithRed:228.0/255.0 green:228.0/255.0 blue:229.0/255.0 alpha:1];
}

#pragma mark - SendBtn Color

+ (UIColor *)sendBgNormalColor {
    return [[UIColor alloc] initWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
}

+ (UIColor *)sendBgHighlightedColor {
    return [[UIColor alloc] initWithRed:30.0/255.0 green:140.0/255.0 blue:245.0/255.0 alpha:1];
}

+ (UIColor *)sendTitleNormalColor {
    return [[UIColor alloc] initWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
}

+ (UIColor *)sendTitleHighlightedColor {
    //white
    return [[UIColor alloc] initWithWhite:1 alpha:1];
}

#pragma mark - pageController color

+ (UIColor *)pageIndicatorTintColor {
    return [[UIColor alloc] initWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
}

+ (UIColor *)currentPageIndicatorTintColor {
    return [[UIColor alloc] initWithRed:139.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1];
}

#pragma mark - EmojiCell

+ (UIColor *)emojiBgColor{
    return [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:248.0/255.0 alpha:1];
}

#pragma mark - EmojiToolBar

+ (UIColor *)lineColor {
    return [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
}

@end
