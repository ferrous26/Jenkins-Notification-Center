//
//  main.m
//  Jenkins Notifier
//
//  Created by Mark Rada on 2012-11-13.
//  Copyright (c) 2012 ferrous26. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
