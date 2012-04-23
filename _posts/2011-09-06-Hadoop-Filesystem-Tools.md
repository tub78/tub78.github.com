---
layout: post
title: Hadoop Filesystem Tools
tags: [CmdLine, Bash, Hadoop, HDFS]
comments: true
analytics: true
TNTitle: Hadoop-Filesystem-Tools
TNTimestamp: 2011-09-08 01:53:45 +0000
TNCreated: 2011-09-08 14:44:08 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: CmdLine, Bash, Hadoop, HDFS
TNMetadata:
---

<pre class="action ideaaction">
>%hdrrelated%
># Related
> * [Hadoop @ Apache](http://hadoop.apache.org/common/docs/r0.21.0/)
> * [HDFS @ Apache](http://hadoop.apache.org/hdfs/docs/current/index.html)
> * [HDFS Shell](http://hadoop.apache.org/common/docs/current/file_system_shell.html)
> * [HadoopEnv](http://code.google.com/p/hadoopenv/)
> * [Rapleaf Dev Blog](http://blog.rapleaf.com/dev/2009/11/17/command-line-auto-completion-for-hadoop-dfs-commands/)
> * [Bash Completion](http://www.caliban.org/bash/#completion)
> * [[Hadoop]]
</pre>

If you're like me, you get frustrated by the amount of typing that is required to copy a file from your Hadoop filesystem to your local filesystem, e.g.:

{% highlight bash %}
hdfs dfs -get hdfs://xxx/very/long/path/to/a/file \
    /yyy/very/long/path/to/a/file
{% endhighlight %}

Also, if you are like me, you want the directory structures of the two filesystems to be mirror-images.  This means you typically have to type a common path component twice, which is redundant, time consuming, and error prone. 

To address this issue (and to exercise my Bash scripting skills), I hacked together a collection of shell scripts that automate this process, together called *HDFS-Tools*.  The *HDFS-Tools* simplify the management of files in your Hadoop Filesystem by helping to synchronize a _local_ copy of the filesystem with *HDFS*.

## How Does It Work?

To enable *HDFS-Tools*, one must first designate a directory to hold the _root_ of the _local_ copy; this is done by setting the `HDFS_PREFIX` environment variable.  Paths relative to `HDFS_PREFIX` in the local copy are the same as in *HDFS*.

Once this is done, copying data between *HDFS* and your _local_ copy is simply a matter of getting or putting a file; e.g.:

{% highlight bash %}
hget <path> 
{% endhighlight %}

*HDFS-Tools* deals with the task of expanding the `path` arguments to create the conventional command format, using the `HDFS_PREFIX` and your *HDFS*'s configuration.  Furthermore, with some code from [rapleaf's dev blog](http://blog.rapleaf.com/dev/2009/11/17/command-line-auto-completion-for-hadoop-dfs-commands/), these commands have been augmented with filename auto-completion. Together, these features make `hget`, `hput`, etc., more convenient than using:

{% highlight bash %}
hdfs dfs -get <hdfs_path> <local_path>
{% endhighlight %}

Say goodbye to the frustration of typing long paths in *HDFS*.  Indeed, you rarely need to type more than the commands themselves.

## Filename Auto-Completion

Auto-completion is available for `hls`, `hget`, and `hput`, by pressing `<TAB>`.  There may be a delay before results are displayed, as the query to the remote *HDFS* is issued.  When the `CWD` is below `HDFS_PREFIX`, filename auto-completion displays paths relative to `CWD`; otherwise, they are relative to `HDFS_PREFIX`.  In the later case, the paths are displayed with a `/` prefix.

Auto-completion for directories is a little clunky because a space character is appended to the result.  In order to extend the path further, you must type `<backspace><TAB>`.

## Details

*HDFS-Tools* consists of the following:

[hpwd](file:///Users/stu/Research/HDFS-Tools/hpwd)
: List corresponding path in *HDFS*.  When the current working directory resides under `HDFS_PREFIX`, the `hpwd` command lists the corresponding location in *HDFS*.  The result has the form: `hdfs://host/path`.  The command `hpwd -r` lists only the `path` component, while `hpwd -p` lists only the `hdfs://host/` component.

[hls](file:///Users/stu/Research/HDFS-Tools/hls)
: List files from *HDFS*.  `hls [path ..]` lists files from *HDFS* that correspond to `path`; e.g. `hdfs://host/[path ..]`.  When the current working directory resides under `HDFS_PREFIX`, the path is relative to it; e.g. `hdfs://host/CWD/[path ..]`.  A recursive directory listing is produced with a `-r` flag.

[hget](file:///Users/stu/Research/HDFS-Tools/hget)
: Retrieve files from *HDFS*.  `hget [path ..]` copies the corresponding files from *HDFS* to the local filesystem.  Directories will not be created unless the `-p` flag is present.  Local files will not be overwritten, unless the `-f` flag is included.

[hput](file:///Users/stu/Research/HDFS-Tools/hput)
: Copy files to *HDFS*.  `hput [path ..]` copies local files to the corresponding locations in *HDFS*.  *HDFS* files will not be overwritten, unless the `-f` flag is included.

[hconnect](file:///Users/stu/Research/HDFS-Tools/hconnect)
: Connect to a remote *HDFS*.  `hconnect` opens or closes an ssh tunnel for communication with remote *HDFS*.

[henv](file:///Users/stu/Research/HDFS-Tools/henv)
: This is a configuration script for *HDFS-Tools* auto-completion.

### Notes

 * Use option `-h` to display help for a command, and `-v` for extra debugging information.
 * When the current working directory is outside of `HDFS_PREFIX`, *HDFS-Tools* behave as though they have been invoked with the current working directory set to `HDFS_PREFIX`.
 * One drawback of *HDFS-Tools* is that filename globbing is not supported, so you can not do things like `hget '[io]*'`.

## Installation & Setup

*HDFS-Tools* are available on [GitHub](https://github.com/tub78/HDFS-Tools).

Note: *HDFS-Tools* are configured for use with Hadoop 0.21.0.

### Bare Minimum

 1. Install these scripts somewhere on your path
 1. `HDFS_PREFIX` - Select the _local_ directory where you wish to mirror *HDFS*
 1. `HADOOP_CONF_DIR` - Select the directory containing the active configuration, in order to lookup information on *HDFS*
 1. Add the following line to your `.bash_profile`
{% highlight bash %}
source <HDFS-TOOLS>/henv
{% endhighlight %}

### For Remote Connections

 1. `HDFS_USER` - Set the user name used to connect to the remote hadoop filesystem
 1. `HDFS_HOST` - Set the host
 1. `HDFS_PORT` - Set the port

`hconnect` opens an ssh tunnel to the remote host using `ssh -ND $HDFS_PORT $HDFS_USER@$HDFS_HOST`



## Examples Part 1

The first set of examples demonstrate the behavior of *HDFS-Tools* with `CWD=HDFS_PREFIX`, where `HDFS_PREFIX=~/Data/Hdfs-2011-08-28`.

### List Files

 * -> `hls`
{% highlight bash %}
Found 3 items
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:50 /Users
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:51 /jobtracker
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:51 /user
{% endhighlight %}


 * -> `hls -v user/stu`
{% highlight bash %}
HDFS_PREFIX=/Users/stu/Data/Hdfs-2011-08-28
HDFS_PWD=
HDFS_URL=/user/stu/input/hdfs-site.xml
Found 2 items
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:45 /user/stu/input
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:51 /user/stu/output
{% endhighlight %}


 * -> `hls -v not/a/valid/file`
{% highlight bash %}
HDFS_PREFIX=/Users/stu/Data/Hdfs-2011-08-28
HDFS_PWD=
HDFS_URL=not/a/valid/file
ls: Cannot access hdfs://localhost:9000//not/a/valid/file: No such file or directory.
{% endhighlight %}


### Get Files

 * -> `hget /user/stu/output`
{% highlight bash %}
hget > Local path already exists /Users/stu/Data/Hdfs-2011-08-28/user/stu/output/
{% endhighlight %}

 * -> `hget -vf /user/stu/output`
{% highlight bash %}
hget > Local path already exists /Users/stu/Data/Hdfs-2011-08-28/user/stu/output/
HDFS_PREFIX=/Users/stu/Data/Hdfs-2011-08-28
HDFS_PWD=
HDFS_URL=user/stu/output/
LOCAL_URL=/Users/stu/Data/Hdfs-2011-08-28/user/stu/output/
LOCAL_DIR=/Users/stu/Data/Hdfs-2011-08-28/user/stu
{% endhighlight %}


### Put Files

 * -> `hput /user/stu/output`
{% highlight bash %}
put: Target hdfs://localhost:9000/user/stu/output is a directory
{% endhighlight %}


 * -> `hput -vf /user/stu/output`
{% highlight bash %}
HDFS_PREFIX=/Users/stu/Data/Hdfs-2011-08-28
HDFS_PWD=
HDFS_URL=user/stu/output
LOCAL_URL=/Users/stu/Data/Hdfs-2011-08-28/user/stu/output
HDFS_DIR=user/stu
{% endhighlight %}


### Tab Completion

 * -> `hls <TAB>`
{% highlight bash %}
Users       jobtracker  user
-> hls *
{% endhighlight %}

 * -> `hget u<TAB>`
{% highlight bash %}
-> hget user/stu *
{% endhighlight %}

 * -> `hput user/stu<TAB>`
{% highlight bash %}
/user/stu/input   /user/stu/output
-> hput /user/stu/ *
{% endhighlight %}

 * -> `hput user/stu/<TAB>`
{% highlight bash %}
/user/stu/input   /user/stu/output
-> hput /user/stu/*
{% endhighlight %}


## Examples Part 2

When the `CWD` is located below `HDFS_PREFIX`, *HDFS-Tools* use relative paths.  For example, with `CWD=$(HDFS_PREFIX)/user/stu`

 * -> `hget <TAB>` 
{% highlight bash %}
input   output
-> hget *
{% endhighlight %}



## Examples Part 3

When the `CWD` is not below `HDFS_PREFIX`, *HDFS-Tools* behave as though they were involked from `HDFS_PREFIX`.  The only difference is that paths on the command line are prefixed with `/`.  In this case, we are using `CWD=~`

 * -> `hls` 
{% highlight bash %}
Found 3 items
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:50 /Users
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:51 /jobtracker
drwxr-xr-x   - stu supergroup          0 2011-09-03 21:51 /user
{% endhighlight %}


 * -> `hls <TAB>` 
{% highlight bash %}
/Users       /jobtracker  /user
-> hls /*
{% endhighlight %}


 * -> `hput /use<TAB>` 
{% highlight bash %}
-> hput /user/ *
{% endhighlight %}


 * -> `hget /user/stu/input` 
{% highlight bash %}
hget > Local path already exists /Users/stu/Data/Hdfs-2011-08-28/user/stu/input
{% endhighlight %}


## Examples Part 4

 * -> `hconnect -c`
{% highlight bash %}
ENABLED:  0
RUNNING PROCESS: 
{% endhighlight %}

 * -> `hconnect -t`
{% highlight bash %}
ENABLED:  0
PID:
  ssh -ND 2600 user@email.com
Started HDFS tunnel with PID: '7647'
{% endhighlight %}

 * -> `hconnect -c`
{% highlight bash %}
ENABLED:  1
RUNNING PROCESS:  7647 ssh -ND 2600 user@email.com
{% endhighlight %}

 * -> `hconnect`
{% highlight bash %}
ENABLED:  1
PID:  7647
Stopping HDFS tunnel with PID: '7647'
kill -9 7647
{% endhighlight %}





