//
//  CalendarViewController.m
//  Reps
//
//  Created by Gabriel Carrillo on 12/29/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import "CalendarViewController.h"
#import "RSDFDatePickerView.h"
#import "Set.h"
#import "Exercise.h"
#import "AppDelegate.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (IBAction)todayButtonTapped:(id)sender {
    [self.datePickerView scrollToToday:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
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

#pragma mark - RSDFDatePickerViewDelegate

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    NSLog(@"%@", [date description]);
}

#pragma mark - RSDFDatePickerViewDataSource

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    //NSLog(@"In datePickerView:shouldMarkDate");
    
    if (arc4random() % 2 == 0) {
        return YES;
    } else {
        return NO;
    }
}

// Returns the color of the default mark image for the specified date.
- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date
{
    NSLog(@"In datePickerView:markImageColorForDate");
    if (arc4random() % 2 == 0) {
        return [UIColor grayColor];
    } else {
        return [UIColor greenColor];
    }
}

// Returns the mark image for the specified date.
//- (UIImage *)datePickerView:(RSDFDatePickerView *)view markImageForDate:(NSDate *)date
//{
//    if (arc4random() % 2 == 0) {
//        return [UIImage imageNamed:@"img_gray_mark"];
//    } else {
//        return [UIImage imageNamed:@"img_green_mark"];
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return @"Select an exercise";
//            break;
//            
//        default:
//            break;
//    }
//    
//    return nil;
//}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //Exercise *exercise = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Set *set = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = set.exercise.name;
    //cell.detailTextLabel.text = [muscleGroupNames componentsJoinedByString:@", "];
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.selectedExercise = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [self performSegueWithIdentifier: @"showDetail" sender: self];
//}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Set" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSDate *date1 = self.datePickerView.fromDate;
    NSDate *date2 = self.datePickerView.toDate;
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date <= %@)", date1, date2];
    [fetchRequest setPredicate:datePredicate];

    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
