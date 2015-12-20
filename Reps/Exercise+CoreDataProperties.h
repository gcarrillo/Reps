//
//  Exercise+CoreDataProperties.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/19/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Exercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *muscleGroups;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *routines;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *sets;

@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addMuscleGroupsObject:(NSManagedObject *)value;
- (void)removeMuscleGroupsObject:(NSManagedObject *)value;
- (void)addMuscleGroups:(NSSet<NSManagedObject *> *)values;
- (void)removeMuscleGroups:(NSSet<NSManagedObject *> *)values;

- (void)addRoutinesObject:(NSManagedObject *)value;
- (void)removeRoutinesObject:(NSManagedObject *)value;
- (void)addRoutines:(NSSet<NSManagedObject *> *)values;
- (void)removeRoutines:(NSSet<NSManagedObject *> *)values;

- (void)addSetsObject:(NSManagedObject *)value;
- (void)removeSetsObject:(NSManagedObject *)value;
- (void)addSets:(NSSet<NSManagedObject *> *)values;
- (void)removeSets:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
