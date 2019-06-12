//
//  DJViewController.m
//  DJMoudlePersonal
//
//  Created by 864745256@qq.com on 06/12/2019.
//  Copyright (c) 2019 864745256@qq.com. All rights reserved.
//

#import "DJViewController.h"
#import "DJPersonalMoudleVC.h"
@interface DJViewController ()

@end

@implementation DJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}
- (IBAction)toPersonal:(id)sender {
    NSLog(@"........");
    DJPersonalMoudleVC   *djPeronalVC = [DJPersonalMoudleVC new];
//    [self.navigationController pushViewController:djPeronalVC animated:YES];
    [self presentViewController:djPeronalVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
