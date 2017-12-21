//
//  BluetoothListViewController.h
//  BluetoothText
//
//  Created by JK on 2017/12/7.
//  Copyright © 2017年 JK. All rights reserved.
//

#import <UIKit/UIKit.h>

// DEBUG 状态下才输出log
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

@interface BluetoothListViewController : UIViewController

@end
