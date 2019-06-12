//
//  DJPersonalMoudleVC.m
//  DJMoudlePersonal_Example
//
//  Created by DJAPPLE3-ysy on 2019/6/12.
//  Copyright © 2019 864745256@qq.com. All rights reserved.
//

#import "DJPersonalMoudleVC.h"

@interface DJPersonalMoudleVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView    *perSonalTable;
@end

@implementation DJPersonalMoudleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.view addSubview:self.perSonalTable];
}

-(UITableView *)perSonalTable
{
    if (!_perSonalTable) {
        _perSonalTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _perSonalTable.delegate = self;
        _perSonalTable.dataSource = self;
        _perSonalTable.backgroundColor = [UIColor orangeColor];
    }
    return _perSonalTable;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/** 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
/** 生成每行的单元格 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"测试";
    cell.textLabel.textColor = [UIColor blueColor];
    return cell;
}

/** 行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

/** 选中行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
