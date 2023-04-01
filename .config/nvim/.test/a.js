function a = (a, b) => {
    return  a + b;
}

for (const key in {'a': 't', 'b' : 's', 'c': 'u'}) {
    if ({'a': 't', 'b' : 's', 'c': 'u'}.hasOwnProperty(key)) {
         const e  = {'a': 't', 'b' : 's', 'c': 'u'}[key];
        print(e);
    }
}
