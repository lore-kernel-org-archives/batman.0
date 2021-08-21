Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 20 Aug 2021 23:43:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in
 ext4_write_inline_data_end
Message-ID: <YSB2dsveNTr9G3Mq@mit.edu>
References: <000000000000e5080305c9e51453@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e5080305c9e51453@google.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+13146364637c7363a7de@syzkaller.appspotmail.com>
Cc: a@unstable.cc, adilger.kernel@dilger.ca, arnd@arndb.de, b.a.t.m.a.n@lists.open-mesh.org, christian@brauner.io, davem@davemloft.net, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Thu, Aug 19, 2021 at 01:10:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614cb2751d31 Merge tag 'trace-v5.14-rc6' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130112c5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
> dashboard link: https://syzkaller.appspot.com/bug?extid=13146364637c7363a7de
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104d7cc5300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1333ce0e300000
> 
> The issue was bisected to:
> 
> commit a154d5d83d21af6b9ee32adc5dbcea5ac1fb534c
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Mon Mar 4 20:38:03 2019 +0000
> 
>     net: ignore sysctl_devconf_inherit_init_net without SYSCTL
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f970b6300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=100570b6300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f970b6300000

In case it wasn't obvious, this is a bogus bisection.  It's a bug
ext4's inline_data support where there is a race between writing to an
inline_data file against setting extended attributes on that same
inline_data file.

Fix is coming up....

					- Ted
