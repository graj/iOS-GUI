//
//  ADVApartmentListViewController.m
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//


#import "ADVApartmentListViewController.h"
#import "ADVUploadImageViewController.h"
#import "ADVLoginViewController.h"
#import "ADVDetailViewController.h"
#import "ApartmentCell.h"
#import "AppDelegate.h"
#import "ApartmentSchema.h"
#import "ADVTheme.h"


@interface ADVApartmentListViewController () {
    NSNumber *latestDate;
}

@property (nonatomic, retain) NSArray *apartments;
@property (nonatomic, retain) NSMutableDictionary *apartmentImages;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(void)getAllApartments;
-(void)showErrorView:errorString;

@end

@implementation ADVApartmentListViewController


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Apartments";

    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self getLogText] style:UIBarButtonItemStylePlain target:self action:@selector(loginLogoutPressed:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPressed:)];
    
    [self.apartmentTableView setDelegate:self];
    [self.apartmentTableView setDataSource:self];
    
    self.apartmentImages = [NSMutableDictionary dictionary];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem.title = [self getLogText];
    
    [self getAllApartments];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.apartments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApartmentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ApartmentCell" forIndexPath:indexPath];
    
    ApartmentSchema *apartment = [self.apartments objectAtIndex:indexPath.row];
    
    NSString* roomCountText = [NSString stringWithFormat:@"%d Bed", apartment.roomCount];
    
    NSNumber* price = [NSNumber numberWithFloat:apartment.price];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *priceString = [numberFormatter stringFromNumber:price];
    
    [cell.locationLabel setText:apartment.location];
    [cell.priceLabel setText:priceString];
    [cell.roomsLabel setText:roomCountText];
    [cell.apartmentTypeLabel setText:apartment.apartmentType];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    cell.apartmentImageView.image = [UIImage imageNamed:[apartment photo]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"detail" sender:self];
}

#pragma mark Receive Wall Objects


-(void)getAllApartments
{
    
    ApartmentSchema* apartment1 = [[ApartmentSchema alloc] init];
    ApartmentSchema* apartment2 = [[ApartmentSchema alloc] init];
    ApartmentSchema* apartment3 = [[ApartmentSchema alloc] init];
    ApartmentSchema* apartment4 = [[ApartmentSchema alloc] init];
    
    apartment1.location = @"The Cloister, London";
    apartment1.apartmentType = @"Flat";
    apartment1.roomCount = 5;
    apartment1.price = 5600.0;
    apartment1.photo = @"apartment-1.jpg";
    
    apartment2.location = @"Regent Street, London";
    apartment2.apartmentType = @"House";
    apartment2.roomCount = 4;
    apartment2.price = 3400.0;
    apartment2.photo = @"apartment-2.jpg";
    
    apartment3.location = @"Docklands, London";
    apartment3.apartmentType = @"Flat";
    apartment3.roomCount = 3;
    apartment3.price = 2827.0;
    apartment3.photo = @"apartment-3.jpg";
    
    apartment4.location = @"Marble Arch, London";
    apartment4.apartmentType = @"House";
    apartment4.roomCount = 5;
    apartment4.price = 5300.0;
    apartment4.photo = @"apartment-4.jpg";
    
    
    self.apartments = [NSArray arrayWithObjects:apartment1, apartment2, apartment3, apartment4, nil];

}

#pragma mark IB Actions
-(IBAction)uploadPressed:(id)sender
{
    [self performSegueWithIdentifier:@"upload" sender:self];
}


-(IBAction)loginLogoutPressed:(id)sender
{
    if([self appDelegate].isLoggedIn){
    
        [self appDelegate].isLoggedIn = NO;
        self.navigationItem.leftBarButtonItem.title = [self getLogText];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSString*)getLogText{
    
    NSString* logText = [self appDelegate].isLoggedIn ? @"Log Out" : @"Log In";
    
    return logText;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"detail"]){
 
        ADVDetailViewController* detail = (ADVDetailViewController*)segue.destinationViewController;
        
        NSIndexPath* indexPath = [self.apartmentTableView indexPathForSelectedRow];
        ApartmentSchema *apartment = [self.apartments objectAtIndex:indexPath.row];
        
        detail.apartment = apartment;
        
        if([self.apartmentImages objectForKey:indexPath]){
            
            detail.apartmentImage = [self.apartmentImages objectForKey:indexPath];
        }

    }
}

#pragma mark Error Alert

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}


@end
