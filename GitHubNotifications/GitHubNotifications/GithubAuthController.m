//
//  GithubAuthController.m
//  Github-Auth-iOS
//
//  Created by buza on 9/27/12.
//  Copyright (c) 2012 BuzaMoto. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import "GithubAuthController.h"

#import "GithubAuthenticatorView.h"
#import "UIView+ViewFrameGeometry.h"

@interface GithubAuthController ()

@property (nonatomic, strong) GithubAuthenticatorView *gha;

@end

@implementation GithubAuthController

@synthesize completionBlock;
@synthesize authDelegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        //We use a special view that will tell us what the proper frame size is so we can
        //make sure the login view is centered in the modal view controller.
    }
    return self;
}

-(void) didAuth:(NSString*)token
{
    [self.authDelegate didAuth:token];
    self.completionBlock();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 20.0f, ScreenWidth, 60.0f)];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor blackColor]];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20.0f weight:0.1f];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    _gha = [[GithubAuthenticatorView alloc] initWithFrame:CGRectMake(0.0f, 80.0f, ScreenWidth, self.view.height - 80.0f)];
    _gha.authDelegate = self;
    [self.view addSubview:_gha];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
