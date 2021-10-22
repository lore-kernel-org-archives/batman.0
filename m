Return-Path: <paskripkin@gmail.com>
Message-ID: <2108d58b-2aca-12f1-59f0-cca5f63098d6@gmail.com>
Date: Fri, 22 Oct 2021 22:36:05 +0300
MIME-Version: 1.0
Subject: Re: [syzbot] WARNING: ODEBUG bug in batadv_nc_mesh_free
Content-Language: en-US
References: <000000000000c0c8d505cef55b23@google.com>
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000c0c8d505cef55b23@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+1dca817d274a3fb19f2b@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

On 10/22/21 21:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e0bfcf9c77d9 Merge tag 'mlx5-fixes-2021-10-20' of git://gi..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=17900a0cb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=1dca817d274a3fb19f2b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144d76b4b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14732b80b00000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14093652b00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16093652b00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12093652b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1dca817d274a3fb19f2b@syzkaller.appspotmail.com
> 
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
> WARNING: CPU: 0 PID: 6548 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Modules linked in:
> CPU: 0 PID: 6548 Comm: syz-executor286 Not tainted 5.15.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
> Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 3e e4 89 4c 89 ee 48 c7 c7 80 32 e4 89 e8 5e 1d 15 05 <0f> 0b 83 05 d5 39 90 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffffc90002d7ecc0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
> RDX: ffff8880163c8000 RSI: ffffffff815e88a8 RDI: fffff520005afd8a
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815e264e R11: 0000000000000000 R12: ffffffff898de560
> R13: ffffffff89e43900 R14: ffffffff81658550 R15: 1ffff920005afda3
> FS:  0000555555c03300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fef3003e098 CR3: 0000000073ad0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   debug_object_assert_init lib/debugobjects.c:895 [inline]
>   debug_object_assert_init+0x1f4/0x2e0 lib/debugobjects.c:866
>   debug_timer_assert_init kernel/time/timer.c:739 [inline]
>   debug_assert_init kernel/time/timer.c:784 [inline]
>   del_timer+0x6d/0x110 kernel/time/timer.c:1204
>   try_to_grab_pending+0x6d/0xd0 kernel/workqueue.c:1270
>   __cancel_work_timer+0xa6/0x570 kernel/workqueue.c:3129
>   batadv_nc_mesh_free+0x41/0x120 net/batman-adv/network-coding.c:1869
>   batadv_mesh_free+0x7d/0x170 net/batman-adv/main.c:245
>   batadv_mesh_init+0x62f/0x710 net/batman-adv/main.c:226

Same fault injection, same backtrace, same warning... Looks like duplicate.

#syz dup: WARNING in batadv_nc_mesh_free


With regards,
Pavel Skripkin
