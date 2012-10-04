//
//  InfoViewController.m
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import "InfoViewController.h"
#import "Status.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize managedObjectContext;


-(id)initWithManagedObjectContext:(NSManagedObjectContext *)moc{
    
    if (self = [super init])
    {
        self.managedObjectContext = moc;
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Info";
    [super viewDidLoad];
    
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

@end
