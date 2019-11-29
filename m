Return-Path: <3sWDgXQkbAOgcijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Thu, 28 Nov 2019 16:05:05 -0800
Message-ID: <000000000000723a32059870fbd4@google.com>
Subject: general protection fault in smack_socket_sendmsg (2)
From: syzbot <syzbot+131d2229316b7012ac06@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, andrew@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, casey@schaufler-ca.com, davem@davemloft.net, f.fainelli@gmail.com, jmorris@namei.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, serge@hallyn.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, vivien.didelot@savoirfairelinux.com

Hello,

syzbot found the following crash on:

HEAD commit:    0be0ee71 vfs: properly and reliably lock f_pos in fdget_po..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c49ef2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=330a1f54d1edb817
dashboard link: https://syzkaller.appspot.com/bug?extid=131d2229316b7012ac06
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb67cee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12460136e00000

The bug was bisected to:

commit 8ae5bcdc5d98a99e59f194101e7acd2e9d055758
Author: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date:   Fri May 19 21:00:54 2017 +0000

     net: dsa: add MDB notifier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ec2f5ae00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=141c2f5ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=101c2f5ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+131d2229316b7012ac06@syzkaller.appspotmail.com
Fixes: 8ae5bcdc5d98 ("net: dsa: add MDB notifier")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7989 Comm: kworker/1:4 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
RIP: 0010:smack_socket_sendmsg+0x5b/0x480 security/smack/smack_lsm.c:3675
Code: e8 fa 03 6b fe 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 ef e8  
74 46 a4 fe 4d 8b 65 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00  
74 08 48 89 df e8 56 46 a4 fe 4c 8b 33 49 8d 9e 08
RSP: 0018:ffff88808a58f9c8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff8880a1270280
RDX: 0000000000000000 RSI: ffff88808a58fb18 RDI: 0000000000000000
RBP: ffff88808a58fa80 R08: ffffffff83442500 R09: ffff88808a58fb86
R10: ffffed10114b1f72 R11: 0000000000000000 R12: ffff8880a124c114
R13: ffff88808a58fb18 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe2d48c9e78 CR3: 0000000098a23000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  security_socket_sendmsg+0x6c/0xd0 security/security.c:2013
  sock_sendmsg net/socket.c:655 [inline]
  kernel_sendmsg+0x77/0x140 net/socket.c:678
  rxrpc_send_keepalive+0x254/0x3c0 net/rxrpc/output.c:655
  rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:376 [inline]
  rxrpc_peer_keepalive_worker+0x76e/0xb40 net/rxrpc/peer_event.c:437
  process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
  worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 8b748724da7e3b28 ]---
RIP: 0010:smack_socket_sendmsg+0x5b/0x480 security/smack/smack_lsm.c:3675
Code: e8 fa 03 6b fe 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 ef e8  
74 46 a4 fe 4d 8b 65 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00  
74 08 48 89 df e8 56 46 a4 fe 4c 8b 33 49 8d 9e 08
RSP: 0018:ffff88808a58f9c8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff8880a1270280
RDX: 0000000000000000 RSI: ffff88808a58fb18 RDI: 0000000000000000
RBP: ffff88808a58fa80 R08: ffffffff83442500 R09: ffff88808a58fb86
R10: ffffed10114b1f72 R11: 0000000000000000 R12: ffff8880a124c114
R13: ffff88808a58fb18 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe2d48c9e78 CR3: 0000000098a23000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
