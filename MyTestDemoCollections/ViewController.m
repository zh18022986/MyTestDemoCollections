//
//  ViewController.m
//  MyTestDemoCollections
//
//  Created by 周浩 on 2016/12/4.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource >
/** <#注释#> */
@property (nonatomic, strong) UITableView * tableView;
/** <#注释#> */
@property (nonatomic, strong) NSArray * dataSource;

@end

static NSString *cellIdentify = @"UICollectionViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"知识点集合";
    NSString * path = [[NSBundle mainBundle] pathForResource:@"controllers" ofType:@"plist"];
    self.dataSource = [NSArray arrayWithContentsOfFile:path];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * title = [NSString stringWithFormat:@"%@ + %@",self.dataSource[indexPath.row][@"introduction"],self.dataSource[indexPath.row][@"name"]];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * title = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row][@"name"]];
    //    Class class = NSClassFromString(self.dataSource[indexPath.row][@"name"]);
    UIViewController *vc = [[NSClassFromString(self.dataSource[indexPath.row][@"name"]) alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    
    [self.navigationController pushViewController:vc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.view.bounds), CGRectGetHeight(self.navigationController.view.bounds)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
