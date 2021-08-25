Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Thu, 26 Aug 2021 07:45:34 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [syzbot] INFO: task hung in __xfs_buf_submit (2)
Message-ID: <20210825214534.GM3657114@dread.disaster.area>
References: <0000000000002fc21105ca657edf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002fc21105ca657edf@google.com>
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
To: syzbot <syzbot+4bb1622c9a583bb6f9f2@syzkaller.appspotmail.com>
Cc: a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, djwong@kernel.org, josef@toxicpanda.com, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, mareklindner@neomailbox.ch, mchristi@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Wed, Aug 25, 2021 at 10:22:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6e764bcd1cf7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10504885300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
> dashboard link: https://syzkaller.appspot.com/bug?extid=4bb1622c9a583bb6f9f2
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14427606300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149b3cce300000
> 
> The issue was bisected to:
> 
> commit 887e975c4172d0d5670c39ead2f18ba1e4ec8133
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Tue Aug 13 16:39:51 2019 +0000
> 
>     nbd: add missing config put
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11980ad5300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13980ad5300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15980ad5300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4bb1622c9a583bb6f9f2@syzkaller.appspotmail.com
> Fixes: 887e975c4172 ("nbd: add missing config put")

XFS is waiting on IO completion to be signalled from the block
device, and the bisect points to commit fixing a problem with a
block device processing IO timeout errors.

IOWs, the above commit is probably exposing a latent bug in the
commit that changes all the error handling in nbd to fix completion
races in IO completion. The commit message for 8f3ea35929a0 ("nbd:
handle unexpected replies better") also makes mention of races with
timeout errors, and the above commit is touching the timeout error
handling.

Josef, this one looks like it is yours...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
