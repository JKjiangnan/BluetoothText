//
//  ViewController.m
//  BluetoothText
//
//  Created by JK on 2017/12/7.
//  Copyright © 2017年 JK. All rights reserved.
//

#import "ViewController.h"
#import "BluetoothListViewController.h"
#import "SEPrinterManager.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"

@interface ViewController ()
@property (strong, nonatomic) UILabel * headerLabel;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [SEPrinterManager sharedInstance].connectedPerpheral.name;
    _headerLabel.text = [SEPrinterManager sharedInstance].connectedPerpheral.name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"未连接";

    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50)];
    _headerLabel.font = [UIFont systemFontOfSize:15];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_headerLabel];

}

- (IBAction)findBluetooth:(UIButton *)sender {
    BluetoothListViewController * listVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BluetoothListViewController"];
    [self.navigationController pushViewController:listVC animated:YES];
}


- (HLPrinter *)getPrinterWith:(id)Object
{
    HLPrinter *printer = [[HLPrinter alloc] init];

    //读取本地的json数据
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"json"]];
    NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];

    //店铺信息
    NSArray * ShopInfos = datadic[@"ShopInfos"];

    [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];
    NSString *title = datadic[@"ShopName"];
    NSString *str1 = datadic[@"ShopPhone"];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter];

    for (int i= 0; i<ShopInfos.count; i++) {
        [printer appendText:ShopInfos[i] alignment:HLTextAlignmentLeft];
    }

    [printer appendNewLine];

    //商品规格信息
    NSArray * GoodsAttributes = datadic[@"GoodsAttributes"];
    [printer appendLeftTextArray:GoodsAttributes];

    //商品信息
    NSArray * GoodsProducts = datadic[@"GoodsProducts"];


    for (NSString *goodsInfo in GoodsProducts) {
        [printer appendText:goodsInfo alignment:HLTextAlignmentLeft];
    }

    [printer appendNewLine];

    //支付信息
    NSArray * PayInfos = datadic[@"PayInfos"];

    for (int i=0; i< PayInfos.count; i++){
        [printer appendText:PayInfos[i] alignment:HLTextAlignmentLeft offSet:200];
    }


    [printer appendSeperatorLine];

    [printer appendText:datadic[@"ServesInfo"] alignment:HLTextAlignmentLeft];

    [printer appendSeperatorLine];

//    [printer appendQRCodeWithInfo:@""]// 不推荐，文本太长的话，二维码底部会显示不全
    [printer appendQRCodeWithInfo:datadic[@"QRCodeURL"] size:6 alignment:HLTextAlignmentCenter];


    [printer appendNewLine];

    [printer appendText:datadic[@"FootTitle"] alignment:HLTextAlignmentCenter];

    [printer appendNewLine];

    return printer;
}

- (void)printDataText:(id)obj
{
    HLPrinter *printer = [self getPrinterWith:obj];

    NSData *mainData = [printer getFinalData];
    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
        NSLog(@"写入结：%d---错误:%@",completion,error);
    }];

}
- (IBAction)printerText:(id)sender {

    HLPrinter *printer = [self getPrinterWith:nil];

    NSData *mainData = [printer getFinalData];
    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
        NSLog(@"写入结：%d---错误:%@",completion,error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
