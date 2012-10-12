A growing collection of useful utility classes.

NDTweener:

``` objective-c

NDTweener *tweener = [NDTweener sharedNDTweener];

// simple view tween

[tweener tweenFrame:label
                  frame:CGRectMake(10.0, 10.0, 100.0, 100.0)
               duration:1.0
             transition:tweenSineEaseIn];

// view tween with delay

[[tweener tweenFrame:testView
               frame:newRect
            duration:0.5
          transition:tweenExpoEaseOut] addDelay:4.0];

// view tween with finish block

[[tweener tweenFrame:testView
                   frame:CGRectMake(200.0, 30.0, 100.0, 50.0)
                duration:2.0
              transition:tweenQuadEaseOut] addViewFinishBlock:^(UIView *view) {
        NSLog(@"finished!!!");
    }];

// float tween with finish & update block

blah = 10.0;
[[[tweener tweenFloat:&blah
          finishValue:20.0
             duration:1.0
           transition:tweenQuadEaseIn]
addFloatUpdateBlock:^(CGFloat value)
{
    NSLog(@"float update: %f", value);
}]
 addFloatFinishBlock:^(CGFloat value)
{
    NSLog(@"float finished: %f", value);
    [self checkFloat];
}];

```

Custom easing methods possible with blocks.

