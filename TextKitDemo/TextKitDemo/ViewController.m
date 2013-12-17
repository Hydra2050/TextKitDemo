//
//  ViewController.m
//  TextKitDemo
//
//  Created by Hydra on 13-12-15.
//  Copyright (c) 2013年 Hydra. All rights reserved.
//

#import "ViewController.h"
#import "BaseInteractionViewController.h"
#import "ExclusionPathsViewController.h"
#import "TextColoringViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* _tableView;
    NSArray* _aryTableList;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"TextKitDemo";
    _aryTableList = @[@"BaseInteraction",@"ExclusionPaths",@"TextColoring",@"demo4"];
	// Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_aryTableList != nil)
    {
        return [_aryTableList count];
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* STableCellID = @"DemoCellID";
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:STableCellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:STableCellID];
    }
    if(indexPath.row < [_aryTableList count])
    cell.textLabel.text = [_aryTableList objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if(row == 0)
    {
        BaseInteractionViewController* baseInteractionViewController = [[BaseInteractionViewController alloc] init];
        [self.navigationController pushViewController:baseInteractionViewController animated:YES];
    }
    else if(row == 1)
    {
        ExclusionPathsViewController* exclusionPathsViewController = [[ExclusionPathsViewController alloc] init];
        [self.navigationController pushViewController:exclusionPathsViewController animated:YES];
    }
    else if(row == 2)
    {
        TextColoringViewController* textColorViewController = [[TextColoringViewController alloc] init];
        [self.navigationController pushViewController:textColorViewController animated:YES];
    }
    else
    {
        //...
    }
}
@end
