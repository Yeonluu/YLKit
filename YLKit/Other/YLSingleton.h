// .h文件
#define SingletonH(name) + (instancetype)shared##name;

// .m文件
#define SingletonM(name) \
+ (instancetype)shared##name \
{ \
    static id _instace = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instace = [[super allocWithZone:NULL] init]; \
    }); \
    return _instace; \
} \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    return [self shared##name]; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    return self; \
} \
