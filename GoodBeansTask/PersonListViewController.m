//
//  PersonListViewController.m
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import "PersonListViewController.h"
#import "Person.h"
#import "SelectedPersonViewController.h"
#import "AppDelegate.h"
#import "Status.h"

@implementation PersonListViewController
@synthesize managedObjectContext;
@synthesize personArray;
@synthesize personTableView;
@synthesize existingPerson;

#pragma mark - Table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectedPersonViewController *selectedPersonViewController = [[[SelectedPersonViewController alloc] initWithManagedObjectContext:managedObjectContext] autorelease];
   
    Person *selectedPerson = [self.personArray objectAtIndex:indexPath.row];
    selectedPersonViewController.thePerson = selectedPerson;
    
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:selectedPersonViewController];
    
    [self.navigationController presentViewController:nav1 animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.personArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.personTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Person *person = [self.personArray objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)loadPersonArray{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Person" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Person List load error : %@", error.localizedDescription);
    }
    [fetchRequest release];
    self.personArray = fetchedObjects;
    
}


#pragma mark - view and init

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)moc{
    
    if (self = [super init])
    {
        self.managedObjectContext = moc;
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"PeopleListHeader", nil);
    [super viewDidLoad];
    
    
    if (managedObjectContext == nil) {
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    [self loadPersonArray];
    

    if ([existingPerson length] != 0) {
        SelectedPersonViewController *selectedPersonViewController = [[[SelectedPersonViewController alloc] initWithManagedObjectContext:managedObjectContext] autorelease];

        NSURL *url = [NSURL URLWithString:existingPerson];
        NSManagedObjectID *moID = [managedObjectContext.persistentStoreCoordinator managedObjectIDForURIRepresentation:url];
        
        NSManagedObject *myMO = [managedObjectContext objectWithID:moID];
        

        Person *selectedPerson = (Person *)myMO;
        selectedPersonViewController.thePerson = selectedPerson;
        
        
        UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:selectedPersonViewController];
        
        [self.navigationController presentViewController:nav1 animated:YES completion:nil];
 
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc{
    [personArray release];
    [personTableView release];
    [existingPerson release];
    [super dealloc];
}

@end
