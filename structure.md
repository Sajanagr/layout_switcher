.
├── assets
│   └── kbfix.png
├── CHANGELOG.md
├── CONTRIBUTING.md
├── debian
│   ├── changelog
│   ├── control
│   ├── .debhelper
│   │   └── generated
│   │       ├── kbfix
│   │       │   ├── dh_installchangelogs.dch.trimmed
│   │       │   ├── installed-by-dh_install
│   │       │   └── installed-by-dh_installdocs
│   │       └── _source
│   │           └── home
│   ├── debhelper-build-stamp
│   ├── files
│   ├── install
│   ├── kbfix
│   │   ├── DEBIAN
│   │   │   ├── control
│   │   │   ├── md5sums
│   │   │   ├── postinst
│   │   │   └── postrm
│   │   └── usr
│   │       ├── bin
│   │       │   └── kbfix
│   │       ├── lib
│   │       │   └── kbfix
│   │       │       └── kbfix
│   │       │           ├── __init__.py
│   │       │           ├── layout_switcher.py
│   │       │           ├── __main__.py
│   │       │           └── tray_app.py
│   │       └── share
│   │           ├── applications
│   │           │   └── kbfix-deb.desktop
│   │           ├── doc
│   │           │   └── kbfix
│   │           │       └── changelog.Debian.gz
│   │           └── icons
│   │               └── hicolor
│   │                   └── 128x128
│   │                       └── apps
│   │                           └── kbfix.png
│   ├── kbfix.substvars
│   ├── postinst
│   ├── postrm
│   └── rules
├── desktop
│   ├── kbfix-deb.desktop
│   └── kbfix.desktop
├── .dev-venv
│   ├── bin
│   │   ├── activate
│   │   ├── activate.csh
│   │   ├── activate.fish
│   │   ├── Activate.ps1
│   │   ├── pip
│   │   ├── pip3
│   │   ├── pip3.12
│   │   ├── python -> python3
│   │   ├── python3 -> /usr/bin/python3
│   │   └── python3.12 -> python3
│   ├── include
│   │   └── python3.12
│   ├── lib
│   │   └── python3.12
│   │       └── site-packages
│   │           ├── pip
│   │           │   ├── __init__.py
│   │           │   ├── _internal
│   │           │   │   ├── build_env.py
│   │           │   │   ├── cache.py
│   │           │   │   ├── cli
│   │           │   │   │   ├── autocompletion.py
│   │           │   │   │   ├── base_command.py
│   │           │   │   │   ├── cmdoptions.py
│   │           │   │   │   ├── command_context.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── main_parser.py
│   │           │   │   │   ├── main.py
│   │           │   │   │   ├── parser.py
│   │           │   │   │   ├── progress_bars.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── autocompletion.cpython-312.pyc
│   │           │   │   │   │   ├── base_command.cpython-312.pyc
│   │           │   │   │   │   ├── cmdoptions.cpython-312.pyc
│   │           │   │   │   │   ├── command_context.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── main.cpython-312.pyc
│   │           │   │   │   │   ├── main_parser.cpython-312.pyc
│   │           │   │   │   │   ├── parser.cpython-312.pyc
│   │           │   │   │   │   ├── progress_bars.cpython-312.pyc
│   │           │   │   │   │   ├── req_command.cpython-312.pyc
│   │           │   │   │   │   ├── spinners.cpython-312.pyc
│   │           │   │   │   │   └── status_codes.cpython-312.pyc
│   │           │   │   │   ├── req_command.py
│   │           │   │   │   ├── spinners.py
│   │           │   │   │   └── status_codes.py
│   │           │   │   ├── commands
│   │           │   │   │   ├── cache.py
│   │           │   │   │   ├── check.py
│   │           │   │   │   ├── completion.py
│   │           │   │   │   ├── configuration.py
│   │           │   │   │   ├── debug.py
│   │           │   │   │   ├── download.py
│   │           │   │   │   ├── freeze.py
│   │           │   │   │   ├── hash.py
│   │           │   │   │   ├── help.py
│   │           │   │   │   ├── index.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── inspect.py
│   │           │   │   │   ├── install.py
│   │           │   │   │   ├── list.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── cache.cpython-312.pyc
│   │           │   │   │   │   ├── check.cpython-312.pyc
│   │           │   │   │   │   ├── completion.cpython-312.pyc
│   │           │   │   │   │   ├── configuration.cpython-312.pyc
│   │           │   │   │   │   ├── debug.cpython-312.pyc
│   │           │   │   │   │   ├── download.cpython-312.pyc
│   │           │   │   │   │   ├── freeze.cpython-312.pyc
│   │           │   │   │   │   ├── hash.cpython-312.pyc
│   │           │   │   │   │   ├── help.cpython-312.pyc
│   │           │   │   │   │   ├── index.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── inspect.cpython-312.pyc
│   │           │   │   │   │   ├── install.cpython-312.pyc
│   │           │   │   │   │   ├── list.cpython-312.pyc
│   │           │   │   │   │   ├── search.cpython-312.pyc
│   │           │   │   │   │   ├── show.cpython-312.pyc
│   │           │   │   │   │   ├── uninstall.cpython-312.pyc
│   │           │   │   │   │   └── wheel.cpython-312.pyc
│   │           │   │   │   ├── search.py
│   │           │   │   │   ├── show.py
│   │           │   │   │   ├── uninstall.py
│   │           │   │   │   └── wheel.py
│   │           │   │   ├── configuration.py
│   │           │   │   ├── distributions
│   │           │   │   │   ├── base.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── installed.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── base.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── installed.cpython-312.pyc
│   │           │   │   │   │   ├── sdist.cpython-312.pyc
│   │           │   │   │   │   └── wheel.cpython-312.pyc
│   │           │   │   │   ├── sdist.py
│   │           │   │   │   └── wheel.py
│   │           │   │   ├── exceptions.py
│   │           │   │   ├── index
│   │           │   │   │   ├── collector.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── package_finder.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── collector.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── package_finder.cpython-312.pyc
│   │           │   │   │   │   └── sources.cpython-312.pyc
│   │           │   │   │   └── sources.py
│   │           │   │   ├── __init__.py
│   │           │   │   ├── locations
│   │           │   │   │   ├── base.py
│   │           │   │   │   ├── _distutils.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── base.cpython-312.pyc
│   │           │   │   │   │   ├── _distutils.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   └── _sysconfig.cpython-312.pyc
│   │           │   │   │   └── _sysconfig.py
│   │           │   │   ├── main.py
│   │           │   │   ├── metadata
│   │           │   │   │   ├── base.py
│   │           │   │   │   ├── importlib
│   │           │   │   │   │   ├── _compat.py
│   │           │   │   │   │   ├── _dists.py
│   │           │   │   │   │   ├── _envs.py
│   │           │   │   │   │   ├── __init__.py
│   │           │   │   │   │   └── __pycache__
│   │           │   │   │   │       ├── _compat.cpython-312.pyc
│   │           │   │   │   │       ├── _dists.cpython-312.pyc
│   │           │   │   │   │       ├── _envs.cpython-312.pyc
│   │           │   │   │   │       └── __init__.cpython-312.pyc
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── _json.py
│   │           │   │   │   ├── pkg_resources.py
│   │           │   │   │   └── __pycache__
│   │           │   │   │       ├── base.cpython-312.pyc
│   │           │   │   │       ├── __init__.cpython-312.pyc
│   │           │   │   │       ├── _json.cpython-312.pyc
│   │           │   │   │       └── pkg_resources.cpython-312.pyc
│   │           │   │   ├── models
│   │           │   │   │   ├── candidate.py
│   │           │   │   │   ├── direct_url.py
│   │           │   │   │   ├── format_control.py
│   │           │   │   │   ├── index.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── installation_report.py
│   │           │   │   │   ├── link.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── candidate.cpython-312.pyc
│   │           │   │   │   │   ├── direct_url.cpython-312.pyc
│   │           │   │   │   │   ├── format_control.cpython-312.pyc
│   │           │   │   │   │   ├── index.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── installation_report.cpython-312.pyc
│   │           │   │   │   │   ├── link.cpython-312.pyc
│   │           │   │   │   │   ├── scheme.cpython-312.pyc
│   │           │   │   │   │   ├── search_scope.cpython-312.pyc
│   │           │   │   │   │   ├── selection_prefs.cpython-312.pyc
│   │           │   │   │   │   ├── target_python.cpython-312.pyc
│   │           │   │   │   │   └── wheel.cpython-312.pyc
│   │           │   │   │   ├── scheme.py
│   │           │   │   │   ├── search_scope.py
│   │           │   │   │   ├── selection_prefs.py
│   │           │   │   │   ├── target_python.py
│   │           │   │   │   └── wheel.py
│   │           │   │   ├── network
│   │           │   │   │   ├── auth.py
│   │           │   │   │   ├── cache.py
│   │           │   │   │   ├── download.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── lazy_wheel.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── auth.cpython-312.pyc
│   │           │   │   │   │   ├── cache.cpython-312.pyc
│   │           │   │   │   │   ├── download.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── lazy_wheel.cpython-312.pyc
│   │           │   │   │   │   ├── session.cpython-312.pyc
│   │           │   │   │   │   ├── utils.cpython-312.pyc
│   │           │   │   │   │   └── xmlrpc.cpython-312.pyc
│   │           │   │   │   ├── session.py
│   │           │   │   │   ├── utils.py
│   │           │   │   │   └── xmlrpc.py
│   │           │   │   ├── operations
│   │           │   │   │   ├── build
│   │           │   │   │   │   ├── build_tracker.py
│   │           │   │   │   │   ├── __init__.py
│   │           │   │   │   │   ├── metadata_editable.py
│   │           │   │   │   │   ├── metadata_legacy.py
│   │           │   │   │   │   ├── metadata.py
│   │           │   │   │   │   ├── __pycache__
│   │           │   │   │   │   │   ├── build_tracker.cpython-312.pyc
│   │           │   │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   │   ├── metadata.cpython-312.pyc
│   │           │   │   │   │   │   ├── metadata_editable.cpython-312.pyc
│   │           │   │   │   │   │   ├── metadata_legacy.cpython-312.pyc
│   │           │   │   │   │   │   ├── wheel.cpython-312.pyc
│   │           │   │   │   │   │   ├── wheel_editable.cpython-312.pyc
│   │           │   │   │   │   │   └── wheel_legacy.cpython-312.pyc
│   │           │   │   │   │   ├── wheel_editable.py
│   │           │   │   │   │   ├── wheel_legacy.py
│   │           │   │   │   │   └── wheel.py
│   │           │   │   │   ├── check.py
│   │           │   │   │   ├── freeze.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── install
│   │           │   │   │   │   ├── editable_legacy.py
│   │           │   │   │   │   ├── __init__.py
│   │           │   │   │   │   ├── __pycache__
│   │           │   │   │   │   │   ├── editable_legacy.cpython-312.pyc
│   │           │   │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   │   └── wheel.cpython-312.pyc
│   │           │   │   │   │   └── wheel.py
│   │           │   │   │   ├── prepare.py
│   │           │   │   │   └── __pycache__
│   │           │   │   │       ├── check.cpython-312.pyc
│   │           │   │   │       ├── freeze.cpython-312.pyc
│   │           │   │   │       ├── __init__.cpython-312.pyc
│   │           │   │   │       └── prepare.cpython-312.pyc
│   │           │   │   ├── __pycache__
│   │           │   │   │   ├── build_env.cpython-312.pyc
│   │           │   │   │   ├── cache.cpython-312.pyc
│   │           │   │   │   ├── configuration.cpython-312.pyc
│   │           │   │   │   ├── exceptions.cpython-312.pyc
│   │           │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   ├── main.cpython-312.pyc
│   │           │   │   │   ├── pyproject.cpython-312.pyc
│   │           │   │   │   ├── self_outdated_check.cpython-312.pyc
│   │           │   │   │   └── wheel_builder.cpython-312.pyc
│   │           │   │   ├── pyproject.py
│   │           │   │   ├── req
│   │           │   │   │   ├── constructors.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── constructors.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── req_file.cpython-312.pyc
│   │           │   │   │   │   ├── req_install.cpython-312.pyc
│   │           │   │   │   │   ├── req_set.cpython-312.pyc
│   │           │   │   │   │   └── req_uninstall.cpython-312.pyc
│   │           │   │   │   ├── req_file.py
│   │           │   │   │   ├── req_install.py
│   │           │   │   │   ├── req_set.py
│   │           │   │   │   └── req_uninstall.py
│   │           │   │   ├── resolution
│   │           │   │   │   ├── base.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── legacy
│   │           │   │   │   │   ├── __init__.py
│   │           │   │   │   │   ├── __pycache__
│   │           │   │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   │   └── resolver.cpython-312.pyc
│   │           │   │   │   │   └── resolver.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── base.cpython-312.pyc
│   │           │   │   │   │   └── __init__.cpython-312.pyc
│   │           │   │   │   └── resolvelib
│   │           │   │   │       ├── base.py
│   │           │   │   │       ├── candidates.py
│   │           │   │   │       ├── factory.py
│   │           │   │   │       ├── found_candidates.py
│   │           │   │   │       ├── __init__.py
│   │           │   │   │       ├── provider.py
│   │           │   │   │       ├── __pycache__
│   │           │   │   │       │   ├── base.cpython-312.pyc
│   │           │   │   │       │   ├── candidates.cpython-312.pyc
│   │           │   │   │       │   ├── factory.cpython-312.pyc
│   │           │   │   │       │   ├── found_candidates.cpython-312.pyc
│   │           │   │   │       │   ├── __init__.cpython-312.pyc
│   │           │   │   │       │   ├── provider.cpython-312.pyc
│   │           │   │   │       │   ├── reporter.cpython-312.pyc
│   │           │   │   │       │   ├── requirements.cpython-312.pyc
│   │           │   │   │       │   └── resolver.cpython-312.pyc
│   │           │   │   │       ├── reporter.py
│   │           │   │   │       ├── requirements.py
│   │           │   │   │       └── resolver.py
│   │           │   │   ├── self_outdated_check.py
│   │           │   │   ├── utils
│   │           │   │   │   ├── appdirs.py
│   │           │   │   │   ├── compatibility_tags.py
│   │           │   │   │   ├── compat.py
│   │           │   │   │   ├── datetime.py
│   │           │   │   │   ├── deprecation.py
│   │           │   │   │   ├── direct_url_helpers.py
│   │           │   │   │   ├── egg_link.py
│   │           │   │   │   ├── encoding.py
│   │           │   │   │   ├── entrypoints.py
│   │           │   │   │   ├── filesystem.py
│   │           │   │   │   ├── filetypes.py
│   │           │   │   │   ├── glibc.py
│   │           │   │   │   ├── hashes.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── _jaraco_text.py
│   │           │   │   │   ├── logging.py
│   │           │   │   │   ├── _log.py
│   │           │   │   │   ├── misc.py
│   │           │   │   │   ├── models.py
│   │           │   │   │   ├── packaging.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── appdirs.cpython-312.pyc
│   │           │   │   │   │   ├── compat.cpython-312.pyc
│   │           │   │   │   │   ├── compatibility_tags.cpython-312.pyc
│   │           │   │   │   │   ├── datetime.cpython-312.pyc
│   │           │   │   │   │   ├── deprecation.cpython-312.pyc
│   │           │   │   │   │   ├── direct_url_helpers.cpython-312.pyc
│   │           │   │   │   │   ├── egg_link.cpython-312.pyc
│   │           │   │   │   │   ├── encoding.cpython-312.pyc
│   │           │   │   │   │   ├── entrypoints.cpython-312.pyc
│   │           │   │   │   │   ├── filesystem.cpython-312.pyc
│   │           │   │   │   │   ├── filetypes.cpython-312.pyc
│   │           │   │   │   │   ├── glibc.cpython-312.pyc
│   │           │   │   │   │   ├── hashes.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── _jaraco_text.cpython-312.pyc
│   │           │   │   │   │   ├── _log.cpython-312.pyc
│   │           │   │   │   │   ├── logging.cpython-312.pyc
│   │           │   │   │   │   ├── misc.cpython-312.pyc
│   │           │   │   │   │   ├── models.cpython-312.pyc
│   │           │   │   │   │   ├── packaging.cpython-312.pyc
│   │           │   │   │   │   ├── setuptools_build.cpython-312.pyc
│   │           │   │   │   │   ├── subprocess.cpython-312.pyc
│   │           │   │   │   │   ├── temp_dir.cpython-312.pyc
│   │           │   │   │   │   ├── unpacking.cpython-312.pyc
│   │           │   │   │   │   ├── urls.cpython-312.pyc
│   │           │   │   │   │   ├── virtualenv.cpython-312.pyc
│   │           │   │   │   │   └── wheel.cpython-312.pyc
│   │           │   │   │   ├── setuptools_build.py
│   │           │   │   │   ├── subprocess.py
│   │           │   │   │   ├── temp_dir.py
│   │           │   │   │   ├── unpacking.py
│   │           │   │   │   ├── urls.py
│   │           │   │   │   ├── virtualenv.py
│   │           │   │   │   └── wheel.py
│   │           │   │   ├── vcs
│   │           │   │   │   ├── bazaar.py
│   │           │   │   │   ├── git.py
│   │           │   │   │   ├── __init__.py
│   │           │   │   │   ├── mercurial.py
│   │           │   │   │   ├── __pycache__
│   │           │   │   │   │   ├── bazaar.cpython-312.pyc
│   │           │   │   │   │   ├── git.cpython-312.pyc
│   │           │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │   │   │   │   ├── mercurial.cpython-312.pyc
│   │           │   │   │   │   ├── subversion.cpython-312.pyc
│   │           │   │   │   │   └── versioncontrol.cpython-312.pyc
│   │           │   │   │   ├── subversion.py
│   │           │   │   │   └── versioncontrol.py
│   │           │   │   └── wheel_builder.py
│   │           │   ├── __main__.py
│   │           │   ├── __pip-runner__.py
│   │           │   ├── __pycache__
│   │           │   │   ├── __init__.cpython-312.pyc
│   │           │   │   ├── __main__.cpython-312.pyc
│   │           │   │   └── __pip-runner__.cpython-312.pyc
│   │           │   ├── py.typed
│   │           │   └── _vendor
│   │           │       ├── cachecontrol
│   │           │       │   ├── adapter.py
│   │           │       │   ├── cache.py
│   │           │       │   ├── caches
│   │           │       │   │   ├── file_cache.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── file_cache.cpython-312.pyc
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   └── redis_cache.cpython-312.pyc
│   │           │       │   │   └── redis_cache.py
│   │           │       │   ├── _cmd.py
│   │           │       │   ├── controller.py
│   │           │       │   ├── filewrapper.py
│   │           │       │   ├── heuristics.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── adapter.cpython-312.pyc
│   │           │       │   │   ├── cache.cpython-312.pyc
│   │           │       │   │   ├── _cmd.cpython-312.pyc
│   │           │       │   │   ├── controller.cpython-312.pyc
│   │           │       │   │   ├── filewrapper.cpython-312.pyc
│   │           │       │   │   ├── heuristics.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── serialize.cpython-312.pyc
│   │           │       │   │   └── wrapper.cpython-312.pyc
│   │           │       │   ├── serialize.py
│   │           │       │   └── wrapper.py
│   │           │       ├── certifi
│   │           │       │   ├── cacert.pem
│   │           │       │   ├── core.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── __main__.py
│   │           │       │   └── __pycache__
│   │           │       │       ├── core.cpython-312.pyc
│   │           │       │       ├── __init__.cpython-312.pyc
│   │           │       │       └── __main__.cpython-312.pyc
│   │           │       ├── chardet
│   │           │       │   ├── big5freq.py
│   │           │       │   ├── big5prober.py
│   │           │       │   ├── chardistribution.py
│   │           │       │   ├── charsetgroupprober.py
│   │           │       │   ├── charsetprober.py
│   │           │       │   ├── cli
│   │           │       │   │   ├── chardetect.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       ├── chardetect.cpython-312.pyc
│   │           │       │   │       └── __init__.cpython-312.pyc
│   │           │       │   ├── codingstatemachinedict.py
│   │           │       │   ├── codingstatemachine.py
│   │           │       │   ├── cp949prober.py
│   │           │       │   ├── enums.py
│   │           │       │   ├── escprober.py
│   │           │       │   ├── escsm.py
│   │           │       │   ├── eucjpprober.py
│   │           │       │   ├── euckrfreq.py
│   │           │       │   ├── euckrprober.py
│   │           │       │   ├── euctwfreq.py
│   │           │       │   ├── euctwprober.py
│   │           │       │   ├── gb2312freq.py
│   │           │       │   ├── gb2312prober.py
│   │           │       │   ├── hebrewprober.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── jisfreq.py
│   │           │       │   ├── johabfreq.py
│   │           │       │   ├── johabprober.py
│   │           │       │   ├── jpcntx.py
│   │           │       │   ├── langbulgarianmodel.py
│   │           │       │   ├── langgreekmodel.py
│   │           │       │   ├── langhebrewmodel.py
│   │           │       │   ├── langhungarianmodel.py
│   │           │       │   ├── langrussianmodel.py
│   │           │       │   ├── langthaimodel.py
│   │           │       │   ├── langturkishmodel.py
│   │           │       │   ├── latin1prober.py
│   │           │       │   ├── macromanprober.py
│   │           │       │   ├── mbcharsetprober.py
│   │           │       │   ├── mbcsgroupprober.py
│   │           │       │   ├── mbcssm.py
│   │           │       │   ├── metadata
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── languages.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       ├── __init__.cpython-312.pyc
│   │           │       │   │       └── languages.cpython-312.pyc
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── big5freq.cpython-312.pyc
│   │           │       │   │   ├── big5prober.cpython-312.pyc
│   │           │       │   │   ├── chardistribution.cpython-312.pyc
│   │           │       │   │   ├── charsetgroupprober.cpython-312.pyc
│   │           │       │   │   ├── charsetprober.cpython-312.pyc
│   │           │       │   │   ├── codingstatemachine.cpython-312.pyc
│   │           │       │   │   ├── codingstatemachinedict.cpython-312.pyc
│   │           │       │   │   ├── cp949prober.cpython-312.pyc
│   │           │       │   │   ├── enums.cpython-312.pyc
│   │           │       │   │   ├── escprober.cpython-312.pyc
│   │           │       │   │   ├── escsm.cpython-312.pyc
│   │           │       │   │   ├── eucjpprober.cpython-312.pyc
│   │           │       │   │   ├── euckrfreq.cpython-312.pyc
│   │           │       │   │   ├── euckrprober.cpython-312.pyc
│   │           │       │   │   ├── euctwfreq.cpython-312.pyc
│   │           │       │   │   ├── euctwprober.cpython-312.pyc
│   │           │       │   │   ├── gb2312freq.cpython-312.pyc
│   │           │       │   │   ├── gb2312prober.cpython-312.pyc
│   │           │       │   │   ├── hebrewprober.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── jisfreq.cpython-312.pyc
│   │           │       │   │   ├── johabfreq.cpython-312.pyc
│   │           │       │   │   ├── johabprober.cpython-312.pyc
│   │           │       │   │   ├── jpcntx.cpython-312.pyc
│   │           │       │   │   ├── langbulgarianmodel.cpython-312.pyc
│   │           │       │   │   ├── langgreekmodel.cpython-312.pyc
│   │           │       │   │   ├── langhebrewmodel.cpython-312.pyc
│   │           │       │   │   ├── langhungarianmodel.cpython-312.pyc
│   │           │       │   │   ├── langrussianmodel.cpython-312.pyc
│   │           │       │   │   ├── langthaimodel.cpython-312.pyc
│   │           │       │   │   ├── langturkishmodel.cpython-312.pyc
│   │           │       │   │   ├── latin1prober.cpython-312.pyc
│   │           │       │   │   ├── macromanprober.cpython-312.pyc
│   │           │       │   │   ├── mbcharsetprober.cpython-312.pyc
│   │           │       │   │   ├── mbcsgroupprober.cpython-312.pyc
│   │           │       │   │   ├── mbcssm.cpython-312.pyc
│   │           │       │   │   ├── resultdict.cpython-312.pyc
│   │           │       │   │   ├── sbcharsetprober.cpython-312.pyc
│   │           │       │   │   ├── sbcsgroupprober.cpython-312.pyc
│   │           │       │   │   ├── sjisprober.cpython-312.pyc
│   │           │       │   │   ├── universaldetector.cpython-312.pyc
│   │           │       │   │   ├── utf1632prober.cpython-312.pyc
│   │           │       │   │   ├── utf8prober.cpython-312.pyc
│   │           │       │   │   └── version.cpython-312.pyc
│   │           │       │   ├── resultdict.py
│   │           │       │   ├── sbcharsetprober.py
│   │           │       │   ├── sbcsgroupprober.py
│   │           │       │   ├── sjisprober.py
│   │           │       │   ├── universaldetector.py
│   │           │       │   ├── utf1632prober.py
│   │           │       │   ├── utf8prober.py
│   │           │       │   └── version.py
│   │           │       ├── colorama
│   │           │       │   ├── ansi.py
│   │           │       │   ├── ansitowin32.py
│   │           │       │   ├── initialise.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── ansi.cpython-312.pyc
│   │           │       │   │   ├── ansitowin32.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── initialise.cpython-312.pyc
│   │           │       │   │   ├── win32.cpython-312.pyc
│   │           │       │   │   └── winterm.cpython-312.pyc
│   │           │       │   ├── tests
│   │           │       │   │   ├── ansi_test.py
│   │           │       │   │   ├── ansitowin32_test.py
│   │           │       │   │   ├── initialise_test.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── isatty_test.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── ansi_test.cpython-312.pyc
│   │           │       │   │   │   ├── ansitowin32_test.cpython-312.pyc
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   ├── initialise_test.cpython-312.pyc
│   │           │       │   │   │   ├── isatty_test.cpython-312.pyc
│   │           │       │   │   │   ├── utils.cpython-312.pyc
│   │           │       │   │   │   └── winterm_test.cpython-312.pyc
│   │           │       │   │   ├── utils.py
│   │           │       │   │   └── winterm_test.py
│   │           │       │   ├── win32.py
│   │           │       │   └── winterm.py
│   │           │       ├── distlib
│   │           │       │   ├── compat.py
│   │           │       │   ├── database.py
│   │           │       │   ├── index.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── locators.py
│   │           │       │   ├── manifest.py
│   │           │       │   ├── markers.py
│   │           │       │   ├── metadata.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── compat.cpython-312.pyc
│   │           │       │   │   ├── database.cpython-312.pyc
│   │           │       │   │   ├── index.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── locators.cpython-312.pyc
│   │           │       │   │   ├── manifest.cpython-312.pyc
│   │           │       │   │   ├── markers.cpython-312.pyc
│   │           │       │   │   ├── metadata.cpython-312.pyc
│   │           │       │   │   ├── resources.cpython-312.pyc
│   │           │       │   │   ├── scripts.cpython-312.pyc
│   │           │       │   │   ├── util.cpython-312.pyc
│   │           │       │   │   ├── version.cpython-312.pyc
│   │           │       │   │   └── wheel.cpython-312.pyc
│   │           │       │   ├── resources.py
│   │           │       │   ├── scripts.py
│   │           │       │   ├── util.py
│   │           │       │   ├── version.py
│   │           │       │   └── wheel.py
│   │           │       ├── distro
│   │           │       │   ├── distro.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── __main__.py
│   │           │       │   └── __pycache__
│   │           │       │       ├── distro.cpython-312.pyc
│   │           │       │       ├── __init__.cpython-312.pyc
│   │           │       │       └── __main__.cpython-312.pyc
│   │           │       ├── idna
│   │           │       │   ├── codec.py
│   │           │       │   ├── compat.py
│   │           │       │   ├── core.py
│   │           │       │   ├── idnadata.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── intranges.py
│   │           │       │   ├── package_data.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── codec.cpython-312.pyc
│   │           │       │   │   ├── compat.cpython-312.pyc
│   │           │       │   │   ├── core.cpython-312.pyc
│   │           │       │   │   ├── idnadata.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── intranges.cpython-312.pyc
│   │           │       │   │   ├── package_data.cpython-312.pyc
│   │           │       │   │   └── uts46data.cpython-312.pyc
│   │           │       │   └── uts46data.py
│   │           │       ├── __init__.py
│   │           │       ├── msgpack
│   │           │       │   ├── exceptions.py
│   │           │       │   ├── ext.py
│   │           │       │   ├── fallback.py
│   │           │       │   ├── __init__.py
│   │           │       │   └── __pycache__
│   │           │       │       ├── exceptions.cpython-312.pyc
│   │           │       │       ├── ext.cpython-312.pyc
│   │           │       │       ├── fallback.cpython-312.pyc
│   │           │       │       └── __init__.cpython-312.pyc
│   │           │       ├── packaging
│   │           │       │   ├── __about__.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _manylinux.py
│   │           │       │   ├── markers.py
│   │           │       │   ├── _musllinux.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── __about__.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── _manylinux.cpython-312.pyc
│   │           │       │   │   ├── markers.cpython-312.pyc
│   │           │       │   │   ├── _musllinux.cpython-312.pyc
│   │           │       │   │   ├── requirements.cpython-312.pyc
│   │           │       │   │   ├── specifiers.cpython-312.pyc
│   │           │       │   │   ├── _structures.cpython-312.pyc
│   │           │       │   │   ├── tags.cpython-312.pyc
│   │           │       │   │   ├── utils.cpython-312.pyc
│   │           │       │   │   └── version.cpython-312.pyc
│   │           │       │   ├── requirements.py
│   │           │       │   ├── specifiers.py
│   │           │       │   ├── _structures.py
│   │           │       │   ├── tags.py
│   │           │       │   ├── utils.py
│   │           │       │   └── version.py
│   │           │       ├── pkg_resources
│   │           │       │   ├── __init__.py
│   │           │       │   └── __pycache__
│   │           │       │       └── __init__.cpython-312.pyc
│   │           │       ├── platformdirs
│   │           │       │   ├── android.py
│   │           │       │   ├── api.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── macos.py
│   │           │       │   ├── __main__.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── android.cpython-312.pyc
│   │           │       │   │   ├── api.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── macos.cpython-312.pyc
│   │           │       │   │   ├── __main__.cpython-312.pyc
│   │           │       │   │   ├── unix.cpython-312.pyc
│   │           │       │   │   ├── version.cpython-312.pyc
│   │           │       │   │   └── windows.cpython-312.pyc
│   │           │       │   ├── unix.py
│   │           │       │   ├── version.py
│   │           │       │   └── windows.py
│   │           │       ├── __pycache__
│   │           │       │   ├── __init__.cpython-312.pyc
│   │           │       │   ├── six.cpython-312.pyc
│   │           │       │   └── typing_extensions.cpython-312.pyc
│   │           │       ├── pygments
│   │           │       │   ├── cmdline.py
│   │           │       │   ├── console.py
│   │           │       │   ├── filter.py
│   │           │       │   ├── filters
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       └── __init__.cpython-312.pyc
│   │           │       │   ├── formatter.py
│   │           │       │   ├── formatters
│   │           │       │   │   ├── bbcode.py
│   │           │       │   │   ├── groff.py
│   │           │       │   │   ├── html.py
│   │           │       │   │   ├── img.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── irc.py
│   │           │       │   │   ├── latex.py
│   │           │       │   │   ├── _mapping.py
│   │           │       │   │   ├── other.py
│   │           │       │   │   ├── pangomarkup.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── bbcode.cpython-312.pyc
│   │           │       │   │   │   ├── groff.cpython-312.pyc
│   │           │       │   │   │   ├── html.cpython-312.pyc
│   │           │       │   │   │   ├── img.cpython-312.pyc
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   ├── irc.cpython-312.pyc
│   │           │       │   │   │   ├── latex.cpython-312.pyc
│   │           │       │   │   │   ├── _mapping.cpython-312.pyc
│   │           │       │   │   │   ├── other.cpython-312.pyc
│   │           │       │   │   │   ├── pangomarkup.cpython-312.pyc
│   │           │       │   │   │   ├── rtf.cpython-312.pyc
│   │           │       │   │   │   ├── svg.cpython-312.pyc
│   │           │       │   │   │   ├── terminal256.cpython-312.pyc
│   │           │       │   │   │   └── terminal.cpython-312.pyc
│   │           │       │   │   ├── rtf.py
│   │           │       │   │   ├── svg.py
│   │           │       │   │   ├── terminal256.py
│   │           │       │   │   └── terminal.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── lexer.py
│   │           │       │   ├── lexers
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── _mapping.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   ├── _mapping.cpython-312.pyc
│   │           │       │   │   │   └── python.cpython-312.pyc
│   │           │       │   │   └── python.py
│   │           │       │   ├── __main__.py
│   │           │       │   ├── modeline.py
│   │           │       │   ├── plugin.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── cmdline.cpython-312.pyc
│   │           │       │   │   ├── console.cpython-312.pyc
│   │           │       │   │   ├── filter.cpython-312.pyc
│   │           │       │   │   ├── formatter.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── lexer.cpython-312.pyc
│   │           │       │   │   ├── __main__.cpython-312.pyc
│   │           │       │   │   ├── modeline.cpython-312.pyc
│   │           │       │   │   ├── plugin.cpython-312.pyc
│   │           │       │   │   ├── regexopt.cpython-312.pyc
│   │           │       │   │   ├── scanner.cpython-312.pyc
│   │           │       │   │   ├── sphinxext.cpython-312.pyc
│   │           │       │   │   ├── style.cpython-312.pyc
│   │           │       │   │   ├── token.cpython-312.pyc
│   │           │       │   │   ├── unistring.cpython-312.pyc
│   │           │       │   │   └── util.cpython-312.pyc
│   │           │       │   ├── regexopt.py
│   │           │       │   ├── scanner.py
│   │           │       │   ├── sphinxext.py
│   │           │       │   ├── style.py
│   │           │       │   ├── styles
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       └── __init__.cpython-312.pyc
│   │           │       │   ├── token.py
│   │           │       │   ├── unistring.py
│   │           │       │   └── util.py
│   │           │       ├── pyparsing
│   │           │       │   ├── actions.py
│   │           │       │   ├── common.py
│   │           │       │   ├── core.py
│   │           │       │   ├── diagram
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       └── __init__.cpython-312.pyc
│   │           │       │   ├── exceptions.py
│   │           │       │   ├── helpers.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── actions.cpython-312.pyc
│   │           │       │   │   ├── common.cpython-312.pyc
│   │           │       │   │   ├── core.cpython-312.pyc
│   │           │       │   │   ├── exceptions.cpython-312.pyc
│   │           │       │   │   ├── helpers.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── results.cpython-312.pyc
│   │           │       │   │   ├── testing.cpython-312.pyc
│   │           │       │   │   ├── unicode.cpython-312.pyc
│   │           │       │   │   └── util.cpython-312.pyc
│   │           │       │   ├── results.py
│   │           │       │   ├── testing.py
│   │           │       │   ├── unicode.py
│   │           │       │   └── util.py
│   │           │       ├── pyproject_hooks
│   │           │       │   ├── _compat.py
│   │           │       │   ├── _impl.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _in_process
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── _in_process.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       ├── __init__.cpython-312.pyc
│   │           │       │   │       └── _in_process.cpython-312.pyc
│   │           │       │   └── __pycache__
│   │           │       │       ├── _compat.cpython-312.pyc
│   │           │       │       ├── _impl.cpython-312.pyc
│   │           │       │       └── __init__.cpython-312.pyc
│   │           │       ├── requests
│   │           │       │   ├── adapters.py
│   │           │       │   ├── api.py
│   │           │       │   ├── auth.py
│   │           │       │   ├── certs.py
│   │           │       │   ├── compat.py
│   │           │       │   ├── cookies.py
│   │           │       │   ├── exceptions.py
│   │           │       │   ├── help.py
│   │           │       │   ├── hooks.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _internal_utils.py
│   │           │       │   ├── models.py
│   │           │       │   ├── packages.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── adapters.cpython-312.pyc
│   │           │       │   │   ├── api.cpython-312.pyc
│   │           │       │   │   ├── auth.cpython-312.pyc
│   │           │       │   │   ├── certs.cpython-312.pyc
│   │           │       │   │   ├── compat.cpython-312.pyc
│   │           │       │   │   ├── cookies.cpython-312.pyc
│   │           │       │   │   ├── exceptions.cpython-312.pyc
│   │           │       │   │   ├── help.cpython-312.pyc
│   │           │       │   │   ├── hooks.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── _internal_utils.cpython-312.pyc
│   │           │       │   │   ├── models.cpython-312.pyc
│   │           │       │   │   ├── packages.cpython-312.pyc
│   │           │       │   │   ├── sessions.cpython-312.pyc
│   │           │       │   │   ├── status_codes.cpython-312.pyc
│   │           │       │   │   ├── structures.cpython-312.pyc
│   │           │       │   │   ├── utils.cpython-312.pyc
│   │           │       │   │   └── __version__.cpython-312.pyc
│   │           │       │   ├── sessions.py
│   │           │       │   ├── status_codes.py
│   │           │       │   ├── structures.py
│   │           │       │   ├── utils.py
│   │           │       │   └── __version__.py
│   │           │       ├── resolvelib
│   │           │       │   ├── compat
│   │           │       │   │   ├── collections_abc.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   └── __pycache__
│   │           │       │   │       ├── collections_abc.cpython-312.pyc
│   │           │       │   │       └── __init__.cpython-312.pyc
│   │           │       │   ├── __init__.py
│   │           │       │   ├── providers.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── providers.cpython-312.pyc
│   │           │       │   │   ├── reporters.cpython-312.pyc
│   │           │       │   │   ├── resolvers.cpython-312.pyc
│   │           │       │   │   └── structs.cpython-312.pyc
│   │           │       │   ├── reporters.py
│   │           │       │   ├── resolvers.py
│   │           │       │   └── structs.py
│   │           │       ├── rich
│   │           │       │   ├── abc.py
│   │           │       │   ├── align.py
│   │           │       │   ├── ansi.py
│   │           │       │   ├── bar.py
│   │           │       │   ├── box.py
│   │           │       │   ├── cells.py
│   │           │       │   ├── _cell_widths.py
│   │           │       │   ├── color.py
│   │           │       │   ├── color_triplet.py
│   │           │       │   ├── columns.py
│   │           │       │   ├── console.py
│   │           │       │   ├── constrain.py
│   │           │       │   ├── containers.py
│   │           │       │   ├── control.py
│   │           │       │   ├── default_styles.py
│   │           │       │   ├── diagnose.py
│   │           │       │   ├── _emoji_codes.py
│   │           │       │   ├── emoji.py
│   │           │       │   ├── _emoji_replace.py
│   │           │       │   ├── errors.py
│   │           │       │   ├── _export_format.py
│   │           │       │   ├── _extension.py
│   │           │       │   ├── _fileno.py
│   │           │       │   ├── file_proxy.py
│   │           │       │   ├── filesize.py
│   │           │       │   ├── highlighter.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _inspect.py
│   │           │       │   ├── json.py
│   │           │       │   ├── jupyter.py
│   │           │       │   ├── layout.py
│   │           │       │   ├── live.py
│   │           │       │   ├── live_render.py
│   │           │       │   ├── logging.py
│   │           │       │   ├── _log_render.py
│   │           │       │   ├── _loop.py
│   │           │       │   ├── __main__.py
│   │           │       │   ├── markup.py
│   │           │       │   ├── measure.py
│   │           │       │   ├── _null_file.py
│   │           │       │   ├── padding.py
│   │           │       │   ├── pager.py
│   │           │       │   ├── palette.py
│   │           │       │   ├── _palettes.py
│   │           │       │   ├── panel.py
│   │           │       │   ├── _pick.py
│   │           │       │   ├── pretty.py
│   │           │       │   ├── progress_bar.py
│   │           │       │   ├── progress.py
│   │           │       │   ├── prompt.py
│   │           │       │   ├── protocol.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── abc.cpython-312.pyc
│   │           │       │   │   ├── align.cpython-312.pyc
│   │           │       │   │   ├── ansi.cpython-312.pyc
│   │           │       │   │   ├── bar.cpython-312.pyc
│   │           │       │   │   ├── box.cpython-312.pyc
│   │           │       │   │   ├── cells.cpython-312.pyc
│   │           │       │   │   ├── _cell_widths.cpython-312.pyc
│   │           │       │   │   ├── color.cpython-312.pyc
│   │           │       │   │   ├── color_triplet.cpython-312.pyc
│   │           │       │   │   ├── columns.cpython-312.pyc
│   │           │       │   │   ├── console.cpython-312.pyc
│   │           │       │   │   ├── constrain.cpython-312.pyc
│   │           │       │   │   ├── containers.cpython-312.pyc
│   │           │       │   │   ├── control.cpython-312.pyc
│   │           │       │   │   ├── default_styles.cpython-312.pyc
│   │           │       │   │   ├── diagnose.cpython-312.pyc
│   │           │       │   │   ├── _emoji_codes.cpython-312.pyc
│   │           │       │   │   ├── emoji.cpython-312.pyc
│   │           │       │   │   ├── _emoji_replace.cpython-312.pyc
│   │           │       │   │   ├── errors.cpython-312.pyc
│   │           │       │   │   ├── _export_format.cpython-312.pyc
│   │           │       │   │   ├── _extension.cpython-312.pyc
│   │           │       │   │   ├── _fileno.cpython-312.pyc
│   │           │       │   │   ├── file_proxy.cpython-312.pyc
│   │           │       │   │   ├── filesize.cpython-312.pyc
│   │           │       │   │   ├── highlighter.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── _inspect.cpython-312.pyc
│   │           │       │   │   ├── json.cpython-312.pyc
│   │           │       │   │   ├── jupyter.cpython-312.pyc
│   │           │       │   │   ├── layout.cpython-312.pyc
│   │           │       │   │   ├── live.cpython-312.pyc
│   │           │       │   │   ├── live_render.cpython-312.pyc
│   │           │       │   │   ├── logging.cpython-312.pyc
│   │           │       │   │   ├── _log_render.cpython-312.pyc
│   │           │       │   │   ├── _loop.cpython-312.pyc
│   │           │       │   │   ├── __main__.cpython-312.pyc
│   │           │       │   │   ├── markup.cpython-312.pyc
│   │           │       │   │   ├── measure.cpython-312.pyc
│   │           │       │   │   ├── _null_file.cpython-312.pyc
│   │           │       │   │   ├── padding.cpython-312.pyc
│   │           │       │   │   ├── pager.cpython-312.pyc
│   │           │       │   │   ├── palette.cpython-312.pyc
│   │           │       │   │   ├── _palettes.cpython-312.pyc
│   │           │       │   │   ├── panel.cpython-312.pyc
│   │           │       │   │   ├── _pick.cpython-312.pyc
│   │           │       │   │   ├── pretty.cpython-312.pyc
│   │           │       │   │   ├── progress_bar.cpython-312.pyc
│   │           │       │   │   ├── progress.cpython-312.pyc
│   │           │       │   │   ├── prompt.cpython-312.pyc
│   │           │       │   │   ├── protocol.cpython-312.pyc
│   │           │       │   │   ├── _ratio.cpython-312.pyc
│   │           │       │   │   ├── region.cpython-312.pyc
│   │           │       │   │   ├── repr.cpython-312.pyc
│   │           │       │   │   ├── rule.cpython-312.pyc
│   │           │       │   │   ├── scope.cpython-312.pyc
│   │           │       │   │   ├── screen.cpython-312.pyc
│   │           │       │   │   ├── segment.cpython-312.pyc
│   │           │       │   │   ├── spinner.cpython-312.pyc
│   │           │       │   │   ├── _spinners.cpython-312.pyc
│   │           │       │   │   ├── _stack.cpython-312.pyc
│   │           │       │   │   ├── status.cpython-312.pyc
│   │           │       │   │   ├── style.cpython-312.pyc
│   │           │       │   │   ├── styled.cpython-312.pyc
│   │           │       │   │   ├── syntax.cpython-312.pyc
│   │           │       │   │   ├── table.cpython-312.pyc
│   │           │       │   │   ├── terminal_theme.cpython-312.pyc
│   │           │       │   │   ├── text.cpython-312.pyc
│   │           │       │   │   ├── theme.cpython-312.pyc
│   │           │       │   │   ├── themes.cpython-312.pyc
│   │           │       │   │   ├── _timer.cpython-312.pyc
│   │           │       │   │   ├── traceback.cpython-312.pyc
│   │           │       │   │   ├── tree.cpython-312.pyc
│   │           │       │   │   ├── _win32_console.cpython-312.pyc
│   │           │       │   │   ├── _windows.cpython-312.pyc
│   │           │       │   │   ├── _windows_renderer.cpython-312.pyc
│   │           │       │   │   └── _wrap.cpython-312.pyc
│   │           │       │   ├── _ratio.py
│   │           │       │   ├── region.py
│   │           │       │   ├── repr.py
│   │           │       │   ├── rule.py
│   │           │       │   ├── scope.py
│   │           │       │   ├── screen.py
│   │           │       │   ├── segment.py
│   │           │       │   ├── spinner.py
│   │           │       │   ├── _spinners.py
│   │           │       │   ├── _stack.py
│   │           │       │   ├── status.py
│   │           │       │   ├── styled.py
│   │           │       │   ├── style.py
│   │           │       │   ├── syntax.py
│   │           │       │   ├── table.py
│   │           │       │   ├── terminal_theme.py
│   │           │       │   ├── text.py
│   │           │       │   ├── theme.py
│   │           │       │   ├── themes.py
│   │           │       │   ├── _timer.py
│   │           │       │   ├── traceback.py
│   │           │       │   ├── tree.py
│   │           │       │   ├── _win32_console.py
│   │           │       │   ├── _windows.py
│   │           │       │   ├── _windows_renderer.py
│   │           │       │   └── _wrap.py
│   │           │       ├── six.py
│   │           │       ├── tenacity
│   │           │       │   ├── after.py
│   │           │       │   ├── _asyncio.py
│   │           │       │   ├── before.py
│   │           │       │   ├── before_sleep.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── nap.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── after.cpython-312.pyc
│   │           │       │   │   ├── _asyncio.cpython-312.pyc
│   │           │       │   │   ├── before.cpython-312.pyc
│   │           │       │   │   ├── before_sleep.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── nap.cpython-312.pyc
│   │           │       │   │   ├── retry.cpython-312.pyc
│   │           │       │   │   ├── stop.cpython-312.pyc
│   │           │       │   │   ├── tornadoweb.cpython-312.pyc
│   │           │       │   │   ├── _utils.cpython-312.pyc
│   │           │       │   │   └── wait.cpython-312.pyc
│   │           │       │   ├── retry.py
│   │           │       │   ├── stop.py
│   │           │       │   ├── tornadoweb.py
│   │           │       │   ├── _utils.py
│   │           │       │   └── wait.py
│   │           │       ├── tomli
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _parser.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── _parser.cpython-312.pyc
│   │           │       │   │   ├── _re.cpython-312.pyc
│   │           │       │   │   └── _types.cpython-312.pyc
│   │           │       │   ├── _re.py
│   │           │       │   └── _types.py
│   │           │       ├── truststore
│   │           │       │   ├── _api.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── _macos.py
│   │           │       │   ├── _openssl.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── _api.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── _macos.cpython-312.pyc
│   │           │       │   │   ├── _openssl.cpython-312.pyc
│   │           │       │   │   ├── _ssl_constants.cpython-312.pyc
│   │           │       │   │   └── _windows.cpython-312.pyc
│   │           │       │   ├── _ssl_constants.py
│   │           │       │   └── _windows.py
│   │           │       ├── typing_extensions.py
│   │           │       ├── urllib3
│   │           │       │   ├── _collections.py
│   │           │       │   ├── connectionpool.py
│   │           │       │   ├── connection.py
│   │           │       │   ├── contrib
│   │           │       │   │   ├── _appengine_environ.py
│   │           │       │   │   ├── appengine.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── ntlmpool.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── appengine.cpython-312.pyc
│   │           │       │   │   │   ├── _appengine_environ.cpython-312.pyc
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   ├── ntlmpool.cpython-312.pyc
│   │           │       │   │   │   ├── pyopenssl.cpython-312.pyc
│   │           │       │   │   │   ├── securetransport.cpython-312.pyc
│   │           │       │   │   │   └── socks.cpython-312.pyc
│   │           │       │   │   ├── pyopenssl.py
│   │           │       │   │   ├── _securetransport
│   │           │       │   │   │   ├── bindings.py
│   │           │       │   │   │   ├── __init__.py
│   │           │       │   │   │   ├── low_level.py
│   │           │       │   │   │   └── __pycache__
│   │           │       │   │   │       ├── bindings.cpython-312.pyc
│   │           │       │   │   │       ├── __init__.cpython-312.pyc
│   │           │       │   │   │       └── low_level.cpython-312.pyc
│   │           │       │   │   ├── securetransport.py
│   │           │       │   │   └── socks.py
│   │           │       │   ├── exceptions.py
│   │           │       │   ├── fields.py
│   │           │       │   ├── filepost.py
│   │           │       │   ├── __init__.py
│   │           │       │   ├── packages
│   │           │       │   │   ├── backports
│   │           │       │   │   │   ├── __init__.py
│   │           │       │   │   │   ├── makefile.py
│   │           │       │   │   │   ├── __pycache__
│   │           │       │   │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   │   ├── makefile.cpython-312.pyc
│   │           │       │   │   │   │   └── weakref_finalize.cpython-312.pyc
│   │           │       │   │   │   └── weakref_finalize.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   └── six.cpython-312.pyc
│   │           │       │   │   └── six.py
│   │           │       │   ├── poolmanager.py
│   │           │       │   ├── __pycache__
│   │           │       │   │   ├── _collections.cpython-312.pyc
│   │           │       │   │   ├── connection.cpython-312.pyc
│   │           │       │   │   ├── connectionpool.cpython-312.pyc
│   │           │       │   │   ├── exceptions.cpython-312.pyc
│   │           │       │   │   ├── fields.cpython-312.pyc
│   │           │       │   │   ├── filepost.cpython-312.pyc
│   │           │       │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   ├── poolmanager.cpython-312.pyc
│   │           │       │   │   ├── request.cpython-312.pyc
│   │           │       │   │   ├── response.cpython-312.pyc
│   │           │       │   │   └── _version.cpython-312.pyc
│   │           │       │   ├── request.py
│   │           │       │   ├── response.py
│   │           │       │   ├── util
│   │           │       │   │   ├── connection.py
│   │           │       │   │   ├── __init__.py
│   │           │       │   │   ├── proxy.py
│   │           │       │   │   ├── __pycache__
│   │           │       │   │   │   ├── connection.cpython-312.pyc
│   │           │       │   │   │   ├── __init__.cpython-312.pyc
│   │           │       │   │   │   ├── proxy.cpython-312.pyc
│   │           │       │   │   │   ├── queue.cpython-312.pyc
│   │           │       │   │   │   ├── request.cpython-312.pyc
│   │           │       │   │   │   ├── response.cpython-312.pyc
│   │           │       │   │   │   ├── retry.cpython-312.pyc
│   │           │       │   │   │   ├── ssl_.cpython-312.pyc
│   │           │       │   │   │   ├── ssl_match_hostname.cpython-312.pyc
│   │           │       │   │   │   ├── ssltransport.cpython-312.pyc
│   │           │       │   │   │   ├── timeout.cpython-312.pyc
│   │           │       │   │   │   ├── url.cpython-312.pyc
│   │           │       │   │   │   └── wait.cpython-312.pyc
│   │           │       │   │   ├── queue.py
│   │           │       │   │   ├── request.py
│   │           │       │   │   ├── response.py
│   │           │       │   │   ├── retry.py
│   │           │       │   │   ├── ssl_match_hostname.py
│   │           │       │   │   ├── ssl_.py
│   │           │       │   │   ├── ssltransport.py
│   │           │       │   │   ├── timeout.py
│   │           │       │   │   ├── url.py
│   │           │       │   │   └── wait.py
│   │           │       │   └── _version.py
│   │           │       ├── vendor.txt
│   │           │       └── webencodings
│   │           │           ├── __init__.py
│   │           │           ├── labels.py
│   │           │           ├── mklabels.py
│   │           │           ├── __pycache__
│   │           │           │   ├── __init__.cpython-312.pyc
│   │           │           │   ├── labels.cpython-312.pyc
│   │           │           │   ├── mklabels.cpython-312.pyc
│   │           │           │   ├── tests.cpython-312.pyc
│   │           │           │   └── x_user_defined.cpython-312.pyc
│   │           │           ├── tests.py
│   │           │           └── x_user_defined.py
│   │           └── pip-24.0.dist-info
│   │               ├── AUTHORS.txt
│   │               ├── entry_points.txt
│   │               ├── INSTALLER
│   │               ├── LICENSE.txt
│   │               ├── METADATA
│   │               ├── RECORD
│   │               ├── REQUESTED
│   │               ├── top_level.txt
│   │               └── WHEEL
│   ├── lib64 -> lib
│   └── pyvenv.cfg
├── DIC
│   ├── en_US.aff
│   ├── en_US.dic
│   ├── ru_RU.aff
│   └── ru_RU.dic
├── experiments
│   ├── docs
│   │   └── AUDIT.md
│   └── gnome_input_source.py
├── .git
│   ├── branches
│   ├── COMMIT_EDITMSG
│   ├── config
│   ├── description
│   ├── FETCH_HEAD
│   ├── HEAD
│   ├── hooks
│   │   ├── applypatch-msg.sample
│   │   ├── commit-msg.sample
│   │   ├── fsmonitor-watchman.sample
│   │   ├── post-update.sample
│   │   ├── pre-applypatch.sample
│   │   ├── pre-commit.sample
│   │   ├── pre-merge-commit.sample
│   │   ├── prepare-commit-msg.sample
│   │   ├── pre-push.sample
│   │   ├── pre-rebase.sample
│   │   ├── pre-receive.sample
│   │   ├── push-to-checkout.sample
│   │   ├── sendemail-validate.sample
│   │   └── update.sample
│   ├── index
│   ├── info
│   │   └── exclude
│   ├── logs
│   │   ├── HEAD
│   │   └── refs
│   │       ├── heads
│   │       │   └── main
│   │       └── remotes
│   │           └── origin
│   │               └── main
│   ├── objects
│   │   ├── 02
│   │   │   ├── dbad59da18ceb075660498ec4f74d78cee57ee
│   │   │   └── ff054f79ae40a06bd98a6de14351e51a227d60
│   │   ├── 04
│   │   │   └── c5e0b3c829a0c2e0d100f80eb3fb40abdb4c68
│   │   ├── 0d
│   │   │   └── dcb3f6031a754d00aee438652f1e447bdad053
│   │   ├── 10
│   │   │   └── e8a8fbcd0f248a2dbcef82d60e476d877d7ceb
│   │   ├── 11
│   │   │   └── 06efee18f8f7fdeca3c9046a0284c581b374be
│   │   ├── 15
│   │   │   └── 65cc9e4e31aace362cc6e4881521246ab8de5c
│   │   ├── 17
│   │   │   └── 49feb615445a909d285e434469c454bb2c4603
│   │   ├── 19
│   │   │   ├── b43b6548f951d405684744a99654af62342ce2
│   │   │   └── dd86fcb4ac49fe2fff08af24bf881d8354a98c
│   │   ├── 1b
│   │   │   └── a5a153c54efb97585028de14c7a31ef3e12c23
│   │   ├── 20
│   │   │   └── 877422cb38719d4f94b6f3ceeb094242ec4d4a
│   │   ├── 24
│   │   │   └── 4cb59ea9d4d3271db22f78712cb950d9ffb3fe
│   │   ├── 25
│   │   │   └── be6a56a4221cdfdee925d636d69e474aaf6bd0
│   │   ├── 27
│   │   │   └── 78ee0e385797accb519860606992bfbb4d3aeb
│   │   ├── 28
│   │   │   ├── 7c2f92c402434be6e4c854bd84c87055251cec
│   │   │   └── a1d3a4c366680c5a0acfcf66bfbe75e33a4f34
│   │   ├── 2b
│   │   │   └── 4dece7ee1f668893350a93aefb3414790bbafc
│   │   ├── 2d
│   │   │   ├── 33f6ac8992b7da84b39a5bca0742c4962d3349
│   │   │   └── 784c9f27597e0efc1833c9063a0e50017866d1
│   │   ├── 2e
│   │   │   └── dd8a17eab15c8a34d646b5b619b234c2666e20
│   │   ├── 30
│   │   │   └── fb108f71d72be97528831bc902d0b52685018b
│   │   ├── 3a
│   │   │   ├── 4b6068ad54e8ffdf9020936dc5344e7803c7ab
│   │   │   └── e84686961c4a9f51fa9faab0b9f2cba63a1d17
│   │   ├── 3b
│   │   │   └── 461f50c91417aecbeae4cca2da262d5d2e29db
│   │   ├── 3c
│   │   │   └── 31674988fe40938b444e6c08e7b2812a66431d
│   │   ├── 3d
│   │   │   └── 192a0d0cf94d37a4a2ae204844c59317b4ce87
│   │   ├── 3e
│   │   │   └── 639be7afda58d881467804559f2ef1987e5538
│   │   ├── 43
│   │   │   └── 124462f72432f56295c764f795fe9d197242c1
│   │   ├── 44
│   │   │   └── 5c935851ec5f72cca81bc45233b57449208bba
│   │   ├── 47
│   │   │   └── 070a3ae04d75e40685956653008f65b86108d2
│   │   ├── 48
│   │   │   └── fe36e1be539711739526ada90f9c2405b3b9aa
│   │   ├── 4a
│   │   │   └── b2cf01480a2979a26613832aae337cb0fe4011
│   │   ├── 4b
│   │   │   └── b8116735324ba25ddc92d9c8244de145d272bf
│   │   ├── 4f
│   │   │   └── 01a36659695cfe68f268f31e0b9cf4b1c81974
│   │   ├── 50
│   │   │   └── 3561615c1d28ad69ad397007f48289c48791cf
│   │   ├── 56
│   │   │   └── 9ee0c3081c96f34cb02bef5f9ad62dcc21d289
│   │   ├── 58
│   │   │   └── 5b78fcceb32dd3272a94adf2c8700bd705065b
│   │   ├── 59
│   │   │   ├── 437590b1c5c4e2dc45f73875902d618055acb8
│   │   │   └── e94f5eb67e776978616056119da54ec3fc155b
│   │   ├── 5a
│   │   │   ├── 0781f02537663f965d9d58be1811b42e264158
│   │   │   └── 8d9b52805b011d145779f62eb76dda0f206ae8
│   │   ├── 5b
│   │   │   └── 8ba43bc196f907db5b73232fc748c524bd2c3b
│   │   ├── 5e
│   │   │   ├── 40f2d6b8a32eb1617c07ce1b79ee9090bae6fa
│   │   │   └── 7c067a023d36c607951e132b6e3e1cdebecf60
│   │   ├── 67
│   │   │   └── b76b372674b67a6804ed84e65f9f09f9f503d1
│   │   ├── 68
│   │   │   └── 7d10ee95f3bee5d09d135bd87b1c6480e9facc
│   │   ├── 6a
│   │   │   ├── 5019b4e09a12779e62f2443bef90f638ab49cf
│   │   │   └── d3db594c8d747249eb6bfb8ee828b27580c103
│   │   ├── 74
│   │   │   └── 8ca112894f518485a7ff45172ca96156fa2156
│   │   ├── 76
│   │   │   └── 84c10e921555e2b42f0f390148f31e49a2e212
│   │   ├── 79
│   │   │   └── bf3607d4244c4ab69519fae728d77c562ca9a4
│   │   ├── 7c
│   │   │   └── d76aff8bd3d33dea0e99a522cc5603381490e4
│   │   ├── 82
│   │   │   └── 10c8e453ebab371eaedb25bb51400a384330a7
│   │   ├── 85
│   │   │   └── 36c412d6a0eaf4bafbdadc9537d4e6fca12587
│   │   ├── 8a
│   │   │   └── ad78a368867592d21d9a9033c84c4ef946b4ab
│   │   ├── 8b
│   │   │   └── 3fc88bc698a0bd163b12eec883f04ce0ef70e5
│   │   ├── 8d
│   │   │   └── 49ccf171377b721495bb16618898942efbd54c
│   │   ├── 8f
│   │   │   └── 1585f15e1944103c7ac09bc357b30ef4e14a74
│   │   ├── 92
│   │   │   └── 281c47095d01c192eecfb2e256bfd70718e0b7
│   │   ├── 93
│   │   │   └── 8641885fd9e48a8df3f36a8505abab65cf71c2
│   │   ├── 96
│   │   │   └── 94c9443008d81a0f6da7f469b60152713d41fd
│   │   ├── 97
│   │   │   ├── 8fc8b5a0eb2066fda8c4bba9792753005041b7
│   │   │   └── ab5c2729b28642d94d1c2a3db9bdce8086201e
│   │   ├── 9c
│   │   │   ├── 5a8b33b3430324f9b882d2109d5aacd935a1a6
│   │   │   └── 7316f16253ff3526b835cb5cee817bf9892dab
│   │   ├── a0
│   │   │   └── be879592b20e767f2dadd40552620425932a88
│   │   ├── a1
│   │   │   └── 419c646aac6f31ab036905751acf5830216be6
│   │   ├── a3
│   │   │   └── cc3da20b681858fddf343369d44ff4381e8162
│   │   ├── a5
│   │   │   └── 2f36744f27eae6c52b2580917c3bed94889f2c
│   │   ├── a6
│   │   │   └── 260ffda21ef916ec7bfff0779e1340317bc170
│   │   ├── aa
│   │   │   ├── 00b03cde43fced0f514950b648a5640ba8cce4
│   │   │   ├── 9ad473faeccd6228a67d56958f476cb690521b
│   │   │   └── a0a7fe9cdcb3ac8f28ac1d4cbe8234d15ee68d
│   │   ├── b3
│   │   │   └── dc90b0550d7746b5771c0472526f588fde00f7
│   │   ├── b5
│   │   │   ├── 1b5d09bdf684679d850febd9d235d56a5aa4d0
│   │   │   └── 4cb52ff1a59f452b4e22a28829817154d8b8df
│   │   ├── b7
│   │   │   ├── 158acf78cc34e78181897a012942b47af22697
│   │   │   └── 1f1173601908d1cd592df5b27b72775dab8ff0
│   │   ├── ba
│   │   │   └── 9868dc352bf164bbfaac3ef0e7df3ca6173796
│   │   ├── bd
│   │   │   └── 08cbc5cadd07758142257e0760146542485adc
│   │   ├── bf
│   │   │   └── 9bf98e1c4147526e210aa70e424e72393a331b
│   │   ├── c0
│   │   │   └── fa4fcad06e6baa803f4888ae2b67f3cde1c98f
│   │   ├── c4
│   │   │   └── d850931c312446c2e304ca162bb03ba03c9011
│   │   ├── c5
│   │   │   ├── 4f1e6df6df25c016d3bada6edda1f315cc6044
│   │   │   └── 8b3309d3da3254e42b4f45aca84e23949da5d6
│   │   ├── ca
│   │   │   └── 9369535cc169322e7a1ce1d5ebe9db7f3b39eb
│   │   ├── cd
│   │   │   └── e08d6709e371b5e3f54231bedafcfcbc8d2192
│   │   ├── ce
│   │   │   └── 08dead1477f94509adf77c01a3d7acfe9a7b88
│   │   ├── d2
│   │   │   └── 5a8cb922283b94ae36406078a550c55d6340d4
│   │   ├── d4
│   │   │   └── b7a148a16c47f984d059281f33224937dc19a9
│   │   ├── d5
│   │   │   └── e2c256481b856af60153b0a95d99c6a218c51e
│   │   ├── d7
│   │   │   ├── bc0ff096ad42e5fd5eb7e2d049feff6b5827d3
│   │   │   └── cb2bb73bbd462f75d56a82de99febee1074775
│   │   ├── d9
│   │   │   └── 5e071ebbd20df50102a38af65f9e0a15968a1c
│   │   ├── da
│   │   │   └── 60a6d988d557f605a04fc24aee8d278cbaf8b2
│   │   ├── e2
│   │   │   └── 1213b1abdba049bf2d597a9c5a86b9229c0df1
│   │   ├── e5
│   │   │   ├── 3b14f300084bbd3ef4f0f8f88f3c161822acb7
│   │   │   └── a40df73ec54691b2e85d66d230e504ff222baa
│   │   ├── e6
│   │   │   └── 9de29bb2d1d6434b8b29ae775ad8c2e48c5391
│   │   ├── e8
│   │   │   └── 9b12ec582b4bbdf7b42760271808c11ef04361
│   │   ├── eb
│   │   │   ├── 18a0e1cfe1e22bc1953e8aa95f1164e8493d00
│   │   │   └── 9ff626b8866dfd8f89c10e9d36fc89a79082f1
│   │   ├── f0
│   │   │   ├── 202285aad579f9fa16d1b12e8e1e002f08763d
│   │   │   └── 2df51164cf8716dcebf45d16c8c05df6457b83
│   │   ├── f1
│   │   │   └── 593f0577d6fc09e54442b38c49fcfe8441c153
│   │   ├── f3
│   │   │   └── 64ac358f07692a43abd3cdd08da93b82f827cc
│   │   ├── f4
│   │   │   ├── 887673c2737daef4b27d3aa1fa9bb4f12eb120
│   │   │   └── bb48cf28b00edf07d38bebd6b716b5aae85b7f
│   │   ├── f6
│   │   │   ├── 0803d9713e0b8ecb961ed9f5f7e40fe91a4878
│   │   │   └── b3f9ffe0480e1b03b75ddce134b79538f76575
│   │   ├── ff
│   │   │   └── a6ec09417c5d7ac02844b83856b1845cf245be
│   │   ├── info
│   │   └── pack
│   ├── ORIG_HEAD
│   └── refs
│       ├── heads
│       │   └── main
│       ├── remotes
│       │   └── origin
│       │       └── main
│       └── tags
│           └── v0.1.0
├── .github
│   └── workflows
│       ├── deb.yml
│       └── release.yml
├── .gitignore
├── install.sh
├── kbfix
│   ├── __init__.py
│   ├── layout_switcher.py
│   ├── __main__.py
│   └── tray_app.py
├── LICENSE
├── .project
├── .pydevproject
├── pyproject.toml
├── pyrightconfig.json
├── README_en.md
├── README.md
├── scripts
│   ├── kbfix
│   └── publish.sh
├── .settings
│   └── org.eclipse.core.resources.prefs
├── structure.md
├── uninstall.sh
└── .venv
    ├── bin
    │   ├── activate
    │   ├── activate.csh
    │   ├── activate.fish
    │   ├── Activate.ps1
    │   ├── pip
    │   ├── pip3
    │   ├── pip3.12
    │   ├── python -> python3
    │   ├── python3 -> /usr/bin/python3
    │   └── python3.12 -> python3
    ├── include
    │   └── python3.12
    ├── lib
    │   └── python3.12
    │       └── site-packages
    │           ├── pip
    │           │   ├── __init__.py
    │           │   ├── _internal
    │           │   │   ├── build_env.py
    │           │   │   ├── cache.py
    │           │   │   ├── cli
    │           │   │   │   ├── autocompletion.py
    │           │   │   │   ├── base_command.py
    │           │   │   │   ├── cmdoptions.py
    │           │   │   │   ├── command_context.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── main_parser.py
    │           │   │   │   ├── main.py
    │           │   │   │   ├── parser.py
    │           │   │   │   ├── progress_bars.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── autocompletion.cpython-312.pyc
    │           │   │   │   │   ├── base_command.cpython-312.pyc
    │           │   │   │   │   ├── cmdoptions.cpython-312.pyc
    │           │   │   │   │   ├── command_context.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── main.cpython-312.pyc
    │           │   │   │   │   ├── main_parser.cpython-312.pyc
    │           │   │   │   │   ├── parser.cpython-312.pyc
    │           │   │   │   │   ├── progress_bars.cpython-312.pyc
    │           │   │   │   │   ├── req_command.cpython-312.pyc
    │           │   │   │   │   ├── spinners.cpython-312.pyc
    │           │   │   │   │   └── status_codes.cpython-312.pyc
    │           │   │   │   ├── req_command.py
    │           │   │   │   ├── spinners.py
    │           │   │   │   └── status_codes.py
    │           │   │   ├── commands
    │           │   │   │   ├── cache.py
    │           │   │   │   ├── check.py
    │           │   │   │   ├── completion.py
    │           │   │   │   ├── configuration.py
    │           │   │   │   ├── debug.py
    │           │   │   │   ├── download.py
    │           │   │   │   ├── freeze.py
    │           │   │   │   ├── hash.py
    │           │   │   │   ├── help.py
    │           │   │   │   ├── index.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── inspect.py
    │           │   │   │   ├── install.py
    │           │   │   │   ├── list.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── cache.cpython-312.pyc
    │           │   │   │   │   ├── check.cpython-312.pyc
    │           │   │   │   │   ├── completion.cpython-312.pyc
    │           │   │   │   │   ├── configuration.cpython-312.pyc
    │           │   │   │   │   ├── debug.cpython-312.pyc
    │           │   │   │   │   ├── download.cpython-312.pyc
    │           │   │   │   │   ├── freeze.cpython-312.pyc
    │           │   │   │   │   ├── hash.cpython-312.pyc
    │           │   │   │   │   ├── help.cpython-312.pyc
    │           │   │   │   │   ├── index.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── inspect.cpython-312.pyc
    │           │   │   │   │   ├── install.cpython-312.pyc
    │           │   │   │   │   ├── list.cpython-312.pyc
    │           │   │   │   │   ├── search.cpython-312.pyc
    │           │   │   │   │   ├── show.cpython-312.pyc
    │           │   │   │   │   ├── uninstall.cpython-312.pyc
    │           │   │   │   │   └── wheel.cpython-312.pyc
    │           │   │   │   ├── search.py
    │           │   │   │   ├── show.py
    │           │   │   │   ├── uninstall.py
    │           │   │   │   └── wheel.py
    │           │   │   ├── configuration.py
    │           │   │   ├── distributions
    │           │   │   │   ├── base.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── installed.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── base.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── installed.cpython-312.pyc
    │           │   │   │   │   ├── sdist.cpython-312.pyc
    │           │   │   │   │   └── wheel.cpython-312.pyc
    │           │   │   │   ├── sdist.py
    │           │   │   │   └── wheel.py
    │           │   │   ├── exceptions.py
    │           │   │   ├── index
    │           │   │   │   ├── collector.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── package_finder.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── collector.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── package_finder.cpython-312.pyc
    │           │   │   │   │   └── sources.cpython-312.pyc
    │           │   │   │   └── sources.py
    │           │   │   ├── __init__.py
    │           │   │   ├── locations
    │           │   │   │   ├── base.py
    │           │   │   │   ├── _distutils.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── base.cpython-312.pyc
    │           │   │   │   │   ├── _distutils.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   └── _sysconfig.cpython-312.pyc
    │           │   │   │   └── _sysconfig.py
    │           │   │   ├── main.py
    │           │   │   ├── metadata
    │           │   │   │   ├── base.py
    │           │   │   │   ├── importlib
    │           │   │   │   │   ├── _compat.py
    │           │   │   │   │   ├── _dists.py
    │           │   │   │   │   ├── _envs.py
    │           │   │   │   │   ├── __init__.py
    │           │   │   │   │   └── __pycache__
    │           │   │   │   │       ├── _compat.cpython-312.pyc
    │           │   │   │   │       ├── _dists.cpython-312.pyc
    │           │   │   │   │       ├── _envs.cpython-312.pyc
    │           │   │   │   │       └── __init__.cpython-312.pyc
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── _json.py
    │           │   │   │   ├── pkg_resources.py
    │           │   │   │   └── __pycache__
    │           │   │   │       ├── base.cpython-312.pyc
    │           │   │   │       ├── __init__.cpython-312.pyc
    │           │   │   │       ├── _json.cpython-312.pyc
    │           │   │   │       └── pkg_resources.cpython-312.pyc
    │           │   │   ├── models
    │           │   │   │   ├── candidate.py
    │           │   │   │   ├── direct_url.py
    │           │   │   │   ├── format_control.py
    │           │   │   │   ├── index.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── installation_report.py
    │           │   │   │   ├── link.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── candidate.cpython-312.pyc
    │           │   │   │   │   ├── direct_url.cpython-312.pyc
    │           │   │   │   │   ├── format_control.cpython-312.pyc
    │           │   │   │   │   ├── index.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── installation_report.cpython-312.pyc
    │           │   │   │   │   ├── link.cpython-312.pyc
    │           │   │   │   │   ├── scheme.cpython-312.pyc
    │           │   │   │   │   ├── search_scope.cpython-312.pyc
    │           │   │   │   │   ├── selection_prefs.cpython-312.pyc
    │           │   │   │   │   ├── target_python.cpython-312.pyc
    │           │   │   │   │   └── wheel.cpython-312.pyc
    │           │   │   │   ├── scheme.py
    │           │   │   │   ├── search_scope.py
    │           │   │   │   ├── selection_prefs.py
    │           │   │   │   ├── target_python.py
    │           │   │   │   └── wheel.py
    │           │   │   ├── network
    │           │   │   │   ├── auth.py
    │           │   │   │   ├── cache.py
    │           │   │   │   ├── download.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── lazy_wheel.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── auth.cpython-312.pyc
    │           │   │   │   │   ├── cache.cpython-312.pyc
    │           │   │   │   │   ├── download.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── lazy_wheel.cpython-312.pyc
    │           │   │   │   │   ├── session.cpython-312.pyc
    │           │   │   │   │   ├── utils.cpython-312.pyc
    │           │   │   │   │   └── xmlrpc.cpython-312.pyc
    │           │   │   │   ├── session.py
    │           │   │   │   ├── utils.py
    │           │   │   │   └── xmlrpc.py
    │           │   │   ├── operations
    │           │   │   │   ├── build
    │           │   │   │   │   ├── build_tracker.py
    │           │   │   │   │   ├── __init__.py
    │           │   │   │   │   ├── metadata_editable.py
    │           │   │   │   │   ├── metadata_legacy.py
    │           │   │   │   │   ├── metadata.py
    │           │   │   │   │   ├── __pycache__
    │           │   │   │   │   │   ├── build_tracker.cpython-312.pyc
    │           │   │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   │   ├── metadata.cpython-312.pyc
    │           │   │   │   │   │   ├── metadata_editable.cpython-312.pyc
    │           │   │   │   │   │   ├── metadata_legacy.cpython-312.pyc
    │           │   │   │   │   │   ├── wheel.cpython-312.pyc
    │           │   │   │   │   │   ├── wheel_editable.cpython-312.pyc
    │           │   │   │   │   │   └── wheel_legacy.cpython-312.pyc
    │           │   │   │   │   ├── wheel_editable.py
    │           │   │   │   │   ├── wheel_legacy.py
    │           │   │   │   │   └── wheel.py
    │           │   │   │   ├── check.py
    │           │   │   │   ├── freeze.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── install
    │           │   │   │   │   ├── editable_legacy.py
    │           │   │   │   │   ├── __init__.py
    │           │   │   │   │   ├── __pycache__
    │           │   │   │   │   │   ├── editable_legacy.cpython-312.pyc
    │           │   │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   │   └── wheel.cpython-312.pyc
    │           │   │   │   │   └── wheel.py
    │           │   │   │   ├── prepare.py
    │           │   │   │   └── __pycache__
    │           │   │   │       ├── check.cpython-312.pyc
    │           │   │   │       ├── freeze.cpython-312.pyc
    │           │   │   │       ├── __init__.cpython-312.pyc
    │           │   │   │       └── prepare.cpython-312.pyc
    │           │   │   ├── __pycache__
    │           │   │   │   ├── build_env.cpython-312.pyc
    │           │   │   │   ├── cache.cpython-312.pyc
    │           │   │   │   ├── configuration.cpython-312.pyc
    │           │   │   │   ├── exceptions.cpython-312.pyc
    │           │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   ├── main.cpython-312.pyc
    │           │   │   │   ├── pyproject.cpython-312.pyc
    │           │   │   │   ├── self_outdated_check.cpython-312.pyc
    │           │   │   │   └── wheel_builder.cpython-312.pyc
    │           │   │   ├── pyproject.py
    │           │   │   ├── req
    │           │   │   │   ├── constructors.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── constructors.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── req_file.cpython-312.pyc
    │           │   │   │   │   ├── req_install.cpython-312.pyc
    │           │   │   │   │   ├── req_set.cpython-312.pyc
    │           │   │   │   │   └── req_uninstall.cpython-312.pyc
    │           │   │   │   ├── req_file.py
    │           │   │   │   ├── req_install.py
    │           │   │   │   ├── req_set.py
    │           │   │   │   └── req_uninstall.py
    │           │   │   ├── resolution
    │           │   │   │   ├── base.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── legacy
    │           │   │   │   │   ├── __init__.py
    │           │   │   │   │   ├── __pycache__
    │           │   │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   │   └── resolver.cpython-312.pyc
    │           │   │   │   │   └── resolver.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── base.cpython-312.pyc
    │           │   │   │   │   └── __init__.cpython-312.pyc
    │           │   │   │   └── resolvelib
    │           │   │   │       ├── base.py
    │           │   │   │       ├── candidates.py
    │           │   │   │       ├── factory.py
    │           │   │   │       ├── found_candidates.py
    │           │   │   │       ├── __init__.py
    │           │   │   │       ├── provider.py
    │           │   │   │       ├── __pycache__
    │           │   │   │       │   ├── base.cpython-312.pyc
    │           │   │   │       │   ├── candidates.cpython-312.pyc
    │           │   │   │       │   ├── factory.cpython-312.pyc
    │           │   │   │       │   ├── found_candidates.cpython-312.pyc
    │           │   │   │       │   ├── __init__.cpython-312.pyc
    │           │   │   │       │   ├── provider.cpython-312.pyc
    │           │   │   │       │   ├── reporter.cpython-312.pyc
    │           │   │   │       │   ├── requirements.cpython-312.pyc
    │           │   │   │       │   └── resolver.cpython-312.pyc
    │           │   │   │       ├── reporter.py
    │           │   │   │       ├── requirements.py
    │           │   │   │       └── resolver.py
    │           │   │   ├── self_outdated_check.py
    │           │   │   ├── utils
    │           │   │   │   ├── appdirs.py
    │           │   │   │   ├── compatibility_tags.py
    │           │   │   │   ├── compat.py
    │           │   │   │   ├── datetime.py
    │           │   │   │   ├── deprecation.py
    │           │   │   │   ├── direct_url_helpers.py
    │           │   │   │   ├── egg_link.py
    │           │   │   │   ├── encoding.py
    │           │   │   │   ├── entrypoints.py
    │           │   │   │   ├── filesystem.py
    │           │   │   │   ├── filetypes.py
    │           │   │   │   ├── glibc.py
    │           │   │   │   ├── hashes.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── _jaraco_text.py
    │           │   │   │   ├── logging.py
    │           │   │   │   ├── _log.py
    │           │   │   │   ├── misc.py
    │           │   │   │   ├── models.py
    │           │   │   │   ├── packaging.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── appdirs.cpython-312.pyc
    │           │   │   │   │   ├── compat.cpython-312.pyc
    │           │   │   │   │   ├── compatibility_tags.cpython-312.pyc
    │           │   │   │   │   ├── datetime.cpython-312.pyc
    │           │   │   │   │   ├── deprecation.cpython-312.pyc
    │           │   │   │   │   ├── direct_url_helpers.cpython-312.pyc
    │           │   │   │   │   ├── egg_link.cpython-312.pyc
    │           │   │   │   │   ├── encoding.cpython-312.pyc
    │           │   │   │   │   ├── entrypoints.cpython-312.pyc
    │           │   │   │   │   ├── filesystem.cpython-312.pyc
    │           │   │   │   │   ├── filetypes.cpython-312.pyc
    │           │   │   │   │   ├── glibc.cpython-312.pyc
    │           │   │   │   │   ├── hashes.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── _jaraco_text.cpython-312.pyc
    │           │   │   │   │   ├── _log.cpython-312.pyc
    │           │   │   │   │   ├── logging.cpython-312.pyc
    │           │   │   │   │   ├── misc.cpython-312.pyc
    │           │   │   │   │   ├── models.cpython-312.pyc
    │           │   │   │   │   ├── packaging.cpython-312.pyc
    │           │   │   │   │   ├── setuptools_build.cpython-312.pyc
    │           │   │   │   │   ├── subprocess.cpython-312.pyc
    │           │   │   │   │   ├── temp_dir.cpython-312.pyc
    │           │   │   │   │   ├── unpacking.cpython-312.pyc
    │           │   │   │   │   ├── urls.cpython-312.pyc
    │           │   │   │   │   ├── virtualenv.cpython-312.pyc
    │           │   │   │   │   └── wheel.cpython-312.pyc
    │           │   │   │   ├── setuptools_build.py
    │           │   │   │   ├── subprocess.py
    │           │   │   │   ├── temp_dir.py
    │           │   │   │   ├── unpacking.py
    │           │   │   │   ├── urls.py
    │           │   │   │   ├── virtualenv.py
    │           │   │   │   └── wheel.py
    │           │   │   ├── vcs
    │           │   │   │   ├── bazaar.py
    │           │   │   │   ├── git.py
    │           │   │   │   ├── __init__.py
    │           │   │   │   ├── mercurial.py
    │           │   │   │   ├── __pycache__
    │           │   │   │   │   ├── bazaar.cpython-312.pyc
    │           │   │   │   │   ├── git.cpython-312.pyc
    │           │   │   │   │   ├── __init__.cpython-312.pyc
    │           │   │   │   │   ├── mercurial.cpython-312.pyc
    │           │   │   │   │   ├── subversion.cpython-312.pyc
    │           │   │   │   │   └── versioncontrol.cpython-312.pyc
    │           │   │   │   ├── subversion.py
    │           │   │   │   └── versioncontrol.py
    │           │   │   └── wheel_builder.py
    │           │   ├── __main__.py
    │           │   ├── __pip-runner__.py
    │           │   ├── __pycache__
    │           │   │   ├── __init__.cpython-312.pyc
    │           │   │   ├── __main__.cpython-312.pyc
    │           │   │   └── __pip-runner__.cpython-312.pyc
    │           │   ├── py.typed
    │           │   └── _vendor
    │           │       ├── cachecontrol
    │           │       │   ├── adapter.py
    │           │       │   ├── cache.py
    │           │       │   ├── caches
    │           │       │   │   ├── file_cache.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── file_cache.cpython-312.pyc
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   └── redis_cache.cpython-312.pyc
    │           │       │   │   └── redis_cache.py
    │           │       │   ├── _cmd.py
    │           │       │   ├── controller.py
    │           │       │   ├── filewrapper.py
    │           │       │   ├── heuristics.py
    │           │       │   ├── __init__.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── adapter.cpython-312.pyc
    │           │       │   │   ├── cache.cpython-312.pyc
    │           │       │   │   ├── _cmd.cpython-312.pyc
    │           │       │   │   ├── controller.cpython-312.pyc
    │           │       │   │   ├── filewrapper.cpython-312.pyc
    │           │       │   │   ├── heuristics.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── serialize.cpython-312.pyc
    │           │       │   │   └── wrapper.cpython-312.pyc
    │           │       │   ├── serialize.py
    │           │       │   └── wrapper.py
    │           │       ├── certifi
    │           │       │   ├── cacert.pem
    │           │       │   ├── core.py
    │           │       │   ├── __init__.py
    │           │       │   ├── __main__.py
    │           │       │   └── __pycache__
    │           │       │       ├── core.cpython-312.pyc
    │           │       │       ├── __init__.cpython-312.pyc
    │           │       │       └── __main__.cpython-312.pyc
    │           │       ├── chardet
    │           │       │   ├── big5freq.py
    │           │       │   ├── big5prober.py
    │           │       │   ├── chardistribution.py
    │           │       │   ├── charsetgroupprober.py
    │           │       │   ├── charsetprober.py
    │           │       │   ├── cli
    │           │       │   │   ├── chardetect.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   └── __pycache__
    │           │       │   │       ├── chardetect.cpython-312.pyc
    │           │       │   │       └── __init__.cpython-312.pyc
    │           │       │   ├── codingstatemachinedict.py
    │           │       │   ├── codingstatemachine.py
    │           │       │   ├── cp949prober.py
    │           │       │   ├── enums.py
    │           │       │   ├── escprober.py
    │           │       │   ├── escsm.py
    │           │       │   ├── eucjpprober.py
    │           │       │   ├── euckrfreq.py
    │           │       │   ├── euckrprober.py
    │           │       │   ├── euctwfreq.py
    │           │       │   ├── euctwprober.py
    │           │       │   ├── gb2312freq.py
    │           │       │   ├── gb2312prober.py
    │           │       │   ├── hebrewprober.py
    │           │       │   ├── __init__.py
    │           │       │   ├── jisfreq.py
    │           │       │   ├── johabfreq.py
    │           │       │   ├── johabprober.py
    │           │       │   ├── jpcntx.py
    │           │       │   ├── langbulgarianmodel.py
    │           │       │   ├── langgreekmodel.py
    │           │       │   ├── langhebrewmodel.py
    │           │       │   ├── langhungarianmodel.py
    │           │       │   ├── langrussianmodel.py
    │           │       │   ├── langthaimodel.py
    │           │       │   ├── langturkishmodel.py
    │           │       │   ├── latin1prober.py
    │           │       │   ├── macromanprober.py
    │           │       │   ├── mbcharsetprober.py
    │           │       │   ├── mbcsgroupprober.py
    │           │       │   ├── mbcssm.py
    │           │       │   ├── metadata
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── languages.py
    │           │       │   │   └── __pycache__
    │           │       │   │       ├── __init__.cpython-312.pyc
    │           │       │   │       └── languages.cpython-312.pyc
    │           │       │   ├── __pycache__
    │           │       │   │   ├── big5freq.cpython-312.pyc
    │           │       │   │   ├── big5prober.cpython-312.pyc
    │           │       │   │   ├── chardistribution.cpython-312.pyc
    │           │       │   │   ├── charsetgroupprober.cpython-312.pyc
    │           │       │   │   ├── charsetprober.cpython-312.pyc
    │           │       │   │   ├── codingstatemachine.cpython-312.pyc
    │           │       │   │   ├── codingstatemachinedict.cpython-312.pyc
    │           │       │   │   ├── cp949prober.cpython-312.pyc
    │           │       │   │   ├── enums.cpython-312.pyc
    │           │       │   │   ├── escprober.cpython-312.pyc
    │           │       │   │   ├── escsm.cpython-312.pyc
    │           │       │   │   ├── eucjpprober.cpython-312.pyc
    │           │       │   │   ├── euckrfreq.cpython-312.pyc
    │           │       │   │   ├── euckrprober.cpython-312.pyc
    │           │       │   │   ├── euctwfreq.cpython-312.pyc
    │           │       │   │   ├── euctwprober.cpython-312.pyc
    │           │       │   │   ├── gb2312freq.cpython-312.pyc
    │           │       │   │   ├── gb2312prober.cpython-312.pyc
    │           │       │   │   ├── hebrewprober.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── jisfreq.cpython-312.pyc
    │           │       │   │   ├── johabfreq.cpython-312.pyc
    │           │       │   │   ├── johabprober.cpython-312.pyc
    │           │       │   │   ├── jpcntx.cpython-312.pyc
    │           │       │   │   ├── langbulgarianmodel.cpython-312.pyc
    │           │       │   │   ├── langgreekmodel.cpython-312.pyc
    │           │       │   │   ├── langhebrewmodel.cpython-312.pyc
    │           │       │   │   ├── langhungarianmodel.cpython-312.pyc
    │           │       │   │   ├── langrussianmodel.cpython-312.pyc
    │           │       │   │   ├── langthaimodel.cpython-312.pyc
    │           │       │   │   ├── langturkishmodel.cpython-312.pyc
    │           │       │   │   ├── latin1prober.cpython-312.pyc
    │           │       │   │   ├── macromanprober.cpython-312.pyc
    │           │       │   │   ├── mbcharsetprober.cpython-312.pyc
    │           │       │   │   ├── mbcsgroupprober.cpython-312.pyc
    │           │       │   │   ├── mbcssm.cpython-312.pyc
    │           │       │   │   ├── resultdict.cpython-312.pyc
    │           │       │   │   ├── sbcharsetprober.cpython-312.pyc
    │           │       │   │   ├── sbcsgroupprober.cpython-312.pyc
    │           │       │   │   ├── sjisprober.cpython-312.pyc
    │           │       │   │   ├── universaldetector.cpython-312.pyc
    │           │       │   │   ├── utf1632prober.cpython-312.pyc
    │           │       │   │   ├── utf8prober.cpython-312.pyc
    │           │       │   │   └── version.cpython-312.pyc
    │           │       │   ├── resultdict.py
    │           │       │   ├── sbcharsetprober.py
    │           │       │   ├── sbcsgroupprober.py
    │           │       │   ├── sjisprober.py
    │           │       │   ├── universaldetector.py
    │           │       │   ├── utf1632prober.py
    │           │       │   ├── utf8prober.py
    │           │       │   └── version.py
    │           │       ├── colorama
    │           │       │   ├── ansi.py
    │           │       │   ├── ansitowin32.py
    │           │       │   ├── initialise.py
    │           │       │   ├── __init__.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── ansi.cpython-312.pyc
    │           │       │   │   ├── ansitowin32.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── initialise.cpython-312.pyc
    │           │       │   │   ├── win32.cpython-312.pyc
    │           │       │   │   └── winterm.cpython-312.pyc
    │           │       │   ├── tests
    │           │       │   │   ├── ansi_test.py
    │           │       │   │   ├── ansitowin32_test.py
    │           │       │   │   ├── initialise_test.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── isatty_test.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── ansi_test.cpython-312.pyc
    │           │       │   │   │   ├── ansitowin32_test.cpython-312.pyc
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   ├── initialise_test.cpython-312.pyc
    │           │       │   │   │   ├── isatty_test.cpython-312.pyc
    │           │       │   │   │   ├── utils.cpython-312.pyc
    │           │       │   │   │   └── winterm_test.cpython-312.pyc
    │           │       │   │   ├── utils.py
    │           │       │   │   └── winterm_test.py
    │           │       │   ├── win32.py
    │           │       │   └── winterm.py
    │           │       ├── distlib
    │           │       │   ├── compat.py
    │           │       │   ├── database.py
    │           │       │   ├── index.py
    │           │       │   ├── __init__.py
    │           │       │   ├── locators.py
    │           │       │   ├── manifest.py
    │           │       │   ├── markers.py
    │           │       │   ├── metadata.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── compat.cpython-312.pyc
    │           │       │   │   ├── database.cpython-312.pyc
    │           │       │   │   ├── index.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── locators.cpython-312.pyc
    │           │       │   │   ├── manifest.cpython-312.pyc
    │           │       │   │   ├── markers.cpython-312.pyc
    │           │       │   │   ├── metadata.cpython-312.pyc
    │           │       │   │   ├── resources.cpython-312.pyc
    │           │       │   │   ├── scripts.cpython-312.pyc
    │           │       │   │   ├── util.cpython-312.pyc
    │           │       │   │   ├── version.cpython-312.pyc
    │           │       │   │   └── wheel.cpython-312.pyc
    │           │       │   ├── resources.py
    │           │       │   ├── scripts.py
    │           │       │   ├── util.py
    │           │       │   ├── version.py
    │           │       │   └── wheel.py
    │           │       ├── distro
    │           │       │   ├── distro.py
    │           │       │   ├── __init__.py
    │           │       │   ├── __main__.py
    │           │       │   └── __pycache__
    │           │       │       ├── distro.cpython-312.pyc
    │           │       │       ├── __init__.cpython-312.pyc
    │           │       │       └── __main__.cpython-312.pyc
    │           │       ├── idna
    │           │       │   ├── codec.py
    │           │       │   ├── compat.py
    │           │       │   ├── core.py
    │           │       │   ├── idnadata.py
    │           │       │   ├── __init__.py
    │           │       │   ├── intranges.py
    │           │       │   ├── package_data.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── codec.cpython-312.pyc
    │           │       │   │   ├── compat.cpython-312.pyc
    │           │       │   │   ├── core.cpython-312.pyc
    │           │       │   │   ├── idnadata.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── intranges.cpython-312.pyc
    │           │       │   │   ├── package_data.cpython-312.pyc
    │           │       │   │   └── uts46data.cpython-312.pyc
    │           │       │   └── uts46data.py
    │           │       ├── __init__.py
    │           │       ├── msgpack
    │           │       │   ├── exceptions.py
    │           │       │   ├── ext.py
    │           │       │   ├── fallback.py
    │           │       │   ├── __init__.py
    │           │       │   └── __pycache__
    │           │       │       ├── exceptions.cpython-312.pyc
    │           │       │       ├── ext.cpython-312.pyc
    │           │       │       ├── fallback.cpython-312.pyc
    │           │       │       └── __init__.cpython-312.pyc
    │           │       ├── packaging
    │           │       │   ├── __about__.py
    │           │       │   ├── __init__.py
    │           │       │   ├── _manylinux.py
    │           │       │   ├── markers.py
    │           │       │   ├── _musllinux.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── __about__.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── _manylinux.cpython-312.pyc
    │           │       │   │   ├── markers.cpython-312.pyc
    │           │       │   │   ├── _musllinux.cpython-312.pyc
    │           │       │   │   ├── requirements.cpython-312.pyc
    │           │       │   │   ├── specifiers.cpython-312.pyc
    │           │       │   │   ├── _structures.cpython-312.pyc
    │           │       │   │   ├── tags.cpython-312.pyc
    │           │       │   │   ├── utils.cpython-312.pyc
    │           │       │   │   └── version.cpython-312.pyc
    │           │       │   ├── requirements.py
    │           │       │   ├── specifiers.py
    │           │       │   ├── _structures.py
    │           │       │   ├── tags.py
    │           │       │   ├── utils.py
    │           │       │   └── version.py
    │           │       ├── pkg_resources
    │           │       │   ├── __init__.py
    │           │       │   └── __pycache__
    │           │       │       └── __init__.cpython-312.pyc
    │           │       ├── platformdirs
    │           │       │   ├── android.py
    │           │       │   ├── api.py
    │           │       │   ├── __init__.py
    │           │       │   ├── macos.py
    │           │       │   ├── __main__.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── android.cpython-312.pyc
    │           │       │   │   ├── api.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── macos.cpython-312.pyc
    │           │       │   │   ├── __main__.cpython-312.pyc
    │           │       │   │   ├── unix.cpython-312.pyc
    │           │       │   │   ├── version.cpython-312.pyc
    │           │       │   │   └── windows.cpython-312.pyc
    │           │       │   ├── unix.py
    │           │       │   ├── version.py
    │           │       │   └── windows.py
    │           │       ├── __pycache__
    │           │       │   ├── __init__.cpython-312.pyc
    │           │       │   ├── six.cpython-312.pyc
    │           │       │   └── typing_extensions.cpython-312.pyc
    │           │       ├── pygments
    │           │       │   ├── cmdline.py
    │           │       │   ├── console.py
    │           │       │   ├── filter.py
    │           │       │   ├── filters
    │           │       │   │   ├── __init__.py
    │           │       │   │   └── __pycache__
    │           │       │   │       └── __init__.cpython-312.pyc
    │           │       │   ├── formatter.py
    │           │       │   ├── formatters
    │           │       │   │   ├── bbcode.py
    │           │       │   │   ├── groff.py
    │           │       │   │   ├── html.py
    │           │       │   │   ├── img.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── irc.py
    │           │       │   │   ├── latex.py
    │           │       │   │   ├── _mapping.py
    │           │       │   │   ├── other.py
    │           │       │   │   ├── pangomarkup.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── bbcode.cpython-312.pyc
    │           │       │   │   │   ├── groff.cpython-312.pyc
    │           │       │   │   │   ├── html.cpython-312.pyc
    │           │       │   │   │   ├── img.cpython-312.pyc
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   ├── irc.cpython-312.pyc
    │           │       │   │   │   ├── latex.cpython-312.pyc
    │           │       │   │   │   ├── _mapping.cpython-312.pyc
    │           │       │   │   │   ├── other.cpython-312.pyc
    │           │       │   │   │   ├── pangomarkup.cpython-312.pyc
    │           │       │   │   │   ├── rtf.cpython-312.pyc
    │           │       │   │   │   ├── svg.cpython-312.pyc
    │           │       │   │   │   ├── terminal256.cpython-312.pyc
    │           │       │   │   │   └── terminal.cpython-312.pyc
    │           │       │   │   ├── rtf.py
    │           │       │   │   ├── svg.py
    │           │       │   │   ├── terminal256.py
    │           │       │   │   └── terminal.py
    │           │       │   ├── __init__.py
    │           │       │   ├── lexer.py
    │           │       │   ├── lexers
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── _mapping.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   ├── _mapping.cpython-312.pyc
    │           │       │   │   │   └── python.cpython-312.pyc
    │           │       │   │   └── python.py
    │           │       │   ├── __main__.py
    │           │       │   ├── modeline.py
    │           │       │   ├── plugin.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── cmdline.cpython-312.pyc
    │           │       │   │   ├── console.cpython-312.pyc
    │           │       │   │   ├── filter.cpython-312.pyc
    │           │       │   │   ├── formatter.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── lexer.cpython-312.pyc
    │           │       │   │   ├── __main__.cpython-312.pyc
    │           │       │   │   ├── modeline.cpython-312.pyc
    │           │       │   │   ├── plugin.cpython-312.pyc
    │           │       │   │   ├── regexopt.cpython-312.pyc
    │           │       │   │   ├── scanner.cpython-312.pyc
    │           │       │   │   ├── sphinxext.cpython-312.pyc
    │           │       │   │   ├── style.cpython-312.pyc
    │           │       │   │   ├── token.cpython-312.pyc
    │           │       │   │   ├── unistring.cpython-312.pyc
    │           │       │   │   └── util.cpython-312.pyc
    │           │       │   ├── regexopt.py
    │           │       │   ├── scanner.py
    │           │       │   ├── sphinxext.py
    │           │       │   ├── style.py
    │           │       │   ├── styles
    │           │       │   │   ├── __init__.py
    │           │       │   │   └── __pycache__
    │           │       │   │       └── __init__.cpython-312.pyc
    │           │       │   ├── token.py
    │           │       │   ├── unistring.py
    │           │       │   └── util.py
    │           │       ├── pyparsing
    │           │       │   ├── actions.py
    │           │       │   ├── common.py
    │           │       │   ├── core.py
    │           │       │   ├── diagram
    │           │       │   │   ├── __init__.py
    │           │       │   │   └── __pycache__
    │           │       │   │       └── __init__.cpython-312.pyc
    │           │       │   ├── exceptions.py
    │           │       │   ├── helpers.py
    │           │       │   ├── __init__.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── actions.cpython-312.pyc
    │           │       │   │   ├── common.cpython-312.pyc
    │           │       │   │   ├── core.cpython-312.pyc
    │           │       │   │   ├── exceptions.cpython-312.pyc
    │           │       │   │   ├── helpers.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── results.cpython-312.pyc
    │           │       │   │   ├── testing.cpython-312.pyc
    │           │       │   │   ├── unicode.cpython-312.pyc
    │           │       │   │   └── util.cpython-312.pyc
    │           │       │   ├── results.py
    │           │       │   ├── testing.py
    │           │       │   ├── unicode.py
    │           │       │   └── util.py
    │           │       ├── pyproject_hooks
    │           │       │   ├── _compat.py
    │           │       │   ├── _impl.py
    │           │       │   ├── __init__.py
    │           │       │   ├── _in_process
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── _in_process.py
    │           │       │   │   └── __pycache__
    │           │       │   │       ├── __init__.cpython-312.pyc
    │           │       │   │       └── _in_process.cpython-312.pyc
    │           │       │   └── __pycache__
    │           │       │       ├── _compat.cpython-312.pyc
    │           │       │       ├── _impl.cpython-312.pyc
    │           │       │       └── __init__.cpython-312.pyc
    │           │       ├── requests
    │           │       │   ├── adapters.py
    │           │       │   ├── api.py
    │           │       │   ├── auth.py
    │           │       │   ├── certs.py
    │           │       │   ├── compat.py
    │           │       │   ├── cookies.py
    │           │       │   ├── exceptions.py
    │           │       │   ├── help.py
    │           │       │   ├── hooks.py
    │           │       │   ├── __init__.py
    │           │       │   ├── _internal_utils.py
    │           │       │   ├── models.py
    │           │       │   ├── packages.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── adapters.cpython-312.pyc
    │           │       │   │   ├── api.cpython-312.pyc
    │           │       │   │   ├── auth.cpython-312.pyc
    │           │       │   │   ├── certs.cpython-312.pyc
    │           │       │   │   ├── compat.cpython-312.pyc
    │           │       │   │   ├── cookies.cpython-312.pyc
    │           │       │   │   ├── exceptions.cpython-312.pyc
    │           │       │   │   ├── help.cpython-312.pyc
    │           │       │   │   ├── hooks.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── _internal_utils.cpython-312.pyc
    │           │       │   │   ├── models.cpython-312.pyc
    │           │       │   │   ├── packages.cpython-312.pyc
    │           │       │   │   ├── sessions.cpython-312.pyc
    │           │       │   │   ├── status_codes.cpython-312.pyc
    │           │       │   │   ├── structures.cpython-312.pyc
    │           │       │   │   ├── utils.cpython-312.pyc
    │           │       │   │   └── __version__.cpython-312.pyc
    │           │       │   ├── sessions.py
    │           │       │   ├── status_codes.py
    │           │       │   ├── structures.py
    │           │       │   ├── utils.py
    │           │       │   └── __version__.py
    │           │       ├── resolvelib
    │           │       │   ├── compat
    │           │       │   │   ├── collections_abc.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   └── __pycache__
    │           │       │   │       ├── collections_abc.cpython-312.pyc
    │           │       │   │       └── __init__.cpython-312.pyc
    │           │       │   ├── __init__.py
    │           │       │   ├── providers.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── providers.cpython-312.pyc
    │           │       │   │   ├── reporters.cpython-312.pyc
    │           │       │   │   ├── resolvers.cpython-312.pyc
    │           │       │   │   └── structs.cpython-312.pyc
    │           │       │   ├── reporters.py
    │           │       │   ├── resolvers.py
    │           │       │   └── structs.py
    │           │       ├── rich
    │           │       │   ├── abc.py
    │           │       │   ├── align.py
    │           │       │   ├── ansi.py
    │           │       │   ├── bar.py
    │           │       │   ├── box.py
    │           │       │   ├── cells.py
    │           │       │   ├── _cell_widths.py
    │           │       │   ├── color.py
    │           │       │   ├── color_triplet.py
    │           │       │   ├── columns.py
    │           │       │   ├── console.py
    │           │       │   ├── constrain.py
    │           │       │   ├── containers.py
    │           │       │   ├── control.py
    │           │       │   ├── default_styles.py
    │           │       │   ├── diagnose.py
    │           │       │   ├── _emoji_codes.py
    │           │       │   ├── emoji.py
    │           │       │   ├── _emoji_replace.py
    │           │       │   ├── errors.py
    │           │       │   ├── _export_format.py
    │           │       │   ├── _extension.py
    │           │       │   ├── _fileno.py
    │           │       │   ├── file_proxy.py
    │           │       │   ├── filesize.py
    │           │       │   ├── highlighter.py
    │           │       │   ├── __init__.py
    │           │       │   ├── _inspect.py
    │           │       │   ├── json.py
    │           │       │   ├── jupyter.py
    │           │       │   ├── layout.py
    │           │       │   ├── live.py
    │           │       │   ├── live_render.py
    │           │       │   ├── logging.py
    │           │       │   ├── _log_render.py
    │           │       │   ├── _loop.py
    │           │       │   ├── __main__.py
    │           │       │   ├── markup.py
    │           │       │   ├── measure.py
    │           │       │   ├── _null_file.py
    │           │       │   ├── padding.py
    │           │       │   ├── pager.py
    │           │       │   ├── palette.py
    │           │       │   ├── _palettes.py
    │           │       │   ├── panel.py
    │           │       │   ├── _pick.py
    │           │       │   ├── pretty.py
    │           │       │   ├── progress_bar.py
    │           │       │   ├── progress.py
    │           │       │   ├── prompt.py
    │           │       │   ├── protocol.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── abc.cpython-312.pyc
    │           │       │   │   ├── align.cpython-312.pyc
    │           │       │   │   ├── ansi.cpython-312.pyc
    │           │       │   │   ├── bar.cpython-312.pyc
    │           │       │   │   ├── box.cpython-312.pyc
    │           │       │   │   ├── cells.cpython-312.pyc
    │           │       │   │   ├── _cell_widths.cpython-312.pyc
    │           │       │   │   ├── color.cpython-312.pyc
    │           │       │   │   ├── color_triplet.cpython-312.pyc
    │           │       │   │   ├── columns.cpython-312.pyc
    │           │       │   │   ├── console.cpython-312.pyc
    │           │       │   │   ├── constrain.cpython-312.pyc
    │           │       │   │   ├── containers.cpython-312.pyc
    │           │       │   │   ├── control.cpython-312.pyc
    │           │       │   │   ├── default_styles.cpython-312.pyc
    │           │       │   │   ├── diagnose.cpython-312.pyc
    │           │       │   │   ├── _emoji_codes.cpython-312.pyc
    │           │       │   │   ├── emoji.cpython-312.pyc
    │           │       │   │   ├── _emoji_replace.cpython-312.pyc
    │           │       │   │   ├── errors.cpython-312.pyc
    │           │       │   │   ├── _export_format.cpython-312.pyc
    │           │       │   │   ├── _extension.cpython-312.pyc
    │           │       │   │   ├── _fileno.cpython-312.pyc
    │           │       │   │   ├── file_proxy.cpython-312.pyc
    │           │       │   │   ├── filesize.cpython-312.pyc
    │           │       │   │   ├── highlighter.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── _inspect.cpython-312.pyc
    │           │       │   │   ├── json.cpython-312.pyc
    │           │       │   │   ├── jupyter.cpython-312.pyc
    │           │       │   │   ├── layout.cpython-312.pyc
    │           │       │   │   ├── live.cpython-312.pyc
    │           │       │   │   ├── live_render.cpython-312.pyc
    │           │       │   │   ├── logging.cpython-312.pyc
    │           │       │   │   ├── _log_render.cpython-312.pyc
    │           │       │   │   ├── _loop.cpython-312.pyc
    │           │       │   │   ├── __main__.cpython-312.pyc
    │           │       │   │   ├── markup.cpython-312.pyc
    │           │       │   │   ├── measure.cpython-312.pyc
    │           │       │   │   ├── _null_file.cpython-312.pyc
    │           │       │   │   ├── padding.cpython-312.pyc
    │           │       │   │   ├── pager.cpython-312.pyc
    │           │       │   │   ├── palette.cpython-312.pyc
    │           │       │   │   ├── _palettes.cpython-312.pyc
    │           │       │   │   ├── panel.cpython-312.pyc
    │           │       │   │   ├── _pick.cpython-312.pyc
    │           │       │   │   ├── pretty.cpython-312.pyc
    │           │       │   │   ├── progress_bar.cpython-312.pyc
    │           │       │   │   ├── progress.cpython-312.pyc
    │           │       │   │   ├── prompt.cpython-312.pyc
    │           │       │   │   ├── protocol.cpython-312.pyc
    │           │       │   │   ├── _ratio.cpython-312.pyc
    │           │       │   │   ├── region.cpython-312.pyc
    │           │       │   │   ├── repr.cpython-312.pyc
    │           │       │   │   ├── rule.cpython-312.pyc
    │           │       │   │   ├── scope.cpython-312.pyc
    │           │       │   │   ├── screen.cpython-312.pyc
    │           │       │   │   ├── segment.cpython-312.pyc
    │           │       │   │   ├── spinner.cpython-312.pyc
    │           │       │   │   ├── _spinners.cpython-312.pyc
    │           │       │   │   ├── _stack.cpython-312.pyc
    │           │       │   │   ├── status.cpython-312.pyc
    │           │       │   │   ├── style.cpython-312.pyc
    │           │       │   │   ├── styled.cpython-312.pyc
    │           │       │   │   ├── syntax.cpython-312.pyc
    │           │       │   │   ├── table.cpython-312.pyc
    │           │       │   │   ├── terminal_theme.cpython-312.pyc
    │           │       │   │   ├── text.cpython-312.pyc
    │           │       │   │   ├── theme.cpython-312.pyc
    │           │       │   │   ├── themes.cpython-312.pyc
    │           │       │   │   ├── _timer.cpython-312.pyc
    │           │       │   │   ├── traceback.cpython-312.pyc
    │           │       │   │   ├── tree.cpython-312.pyc
    │           │       │   │   ├── _win32_console.cpython-312.pyc
    │           │       │   │   ├── _windows.cpython-312.pyc
    │           │       │   │   ├── _windows_renderer.cpython-312.pyc
    │           │       │   │   └── _wrap.cpython-312.pyc
    │           │       │   ├── _ratio.py
    │           │       │   ├── region.py
    │           │       │   ├── repr.py
    │           │       │   ├── rule.py
    │           │       │   ├── scope.py
    │           │       │   ├── screen.py
    │           │       │   ├── segment.py
    │           │       │   ├── spinner.py
    │           │       │   ├── _spinners.py
    │           │       │   ├── _stack.py
    │           │       │   ├── status.py
    │           │       │   ├── styled.py
    │           │       │   ├── style.py
    │           │       │   ├── syntax.py
    │           │       │   ├── table.py
    │           │       │   ├── terminal_theme.py
    │           │       │   ├── text.py
    │           │       │   ├── theme.py
    │           │       │   ├── themes.py
    │           │       │   ├── _timer.py
    │           │       │   ├── traceback.py
    │           │       │   ├── tree.py
    │           │       │   ├── _win32_console.py
    │           │       │   ├── _windows.py
    │           │       │   ├── _windows_renderer.py
    │           │       │   └── _wrap.py
    │           │       ├── six.py
    │           │       ├── tenacity
    │           │       │   ├── after.py
    │           │       │   ├── _asyncio.py
    │           │       │   ├── before.py
    │           │       │   ├── before_sleep.py
    │           │       │   ├── __init__.py
    │           │       │   ├── nap.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── after.cpython-312.pyc
    │           │       │   │   ├── _asyncio.cpython-312.pyc
    │           │       │   │   ├── before.cpython-312.pyc
    │           │       │   │   ├── before_sleep.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── nap.cpython-312.pyc
    │           │       │   │   ├── retry.cpython-312.pyc
    │           │       │   │   ├── stop.cpython-312.pyc
    │           │       │   │   ├── tornadoweb.cpython-312.pyc
    │           │       │   │   ├── _utils.cpython-312.pyc
    │           │       │   │   └── wait.cpython-312.pyc
    │           │       │   ├── retry.py
    │           │       │   ├── stop.py
    │           │       │   ├── tornadoweb.py
    │           │       │   ├── _utils.py
    │           │       │   └── wait.py
    │           │       ├── tomli
    │           │       │   ├── __init__.py
    │           │       │   ├── _parser.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── _parser.cpython-312.pyc
    │           │       │   │   ├── _re.cpython-312.pyc
    │           │       │   │   └── _types.cpython-312.pyc
    │           │       │   ├── _re.py
    │           │       │   └── _types.py
    │           │       ├── truststore
    │           │       │   ├── _api.py
    │           │       │   ├── __init__.py
    │           │       │   ├── _macos.py
    │           │       │   ├── _openssl.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── _api.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── _macos.cpython-312.pyc
    │           │       │   │   ├── _openssl.cpython-312.pyc
    │           │       │   │   ├── _ssl_constants.cpython-312.pyc
    │           │       │   │   └── _windows.cpython-312.pyc
    │           │       │   ├── _ssl_constants.py
    │           │       │   └── _windows.py
    │           │       ├── typing_extensions.py
    │           │       ├── urllib3
    │           │       │   ├── _collections.py
    │           │       │   ├── connectionpool.py
    │           │       │   ├── connection.py
    │           │       │   ├── contrib
    │           │       │   │   ├── _appengine_environ.py
    │           │       │   │   ├── appengine.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── ntlmpool.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── appengine.cpython-312.pyc
    │           │       │   │   │   ├── _appengine_environ.cpython-312.pyc
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   ├── ntlmpool.cpython-312.pyc
    │           │       │   │   │   ├── pyopenssl.cpython-312.pyc
    │           │       │   │   │   ├── securetransport.cpython-312.pyc
    │           │       │   │   │   └── socks.cpython-312.pyc
    │           │       │   │   ├── pyopenssl.py
    │           │       │   │   ├── _securetransport
    │           │       │   │   │   ├── bindings.py
    │           │       │   │   │   ├── __init__.py
    │           │       │   │   │   ├── low_level.py
    │           │       │   │   │   └── __pycache__
    │           │       │   │   │       ├── bindings.cpython-312.pyc
    │           │       │   │   │       ├── __init__.cpython-312.pyc
    │           │       │   │   │       └── low_level.cpython-312.pyc
    │           │       │   │   ├── securetransport.py
    │           │       │   │   └── socks.py
    │           │       │   ├── exceptions.py
    │           │       │   ├── fields.py
    │           │       │   ├── filepost.py
    │           │       │   ├── __init__.py
    │           │       │   ├── packages
    │           │       │   │   ├── backports
    │           │       │   │   │   ├── __init__.py
    │           │       │   │   │   ├── makefile.py
    │           │       │   │   │   ├── __pycache__
    │           │       │   │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   │   ├── makefile.cpython-312.pyc
    │           │       │   │   │   │   └── weakref_finalize.cpython-312.pyc
    │           │       │   │   │   └── weakref_finalize.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   └── six.cpython-312.pyc
    │           │       │   │   └── six.py
    │           │       │   ├── poolmanager.py
    │           │       │   ├── __pycache__
    │           │       │   │   ├── _collections.cpython-312.pyc
    │           │       │   │   ├── connection.cpython-312.pyc
    │           │       │   │   ├── connectionpool.cpython-312.pyc
    │           │       │   │   ├── exceptions.cpython-312.pyc
    │           │       │   │   ├── fields.cpython-312.pyc
    │           │       │   │   ├── filepost.cpython-312.pyc
    │           │       │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   ├── poolmanager.cpython-312.pyc
    │           │       │   │   ├── request.cpython-312.pyc
    │           │       │   │   ├── response.cpython-312.pyc
    │           │       │   │   └── _version.cpython-312.pyc
    │           │       │   ├── request.py
    │           │       │   ├── response.py
    │           │       │   ├── util
    │           │       │   │   ├── connection.py
    │           │       │   │   ├── __init__.py
    │           │       │   │   ├── proxy.py
    │           │       │   │   ├── __pycache__
    │           │       │   │   │   ├── connection.cpython-312.pyc
    │           │       │   │   │   ├── __init__.cpython-312.pyc
    │           │       │   │   │   ├── proxy.cpython-312.pyc
    │           │       │   │   │   ├── queue.cpython-312.pyc
    │           │       │   │   │   ├── request.cpython-312.pyc
    │           │       │   │   │   ├── response.cpython-312.pyc
    │           │       │   │   │   ├── retry.cpython-312.pyc
    │           │       │   │   │   ├── ssl_.cpython-312.pyc
    │           │       │   │   │   ├── ssl_match_hostname.cpython-312.pyc
    │           │       │   │   │   ├── ssltransport.cpython-312.pyc
    │           │       │   │   │   ├── timeout.cpython-312.pyc
    │           │       │   │   │   ├── url.cpython-312.pyc
    │           │       │   │   │   └── wait.cpython-312.pyc
    │           │       │   │   ├── queue.py
    │           │       │   │   ├── request.py
    │           │       │   │   ├── response.py
    │           │       │   │   ├── retry.py
    │           │       │   │   ├── ssl_match_hostname.py
    │           │       │   │   ├── ssl_.py
    │           │       │   │   ├── ssltransport.py
    │           │       │   │   ├── timeout.py
    │           │       │   │   ├── url.py
    │           │       │   │   └── wait.py
    │           │       │   └── _version.py
    │           │       ├── vendor.txt
    │           │       └── webencodings
    │           │           ├── __init__.py
    │           │           ├── labels.py
    │           │           ├── mklabels.py
    │           │           ├── __pycache__
    │           │           │   ├── __init__.cpython-312.pyc
    │           │           │   ├── labels.cpython-312.pyc
    │           │           │   ├── mklabels.cpython-312.pyc
    │           │           │   ├── tests.cpython-312.pyc
    │           │           │   └── x_user_defined.cpython-312.pyc
    │           │           ├── tests.py
    │           │           └── x_user_defined.py
    │           └── pip-24.0.dist-info
    │               ├── AUTHORS.txt
    │               ├── entry_points.txt
    │               ├── INSTALLER
    │               ├── LICENSE.txt
    │               ├── METADATA
    │               ├── RECORD
    │               ├── REQUESTED
    │               ├── top_level.txt
    │               └── WHEEL
    ├── lib64 -> lib
    └── pyvenv.cfg

393 directories, 2221 files
