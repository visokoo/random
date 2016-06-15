default[:unicorn][:gc][:malloc_limit] = 50331648 # 48 mb
default[:unicorn][:gc][:heap_init_slots] = 2000000 
default[:unicorn][:gc][:heap_free_slots] = 600_000 # this is approximately 6 requests worth of objects
default[:unicorn][:gc][:heap_growth_factor] = 1.33 
default[:unicorn][:gc][:malloc_limit_max] = 16777216 # 16MB
default[:unicorn][:gc][:malloc_limit_growth_factor] = 1.4
default[:unicorn][:gc][:oldmalloc_limit] = 16777216 # 48MB
default[:unicorn][:gc][:oldmalloc_limit_growth_factor] = 1.2