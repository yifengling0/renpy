import sysconfig
for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'LDSHARED', 'CC', 'CXX', 'CFLAGS', 'LDFLAGS']:
    print(f"{k}: {sysconfig.get_config_var(k)}")
