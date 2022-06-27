#import "./include/DeveloperDefaultsRuntime.h"
#import <objc/runtime.h>

NSArray<Class> *findAllDirectSubclassesOfClass(Class superclass) {
    NSMutableArray<Class> *result = [NSMutableArray array];
    unsigned int count;
    Class *classes = objc_copyClassList(&count);
    for (unsigned int i = 0; i < count; i++) {
        Class class = classes[i];
        if (class_getSuperclass(class) == superclass) {
            [result addObject:class];
        }
    }
    free(classes);
    return result;
}
