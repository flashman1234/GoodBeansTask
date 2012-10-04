//
//  MainViewController.m
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import "MainViewController.h"
#import "InfoViewController.h"
#import "PersonListViewController.h"
#import "Person.h"
#import "AppDelegate.h"
#import "Status.h"

@implementation MainViewController
@synthesize nameTextField;
@synthesize beanTypeTextField;
@synthesize managedObjectContext;



#pragma mark - Text field methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    editingField = textField;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[editingField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [editingField resignFirstResponder];
    return YES;
}

#pragma mark - Switch views

-(void)showInfo{
    InfoViewController *infoViewController = [[[InfoViewController alloc] retain] initWithManagedObjectContext:managedObjectContext];
    [self.navigationController pushViewController:infoViewController animated:YES];
    [infoViewController release];
}

-(void)showPersonlist{
    PersonListViewController *personListViewController = [[[PersonListViewController alloc] retain] initWithManagedObjectContext:managedObjectContext];
    [self.navigationController pushViewController:personListViewController animated:YES];
    [personListViewController release];
}

-(void)showPerson:(NSString *)selectedPersonObjectId{
    PersonListViewController *personListViewController = [[[PersonListViewController alloc] retain] initWithManagedObjectContext:managedObjectContext];
    personListViewController.existingPerson = selectedPersonObjectId;
    [self.navigationController pushViewController:personListViewController animated:YES];
    [personListViewController release];
}

#pragma -

-(void)clearTextFieldsAndShowSaveLabel{
    saveLabel.text = [nameTextField.text stringByAppendingString:NSLocalizedString(@"SavedText", nil) ];
    nameTextField.text = @"";
    beanTypeTextField.text = @"";
}

-(void)savePerson{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Person *person;
    
    person = [NSEntityDescription
              insertNewObjectForEntityForName:@"Person"
              inManagedObjectContext:context];
    person.name = nameTextField.text;
    person.beanType = beanTypeTextField.text;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Couldn't save Person: %@", [error localizedDescription]);
    }
    else{
        [self clearTextFieldsAndShowSaveLabel];
    }
    
    [editingField resignFirstResponder];
}


-(void)checkPreviousAppStatus{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Status" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    
    NSArray *statuses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (statuses.count == 0) {
        Status *status = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Status"
                          inManagedObjectContext:managedObjectContext];
        status.currentViewController = NSStringFromClass([self class]);
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Couldn't save status: %@", [error localizedDescription]);
        }
    }
    else{
        
        Status *status = [statuses objectAtIndex:0];
        
        /*
         This if statement isn't very nice. Storing the current view controller should be neater than this!
         */
        if ([status.currentViewController isEqualToString:@"PersonListViewController"]) {
            [self showPersonlist];
        }
        else if ([status.currentViewController  isEqualToString:@"InfoViewController"]){
            [self showInfo];
        }
        else if ([status.currentViewController  isEqualToString:@"SelectedPersonViewController"]){
            [self showPerson:status.selectedPersonObjectId];
        }               
    }
}

#pragma mark - View

- (void)viewDidLoad{
      
    self.title = NSLocalizedString(@"TITLE", nil);

    [super viewDidLoad];
    if (managedObjectContext == nil) {
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    [self checkPreviousAppStatus];
}

-(void)viewDidAppear:(BOOL)animated{
    
    //Saves the class name of the current viewcontroller.
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Status" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    
    NSArray *statuses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    Status *status = [statuses objectAtIndex:0];
    
    status.currentViewController = NSStringFromClass([self class]);
    status.selectedPersonObjectId = @"";
    if (![managedObjectContext save:&error]) {
        NSLog(@"Couldn't save status: %@", [error localizedDescription]);
    }
    

}

-(void)viewWillAppear:(BOOL)animated{
    saveLabel.text = @"";
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void)dealloc{   
    [nameTextField release];
    [beanTypeTextField release];
    [super dealloc];
}


@end
