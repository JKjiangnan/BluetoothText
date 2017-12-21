//
//  BluetoothListViewController.m
//  BluetoothText
//
//  Created by JK on 2017/12/7.
//  Copyright © 2017年 JK. All rights reserved.
//

#import "BluetoothListViewController.h"
#import "SEPrinterManager.h"
#import "SVProgressHUD.h"

static NSString * cellIndentifer = @"bluetoothCell";

@interface BluetoothListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel * headerLabel;
@property (strong, nonatomic) NSArray * deviceArray;

@end

@implementation BluetoothListViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.title = @"未连接";

    self.automaticallyAdjustsScrollViewInsets = NO;

    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    _headerLabel.font = [UIFont systemFontOfSize:15];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = _headerLabel;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bluetoothCell"];


    SEPrinterManager *_manager = [SEPrinterManager sharedInstance];

    _headerLabel.text = _manager.connectedPerpheral.name;

    [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        NSLog(@"perpherals:%@",perpherals);
        _deviceArray = perpherals;
        [_tableView reloadData];
    } failure:^(SEScanError error) {
        NSLog(@"error:%ld",(long)error);
    }];

}


#pragma mark --- tableViewDelegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];

    CBPeripheral * per = self.deviceArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld name = %@", indexPath.row, per.name];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBPeripheral *peripheral = [self.deviceArray objectAtIndex:indexPath.row];

    [[SEPrinterManager sharedInstance] connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"连接失败"];
        } else {
            self.title = @"已连接";
            _headerLabel.text = peripheral.name;
            [SVProgressHUD showSuccessWithStatus:@"连接成功"];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
