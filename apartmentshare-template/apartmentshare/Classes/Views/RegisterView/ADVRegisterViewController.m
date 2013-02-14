//
//  ADVRegisterViewController.m
//  apartmentshare
//
//  Created by Tope Abayomi on 22/02/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "ADVRegisterViewController.h"
#import "AppDelegate.h"
#import "ADVTheme.h"

@interface ADVRegisterViewController ()

@end


@implementation ADVRegisterViewController

@synthesize userRegisterTextField = _userRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;
@synthesize managedObjectContext = _managedObjectContext;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    
    self.title = @"Login";
    
    self.loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 50, 294, 310) style:UITableViewStyleGrouped];
    
    [self.loginTableView setScrollEnabled:NO];
    [self.loginTableView setBackgroundView:nil];
    [self.view addSubview:self.loginTableView];
    
    [self.loginTableView setDataSource:self];
    [self.loginTableView setDelegate:self];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    
    [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    
    self.nameRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.nameRegisterTextField setPlaceholder:@"fullname"];
    [self.nameRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    self.userRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.userRegisterTextField setPlaceholder:@"Username"];
    [self.userRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    
    self.passwordRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.passwordRegisterTextField setPlaceholder:@"Password"];
    [self.passwordRegisterTextField setSecureTextEntry:YES];
    [self.passwordRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    self.rePasswordRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.rePasswordRegisterTextField setPlaceholder:@"RePassword"];
    [self.rePasswordRegisterTextField setSecureTextEntry:YES];
    [self.rePasswordRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = nil;
    
    if(indexPath.row == 0){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
        
        [cell addSubview:self.nameRegisterTextField];
        
    }
    else if(indexPath.row == 1){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
        
        [cell addSubview:self.userRegisterTextField];
        
    }
    else if (indexPath.row == 2){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
        
        [cell addSubview:self.passwordRegisterTextField];
    }
    else {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
        
        [cell addSubview:self.rePasswordRegisterTextField];
    }
    
    return cell;
}

#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
