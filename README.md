# NOTE:
This readme, and most likely a lot of the work in this repo were probably borrowed from the awesome work that `docent-net/fedora-desktop-ansible` did.

# oh-my-fedora24

This is my provisioner for the Fedora 24 Gnome3 / Wayland
generic desktop. Feel free to use it, modify, contribute etc.
Always interested in your comments - write me!

This repository has submodule dependency. All Ansible roles are placed in **roles** directory
which is a git submodule.

### Usage: ###

1. Clone this repo
1. Edit **group_vars/all.yml**
1. Install prerequisites on destination box: `dnf -y install ansible sudo python-dnf libselinux-python`
1. Create entry for your user in **/etc/sudoers.d/user**
1. Enter proper **ansible_ssh_host** and **ansible_ssh_user** in **hosts** file
1. Make sure it works: `ansible -m ping <your_host>`
1. Rollout: `ansible-playbook playbook.yml`

Of course you may install just a specified part of the
whole installation by using tags. List available tags
with:

`$ ansible-playbook playbook.yml --list-tags`

 And install specified part with:

`$ ansible-playbook playbook.yml --tags dropbox,virtualbox`

If you want to only update packages (like `dnf update -y` simply run:

`$ ansible-playbook playbook.yml --tags pkgs,update --skip-tags install`

### Contributing / committing changes ###

1. In order to modify those roles a bit to match your needs simply fork and work on your forked repo
1. If you feel like your change should be added to thise repo - create Pull Request (thanks btw!)

### Managing multiple desktops ###

I use this repository in order to manage 5+ laptops. There are two methods to achieve this
multi - desktop configuration:

1. First is to keep every workstation configuration in different branch. This way every workstation
   has its own **playbook.yml** and **hosts** file. Downside is the need for keeping branches in sync
   (which is a basic merge so it's not a rocket science).
1. Second is to keep every workstation provisioner in different playbook (e.g. in **plays** directory).
   In this scenario you keep all hosts configuration in one **hosts** file.

Malcolm Jones
@bossjones



https://github.com/geerlingguy/ansible-role-solr/issues/64


# Known Problems

## ansible

https://github.com/geerlingguy/ansible-role-solr/issues/64
https://github.com/ansible/ansible/issues/23358

```
TASK [ksylvan.docker : fedora_repo] ********************************************
ok: [hyena_org] => {
    "msg": {
        "age": "215",
        "changed": false,
        "connection": "close",
        "content": "<!DOCTYPE html>\n<html>\n<head><title>Index of /repo/main/fedora/</title></head>\n<body bgcolor=\"white\">\n<h1>Index of /repo/main/fedora/</h1><hr>\n<pre><a href=\"../\">../</a>\n<a href=\"20\">20/</a>                                         01-Dec-2016 19:36  -\n<a href=\"21\">21/</a>                                         01-Dec-2016 19:36  -\n<a href=\"22\">22/</a>                                         01-Dec-2016 19:36  -\n<a href=\"23\">23/</a>                                         10-Jan-2017 23:53  -\n<a href=\"24\">24/</a>                                         05-Apr-2017 23:12  -\n<a href=\"25\">25/</a>                                         05-Apr-2017 23:12  -\n</pre><hr></body></html>\n",
        "content_length": "687",
        "content_type": "text/html",
        "date": "Thu, 06 Apr 2017 01:34:13 GMT",
        "etag": "\"8cb7fa660761d3b6a8a824f2bf396dc0\"",
        "last_modified": "Thu, 06 Apr 2017 00:39:19 GMT",
        "msg": "OK (687 bytes)",
        "redirected": false,
        "server": "AmazonS3",
        "status": 200,
        "url": "https://yum.dockerproject.org/repo/main/fedora/",
        "via": "1.1 9aaf336897fdd8a2dfd1b375c61d8b0b.cloudfront.net (CloudFront)",
        "x_amz_cf_id": "B9bF3GbU36hAYJhtIDXoQGXu9EiYcUUSXEWDDzyxMPzEakpPchZELw==",
        "x_amz_meta_s3cmd_attrs": "uid:0/gname:root/uname:root/gid:0/mode:33261/mtime:1491434020/atime:1491434299/md5:8cb7fa660761d3b6a8a824f2bf396dc0/ctime:1491434020",
        "x_amz_version_id": "hCdPIsuNZF5gW6GfubBq2gcvxNtxCAkw",
        "x_cache": "Hit from cloudfront"
    }
}

TASK [ksylvan.docker : ansible_distribution_version] ***************************
ok: [hyena_org] => {
    "msg": "24"
}

TASK [ksylvan.docker : Look for the exact version] *****************************
fatal: [hyena_org]: FAILED! => {"failed": true, "msg": "The conditional check '>{{ansible_distribution_version}}/< in {{fedora_repo.content}}' failed. The error was: Invalid conditional detected: invalid syntax (<unknown>, line 1)\n\nThe error appears to have been in '/Users/malcolm/dev/bossjones/oh-my-fedora24/roles/ksylvan.docker/tasks/main.yml': line 27, column 3, but may\nbe elsewhere in the file depending on the exact syntax problem.\n\nThe offending line appears to be:\n\n\n- name: Look for the exact version\n  ^ here\n"}
        to retry, use: --limit @/Users/malcolm/dev/bossjones/oh-my-fedora24/playbook.retry

PLAY RECAP *********************************************************************
hyena_org                  : ok=13   changed=0    unreachable=0    failed=1

Ansible failed to complete successfully. Any error output should be
visible above. Please fix these errors and try again.

```
