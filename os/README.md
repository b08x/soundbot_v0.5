# customizations

[x] numlock

[] move and or set apps to workspaces

[] cross workspacec alt-tab

[] either increase resolution or shinrk tool bar,
    [] window title bar



---

on first run

[ ]


TASK [dotfiles : correct ownership of ssh config] ********************************************************************************************************************************************
task path: /home/b08x/workspace/soundbot/os/roles/dotfiles/tasks/main.yml:26
 [WARNING]: Consider using the file module with mode rather than running chmod.  If you need to use command because file is insufficient you can add warn=False to this command task or set
command_warnings=False in ansible.cfg to get rid of this message.

fatal: [soundbot]: FAILED! => {"changed": true, "cmd": ["chmod", "600", "/home/b08x/.ssh/config"], "delta": "0:00:00.001972", "end": "2018-09-30 11:51:54.552771", "msg": "non-zero return code", "rc": 1, "start": "2018-09-30 11:51:54.550799", "stderr": "chmod: cannot access '/home/b08x/.ssh/config': No such file or directory", "stderr_lines": ["chmod: cannot access '/home/b08x/.ssh/config': No such file or directory"], "stdout": "", "stdout_lines": []}


then when opening a terminal;
bash: fasd: command not found
bash-4.4$ dnf install fasd

* run dnf install fasd


[ ]


TASK [workstation : install rpmfusion nonfree repo] ******************************************************************************************************************************************
task path: /home/b08x/workspace/soundbot/os/roles/workstation/tasks/repos.yml:9
An exception occurred during task execution. To see the full traceback, use -vvv. The error was:   - nothing provides system-release(27) needed by rpmfusion-nonfree-release-27-1.noarch
fatal: [soundbot]: FAILED! => {"changed": false, "module_stderr": "Traceback (most recent call last):\n  File \"/tmp/ansible_rQTXrJ/ansible_module_dnf.py\", line 534, in <module>\n    main()\n  File \"/tmp/ansible_rQTXrJ/ansible_module_dnf.py\", line 530, in main\n    ensure(module, base, params['state'], params['name'], params['autoremove'])\n  File \"/tmp/ansible_rQTXrJ/ansible_module_dnf.py\", line 448, in ensure\n    if not base.resolve(allow_erasing=allow_erasing):\n  File \"/usr/lib/python2.7/site-packages/dnf/base.py\", line 832, in resolve\n    raise exc\ndnf.exceptions.DepsolveError: \n Problem: conflicting requests\n  - nothing provides system-release(27) needed by rpmfusion-nonfree-release-27-1.noarch\n", "module_stdout": "rpmfusion-nonfree-release-27-1.noarch.rpm        24 kB/s |  20 kB     00:00    \n", "msg": "MODULE FAILURE", "rc": 1}

[ ]

TASK [studio : extract tarball] *******************************************************************************************************
task path: /home/b08x/workspace/soundbot/os/roles/studio/tasks/rosegarden.yml:29
 [WARNING]: Consider using the unarchive module rather than running tar.  If you need to use command because unarchive is insufficient
you can add warn=False to this command task or set command_warnings=False in ansible.cfg to get rid of this message.

fatal: [soundbot]: FAILED! => {"changed": true, "cmd": ["tar", "-xf", "rosegarden-17.04.tar.bz2"], "delta": "0:00:01.149980", "end": "2018-09-30 13:10:22.775818", "msg": "non-zero return code", "rc": 2, "start": "2018-09-30 13:10:21.625838", "stderr": "tar: Skipping to next header\n\nbzip2: Data integrity error when decompressing.\n\tInput file = (stdin), output file = (stdout)\n\nIt is possible that the compressed file(s) have become corrupted.\nYou can use the -tvv option to test integrity of such files.\n\nYou can use the `bzip2recover' program to attempt to recover\ndata from undamaged sections of corrupted files.\n\ntar: Child returned status 2\ntar: Error is not recoverable: exiting now", "stderr_lines": ["tar: Skipping to next header", "", "bzip2: Data integrity error when decompressing.", "\tInput file = (stdin), output file = (stdout)", "", "It is possible that the compressed file(s) have become corrupted.", "You can use the -tvv option to test integrity of such files.", "", "You can use the `bzip2recover' program to attempt to recover", "data from undamaged sections of corrupted files.", "", "tar: Child returned status 2", "tar: Error is not recoverable: exiting now"], "stdout": "", "stdout_lines": []}

`
[ ]

TASK [studio : install sonic-pi-tool] *************************************************************************************************
task path: /home/b08x/workspace/soundbot/os/roles/studio/tasks/sonicpi.yml:58
fatal: [soundbot]: FAILED! => {"changed": true, "cmd": ["cargo", "install", "--git", "https://github.com/lpil/sonic-pi-tool/"], "delta": "0:00:00.230243", "end": "2018-09-30 13:14:39.125269", "msg": "non-zero return code", "rc": 101, "start": "2018-09-30 13:14:38.895026", "stderr": "    Updating git repository `https://github.com/lpil/sonic-pi-tool/`\n  Installing sonic-pi-tool v0.1.0 (https://github.com/lpil/sonic-pi-tool/#35e355dd)\nerror: binary `sonic-pi-tool` already exists in destination as part of `sonic-pi-tool v0.1.0 (https://github.com/lpil/sonic-pi-tool/#35e355dd)`\nAdd --force to overwrite", "stderr_lines": ["    Updating git repository `https://github.com/lpil/sonic-pi-tool/`", "  Installing sonic-pi-tool v0.1.0 (https://github.com/lpil/sonic-pi-tool/#35e355dd)", "error: binary `sonic-pi-tool` already exists in destination as part of `sonic-pi-tool v0.1.0 (https://github.com/lpil/sonic-pi-tool/#35e355dd)`", "Add --force to overwrite"], "stdout": "", "stdout_lines": []}

[ ]

TASK [studio : ABC syntax hightlight] *************************************************************************************************
task path: /home/b08x/workspace/soundbot/os/roles/studio/tasks/score.yml:11
fatal: [soundbot]: FAILED! => {"changed": false, "cmd": "apm-beta install ABC-notation", "msg": "[Errno 2] No such file or directory", "rc": 2}
