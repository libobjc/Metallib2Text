//
//  main.m
//  Metallib2Text
//
//  Created by Single on 2019/8/20.
//  Copyright © 2019 Single. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithUTF8String:argv[1]]];
    const char *bytes = data.bytes;
    NSUInteger indexAtRow = 0;
    NSMutableString *string = [NSMutableString stringWithFormat:@"#import <Foundation/Foundation.h>\n\nconst int8_t metallib[] = {\n    "];
    for (NSUInteger i = 0; i < data.length; i++) {
        [string appendFormat:@"%d", bytes[i]];
        
        BOOL nextRow = indexAtRow == 7;
        if (i < data.length - 1) {
            [string appendFormat:@",%@", nextRow ? @"\n    " : @" "];
        }
        if (nextRow) {
            indexAtRow = 0;
        } else {
            indexAtRow += 1;
        }
    }
    [string appendString:@"\n};"];
    [[string dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithUTF8String:argv[2]] atomically:YES];
    return 0;
}
