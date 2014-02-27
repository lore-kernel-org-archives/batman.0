Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Feb 2014 14:12:15 +0100
References: <1770254702.309936059.1393503657979.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1770254702.309936059.1393503657979.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402271412.15916.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Question about batman adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

> Hello,
> 1) I can't creat the 2 files:
>  cat /sys/kernel/debug/batman_adv/bat0/log
> echo 2 > /sys/class/net/bat0/mesh/log_level
> 
> then when i write this line, i have the result:
> sudo batctl log
> Error - can't open file '/sys/kernel/debug//batman_adv/bat0/log': No such
> file or directory To read the debug log you need to compile the module
> with debugging enabled (see the README)
> 
> WWW@ubuntu:~$ sudo batctl ll
> Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such file
> or directory To increase the log level you need to compile the module with
> debugging enabled (see the README)
> 
> How can i compile it ?

Read the README, it's documented there.

> 
> 2) The MTU = 1528 is not need to be set on the computer ?

No, batman-adv can also fragment the packets for you. But it's a good idea to 
set this MTU value to the hard interface used by batman-adv.
> 
> 3) How can i lauch batman-adv in debug mode to see all node ?

There is no such thing as debug mode. Compile batman-adv with debug turned on 
(either set CONFIG_BATMAN_ADV_DEBUG=y in the Makefile if you compile the module 
externally or select debug in "make menuconfig" when using the module from the 
in-kernel tree).

You can "see" other nodes e.g. by using "batctl o", which will print the local 
originator table.

The quick-start guide might also point you to a view interesting things:

http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide

Cheers,
     Simon
