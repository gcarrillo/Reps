//
//  ExerciseDetailTableViewController.m
//  Reps
//
//  Created by Gabriel Carrillo on 12/28/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import "ExerciseDetailTableViewController.h"
#import "Exercise.h"
#import "MuscleGroup.h"

typedef NS_ENUM(NSInteger, ExerciseDetailTableSection) {
    ExerciseDetailTableSectionTitle,
    ExerciseDetailTableSectionMuscleGroups,
    ExerciseDetailTableSectionCount
};

@interface ExerciseDetailTableViewController ()

@end

@implementation ExerciseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Details";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ExerciseDetailTableSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case ExerciseDetailTableSectionTitle:
            return 1;
            break;
            
        case ExerciseDetailTableSectionMuscleGroups:
            return [self.exercise.muscleGroups count];
            break;
            
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    MuscleGroup *mg;
    
    switch (indexPath.section) {
        case ExerciseDetailTableSectionTitle:
            cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
            cell.textLabel.text = self.exercise.name;
            break;
            
        case ExerciseDetailTableSectionMuscleGroups:
            cell = [tableView dequeueReusableCellWithIdentifier:@"muscleGroupCell" forIndexPath:indexPath];
            mg = (MuscleGroup *)[[self.exercise.muscleGroups allObjects] objectAtIndex:indexPath.row];
            cell.textLabel.text = mg.name;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case ExerciseDetailTableSectionTitle:
            return @"Exercise";
            break;
            
        case ExerciseDetailTableSectionMuscleGroups:
            return @"Muscle Groups Targeted";
            break;
            
        default:
            break;
    }
    
    return nil;
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
