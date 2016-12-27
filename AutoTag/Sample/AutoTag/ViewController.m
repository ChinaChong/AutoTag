//
//  ViewController.m
//  AutoTag
//
//  Created by chinachong on 16/6/3.
//  Copyright © 2016年 chinachong. All rights reserved.
//

#import "ViewController.h"
#import "AutoTag.h"
@interface ViewController (){
    AutoTag *chooseVC;
}
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *selectedDataArray;
@end

@implementation ViewController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@"Energy",
                       @"Pharmaceutical Healthcare",
                       @"Financial Economics",
                       @"Automotive",
                       @"Environment",
                       @"Education",
                       @"IT Internet",
                       @"Telecoms Electronics",
                       @"Construction",
                       @"Chemical",
                       @"Legal",
                       @"Art",
                       @"Culture",
                       @"Agriculture",
                       @"Media",
                       @"Logistics Transport",
                       @"Investment",
                       @"Aero Aviation",
                       @"Tourism",
                       @"Traffic",
                       @"Food",
                       @"Machinery",
                       @"Real Estate",
                       @"Fashion Luxury",
                       @"Steel Mining",
                       @"Technology",
                       @"Design",
                       @"Market Research",
                       @"Petrol",
                       @"Government Meetings",
                       @"Sport",
                       @"Manufacturing",
                       @"Business",
                       @"Human Resources",
                       @"Movies Photography",
                       @"Engineering",
                       @"Hydraulic Power",
                       @"Hydraulic Power",
                       @"Public Management",
                       @"Shipping",
                       @"Commerce Trade",
                       @"Advertisement",
                       @"Retail",
                       @"Humanity Social Sciences",
                       @"Other"
                       ];
    }
    return _dataArray;
}
- (IBAction)goToSelect:(id)sender {
    chooseVC = [[AutoTag alloc] init];
    chooseVC.allCategory = self.dataArray.mutableCopy;
    __weak __typeof(self)weakSelf = self;
    chooseVC.chooseFinish = ^(NSArray *categorys){
        weakSelf.selectedDataArray = categorys;
        NSLog(@"%@",weakSelf.selectedDataArray);
    };
    [self.navigationController pushViewController:chooseVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主界面";
}
//- (void)chooseCategoryWithAll:(NSArray *)allData andSelectedData:(NSArray *)selectedData {
//    if (isKeyShow) {
//        [self resignFirstResponder];
//    }
//    chooseVC = [[ChooseCategoryViewController alloc] init];
//    chooseVC.allCategory = allData.mutableCopy;
//    chooseVC.haveSelected = selectedData.mutableCopy;
//    chooseVC.canMultipleChoice = NO;
//    chooseVC.titleText = @"Select  Industry";
//    chooseVC.isEnglish = YES;
//    chooseVC.tipText = @"No more than 5 tags.";
//    WEAKSELF
//    chooseVC.chooseFinish = ^(NSArray *categorys){
//        weakSelf.work.category = [categorys componentsJoinedByString:@"/"];
//        [weakSelf.tableView reloadData];
//    };
//    [self.navigationController pushViewController:chooseVC animated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
