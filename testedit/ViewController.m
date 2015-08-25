//
//  ViewController.m
//  testedit
//
//  Created by sujian on 15/8/24.
//  Copyright (c) 2015年 sujian. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *panel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *panelY;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc]init];
    NSInteger count = 100;
    for (NSInteger i = count; i>=0; i--) {
        NSString *title = [NSString stringWithFormat:@"cell %ld",i];
        [self.dataArray addObject:title];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (IBAction)selectall:(id)sender {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (IBAction)delete:(id)sender{
    NSArray *selectRows = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *list = [[NSMutableArray alloc]initWithArray:self.dataArray];
    
    for (NSInteger i = 0; i < [selectRows count]; i++) {
        NSIndexPath *indexPath = [selectRows objectAtIndex:i];
        [list removeObjectAtIndex:indexPath.row];
    }
    self.dataArray = list;
    
    [self.tableView deleteRowsAtIndexPaths:selectRows withRowAnimation:UITableViewRowAnimationRight];
}

- (IBAction)doEdit:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    [UIView animateWithDuration:.3 animations:^{
        CGFloat n = self.panelY.constant;
        if (n == 0) {
            self.panelY.constant = -44;
        }else{
            self.panelY.constant = 0;
        }

        [self.panel layoutIfNeeded];
    }];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdenitifer = @"reuseIdenitifer";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdenitifer forIndexPath:indexPath];
    cell.name.text = [NSString stringWithFormat:@"cell %ld",indexPath.row];

    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



@end
