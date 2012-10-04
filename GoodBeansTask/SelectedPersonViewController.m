//
//  SelectedPersonViewController.m
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import "SelectedPersonViewController.h"
#import "Status.h"

@implementation SelectedPersonViewController
@synthesize thePerson;
@synthesize managedObjectContext;


-(void)closeViewController{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadLabels{
    nameLabel.text = thePerson.name;
    beanTypeLabel.text = thePerson.beanType;
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
    [super viewDidLoad];
    [self loadLabels];
    self.title = [NSLocalizedString(@"DetailsHeader", nil) stringByAppendingString: thePerson.name];
    
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
    
    //saves the objectId of the person being looked at
    NSString *personObjectId = [thePerson.objectID.URIRepresentation absoluteString];
    
    status.selectedPersonObjectId = personObjectId;
    status.currentViewController = NSStringFromClass([self class]);
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
    [thePerson release];
    [super dealloc];
}

@end
