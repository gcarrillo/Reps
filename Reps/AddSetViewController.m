//
//  AddSetViewController.m
//  Reps
//
//  Created by Gabriel Carrillo on 1/16/16.
//  Copyright © 2016 Gabriel Carrillo. All rights reserved.
//

#import "AddSetViewController.h"
#import "AppDelegate.h"
#import "Exercise+CoreDataProperties.h"
#import "Set+CoreDataProperties.h"

typedef NS_ENUM(NSInteger, AddSetViewControllerState) {
    AddSetViewControllerStateExercise,
    AddSetViewControllerStateDate,
    AddSetViewControllerStateWeight
};

@interface AddSetViewController ()

@property (nonatomic, assign) AddSetViewControllerState state;
@property (nonatomic, strong) NSMutableArray *pickerRepsValues;
@property (nonatomic, strong) NSMutableArray *pickerWeightValues;

@end

@implementation AddSetViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pickerRepsValues = [[NSMutableArray alloc] init];
        _pickerWeightValues = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerView.hidden = NO;
    self.datePickerView.hidden = YES;
    
    for (int i = 1; i <= 10; i++) {
        [self.pickerRepsValues addObject:[NSNumber numberWithInt:i]];
    }
    
    for (float f = 2.5; f <= 1000; f += 2.5) {
        [self.pickerWeightValues addObject:[NSNumber numberWithFloat:f]];
    }
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;

//    // Do the CoreData fetch
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exercise"
//                                              inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    [fetchRequest setFetchBatchSize:20];
//    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    [fetchRequest setSortDescriptors:@[sortDescriptor]];
//    
//    NSError *error = nil;
//    self.exercises = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    if (!self.exercises) {
//        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
    
    self.selectedExercise = nil;
    self.state = AddSetViewControllerStateWeight;
    [self updateLayoutForState:self.state];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"In viewWillAppear");
    self.selectedDate = [NSDate date];
    
    // TODO: reload only the date row for efficiency
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ExerciseTableViewController *vc = [((UINavigationController *)[segue destinationViewController]).viewControllers firstObject];
    vc.delegate = self;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //self.state = AddSetViewControllerStateExercise;
            [self performSegueWithIdentifier:@"selectExerciseSegue" sender:self];
            break;
            
        case 1:
            self.state = AddSetViewControllerStateDate;
            break;
            
        case 2:
            self.state = AddSetViewControllerStateWeight;
            break;
            
        default:
            break;
    }

    [self updateLayoutForState:self.state];
    [self.pickerView reloadAllComponents];
}

- (void)updateLayoutForState:(AddSetViewControllerState)state {
    switch (state) {
        case AddSetViewControllerStateExercise:
            // Shouldn't get here.
            break;
            
        case AddSetViewControllerStateDate:
            self.datePickerView.hidden = NO;
            self.pickerView.hidden = YES;
            self.pickerViewConstraint.priority = UILayoutPriorityDefaultHigh - 1;
            self.datePickerViewConstraint.priority = UILayoutPriorityDefaultHigh + 1;
            break;
            
        case AddSetViewControllerStateWeight:
            self.datePickerView.hidden = YES;
            self.pickerView.hidden = NO;
            self.pickerViewConstraint.priority = UILayoutPriorityDefaultHigh + 1;
            self.datePickerViewConstraint.priority = UILayoutPriorityDefaultHigh - 1;
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"SetExerciseCell"
                                                                    forIndexPath:indexPath];
            if (self.selectedExercise) {
                cell.textLabel.text = self.selectedExercise.name;
            } else {
                cell.textLabel.text = @"Tap to select an exercise";
            }
            break;
            
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"SetDateCell"];
            cell.textLabel.text = [NSDateFormatter localizedStringFromDate:self.selectedDate
                                                                 dateStyle:NSDateFormatterShortStyle
                                                                 timeStyle:NSDateFormatterShortStyle];
            break;
        
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"SetWeightCell"];
            cell.textLabel.text = [NSString stringWithFormat:@"%d reps X %.2f lbs",
                                   self.selectedReps.intValue,
                                   self.selectedWeight.floatValue];
            break;
        default:
            break;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Exercise";
            break;
            
        case 1:
            return @"Date";
            break;
            
        case 2:
            return @"Reps & Weight";
            break;
            
        default:
            break;
    }
    
    return nil;
}

#pragma mark - UIPickerDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSLog(@"In pickerView:titleForRow:forComponent");
    switch (self.state) {
        case AddSetViewControllerStateExercise:
            return ((Exercise *)[self.exercises objectAtIndex:row]).name;
            break;
            
        case AddSetViewControllerStateDate:
            return @"A date";
            
        case AddSetViewControllerStateWeight:
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%d", ((NSNumber *)[self.pickerRepsValues objectAtIndex:row]).intValue];
                    break;
                
                case 1:
                    return [NSString stringWithFormat:@"%.1f", ((NSNumber *)[self.pickerWeightValues objectAtIndex:row]).floatValue];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    switch (self.state) {
        case AddSetViewControllerStateExercise:
            self.selectedExercise = (Exercise *)[self.exercises objectAtIndex:row];
            break;
        
        case AddSetViewControllerStateDate:
            NSLog(@"Got AddSetViewControllerStateDate in pickerView:didSelectRow:inComponent, which shouldn't happen.");
            break;
            
        case AddSetViewControllerStateWeight:
            switch (component) {
                case 0:
                    self.selectedReps = [self.pickerRepsValues objectAtIndex:row];
                    break;
                    
                case 1:
                    self.selectedWeight = [self.pickerWeightValues objectAtIndex:row];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - UIPickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.state) {
        case AddSetViewControllerStateExercise:
            return 1;
            break;
            
        case AddSetViewControllerStateDate:
            return 1;
            break;
        
        case AddSetViewControllerStateWeight:
            return 2;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    switch (self.state) {
        case AddSetViewControllerStateExercise:
            return [self.exercises count];
            break;
            
        case AddSetViewControllerStateDate:
            // TODO: fix this
            return 1;
            break;
            
        case AddSetViewControllerStateWeight:
            switch (component) {
                case 0:
                    return [self.pickerRepsValues count];
                    break;
                    
                case 1:
                    return [self.pickerWeightValues count];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    return 0;
}

#pragma mark - UIDatePicker

- (IBAction)datePickerDidSelectDate:(id)sender {
    self.selectedDate = self.datePickerView.date;
    [self.tableView reloadData];
}

#pragma mark - Save set

- (IBAction)saveButtonTapped:(id)sender {
    NSString *alertMessage = [NSString stringWithFormat:@"%@: %d reps X %.2f lbs",
                              self.selectedExercise.name, self.selectedReps.intValue,
                              self.selectedWeight.floatValue];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Save Set?"
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
        NSLog(@"You pressed button OK");
        [self saveNewSet];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action)
    {
        NSLog(@"You pressed button cancel");
    }];
    
    [alert addAction:OKAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveNewSet {
    Set *set = [NSEntityDescription insertNewObjectForEntityForName:@"Set" inManagedObjectContext:self.managedObjectContext];
    set.exercise = self.selectedExercise;
    set.date = self.selectedDate;
    set.reps = self.selectedReps;
    set.weight = self.selectedWeight;
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

#pragma mark - ExerciseTableViewControllerProtocol

- (void)exerciseTableViewController:(ExerciseTableViewController *)vc didChooseExercise:(Exercise *)exercise {
    NSLog(@"User did select an exercise");
    // dismiss the view controller
    self.selectedExercise = exercise;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)exerciseTableViewControllerDidCancel:(ExerciseTableViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
