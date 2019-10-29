executable(meson.project_name(),
    'exceptions.s',
    'init.s',
    'scheduler.s',
    'startup.s',
    c_args: ['-Wno-unused-command-line-argument'],
    link_args: [
        '-T', meson.current_source_dir() + '/stm32f4discovery.ld',
        '-nostdlib'])
