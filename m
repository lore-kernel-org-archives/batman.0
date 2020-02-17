Return-Path: <hdanton@sina.com>
From: Hillf Danton <hdanton@sina.com>
Subject: Re: general protection fault in batadv_iv_ogm_schedule_buff
Date: Mon, 17 Feb 2020 19:21:56 +0800
Message-Id: <20200217112156.1428-1-hdanton@sina.com>
In-Reply-To: <000000000000a9f57e059eaf30a6@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+a98f2016f40b9cd3818a@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com


On Sun, 16 Feb 2020 02:49:16 -0800
> syzbot found the following crash on:
> 
> HEAD commit:    2019fc96 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ebaae6e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
> dashboard link: https://syzkaller.appspot.com/bug?extid=a98f2016f40b9cd3818a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a98f2016f40b9cd3818a@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.6.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> RIP: 0010:batadv_iv_ogm_schedule_buff+0x3f4/0x12d0 net/batman-adv/bat_iv_ogm.c:814
> Code: c1 ea 03 80 3c 02 00 0f 85 e5 0d 00 00 4d 8b a7 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 16 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 b8
> RSP: 0018:ffffc90000dd7bb8 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1101537d9c1
> RDX: 0000000000000002 RSI: ffffffff87cc2c28 RDI: 0000000000000016
> RBP: ffffc90000dd7ca8 R08: 0000000000000004 R09: ffff8880a9bece10
> R10: fffffbfff154b460 R11: ffffffff8aa5a307 R12: 0000000000000000
> R13: 0000000000000001 R14: ffffc90000dd7c40 R15: ffff8880a9aa0800
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 000000008f5a3000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:865 [inline]
>  batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:858 [inline]
>  batadv_iv_send_outstanding_bat_ogm_packet+0x5da/0x7c0 net/batman-adv/bat_iv_ogm.c:1718
>  process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -811,6 +811,8 @@ static void batadv_iv_ogm_schedule_buff(
 	}
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
+	if (!batadv_ogm_packet)
+		goto out;
 	batadv_ogm_packet->tvlv_len = htons(tvlv_len);
 
 	/* change sequence number to network order */

