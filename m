Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
References: <000000000000ccde8d059564d93d@google.com>
 <2128256.8pjUZaGXEE@bentobox>
In-Reply-To: <2128256.8pjUZaGXEE@bentobox>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 21 Oct 2019 08:54:21 +0200
Message-ID: <CACT4Y+b1Fkky4JZUTFpUe0jaUVpo7N59T5XTahjzkmig83Dd6A@mail.gmail.com>
Subject: Re: general protection fault in batadv_iv_ogm_queue_add
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: syzbot <syzbot+7dd2da51d8ae6f990403@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>

On Mon, Oct 21, 2019 at 8:33 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 21 October 2019 07:21:06 CEST syzbot wrote:
> [...]
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7dd2da51d8ae6f990403@syzkaller.appspotmail.com
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 4256 Comm: kworker/u4:0 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> > RIP: 0010:batadv_iv_ogm_queue_add+0x49/0x1120
> > net/batman-adv/bat_iv_ogm.c:605
> > Code: 48 89 75 b8 48 89 4d c0 4c 89 45 b0 44 89 4d d0 e8 fc 02 46 fa 48 8d
> > 7b 03 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48
> > 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 18 0d 00 00
> > RSP: 0018:ffff88805d2cfb80 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888092284000
> > RDX: 0000000000000000 RSI: ffffffff872d1214 RDI: 0000000000000003
> > RBP: ffff88805d2cfc18 R08: ffff888092284000 R09: 0000000000000001
> > R10: ffffed100ba59f77 R11: 0000000000000003 R12: dffffc0000000000
> > R13: ffffed101245080e R14: ffff888092284000 R15: 0000000100051cf6
> > FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000200002c0 CR3: 00000000a421b000 CR4: 00000000001426f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   batadv_iv_ogm_schedule+0xb0b/0xe50 net/batman-adv/bat_iv_ogm.c:813
> >   batadv_iv_send_outstanding_bat_ogm_packet+0x580/0x760
> > net/batman-adv/bat_iv_ogm.c:1675
>
> I am guessing that the fix for this is queued up since a while at
>  https://git.open-mesh.org/linux-merge.git/commit/40e220b4218bb3d278e5e8cc04ccdfd1c7ff8307
>
> Kind regards,
>         Sven

Hi Sven,

It was fixed based on another syzbot report, let's tell syzbot that
this is a dup of that other report than:

#syz dup: KASAN: use-after-free Read in batadv_iv_ogm_queue_add
