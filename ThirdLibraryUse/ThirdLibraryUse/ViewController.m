//
//  ViewController.m
//  ThirdLibraryUse
//
//  Created by 史练练 on 16/3/7.
//  Copyright © 2016年 史练练. All rights reserved.
//

#import "ViewController.h"
#import "LayoutViewController.h"
#import "LoginViewController.h"


typedef NS_ENUM(NSInteger, SELECTINDEX){

    SELECT_MASONRY,
    SELECT_FMDB,
    SELECT_RAC,
    SELECT_SSKEYCHAIN
};

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTable;

@property (nonatomic, strong) NSArray *subArr;

@end

@implementation ViewController

// 初始化表格数据
- (NSArray *)subArr{

    if (!_subArr) {
        
        _subArr = [NSArray arrayWithObjects:@"Masonry",@"FMDB",@"ReactiveCocoa",@"SSkeyChain",nil];
    }
    
    return _subArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"Test";
    
    [self initMainTable];
    
}

#pragma mark 创建table
- (void)initMainTable{

    CGRect tableRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                  [UIScreen mainScreen].bounds.size.height);
    _mainTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    
    _mainTable.delegate   = self;
    _mainTable.dataSource = self;
    
    [self.view addSubview:_mainTable];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.subArr[indexPath.row]];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.subArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger selectIdx = indexPath.row;
    
    switch (selectIdx) {
        case SELECT_MASONRY:{
        
            LayoutViewController *masonryTest = [[LayoutViewController alloc] init];
            [self.navigationController pushViewController:masonryTest animated:YES];
            
        }break;
        case SELECT_RAC:{
        
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVc animated:YES];
            
        }break;
   
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
