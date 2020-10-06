Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2020 01:08:23 -0700
Message-ID: <00000000000055e16405b0fc1a90@google.com>
Subject: WARNING in sta_info_alloc
From: syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com, davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, will.deacon@arm.com, zlim.lnx@gmail.com

Hello,

syzbot found the following issue on:

HEAD commit:    549738f1 Linux 5.9-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b97ba3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bae9c0500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099b1c0500000

The issue was bisected to:

commit 643c332d519bdfbf80d21f40d1c0aa0ccf3ec1cb
Author: Zi Shen Lim <zlim.lnx@gmail.com>
Date:   Thu Jun 9 04:18:50 2016 +0000

    arm64: bpf: optimize LD_ABS, LD_IND

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d44477900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d44477900000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d44477900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com
Fixes: 643c332d519b ("arm64: bpf: optimize LD_ABS, LD_IND")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6879 at net/mac80211/ieee80211_i.h:1447 ieee80211_get_sband net/mac80211/ieee80211_i.h:1447 [inline]
WARNING: CPU: 0 PID: 6879 at net/mac80211/ieee80211_i.h:1447 sta_info_alloc+0x1900/0x1f90 net/mac80211/sta_info.c:469
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6879 Comm: syz-executor071 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:ieee80211_get_sband net/mac80211/ieee80211_i.h:1447 [inline]
RIP: 0010:sta_info_alloc+0x1900/0x1f90 net/mac80211/sta_info.c:469
Code: 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f0 04 00 00 49 8b 9f 60 01 00 00 e9 fc f6 ff ff e8 80 20 b6 f9 <0f> 0b e8 e9 62 66 00 31 ff 89 c3 89 c6 e8 ce 1c b6 f9 85 db 74 1d
RSP: 0018:ffffc9000539f498 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff87c01d61
RDX: ffff8880a91ec3c0 RSI: ffffffff87c01e10 RDI: 0000000000000005
RBP: ffff8880896e0c80 R08: 0000000000000001 R09: ffffffff8d0c29e7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880896e31b0 R14: dffffc0000000000 R15: ffff888092f06000
 ieee80211_add_station+0x28c/0x660 net/mac80211/cfg.c:1586
 rdev_add_station net/wireless/rdev-ops.h:190 [inline]
 nl80211_new_station+0xde7/0x1440 net/wireless/nl80211.c:6294
 genl_family_rcv_msg_doit net/netlink/genetlink.c:669 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:714 [inline]
 genl_rcv_msg+0x61d/0x980 net/netlink/genetlink.c:731
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:742
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441999
Code: e8 dc 05 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd9fa54bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441999
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 000000306e616c77 R08: 0000000000000000 R09: 0000002000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 000000000000000c R15: 0000000000000004
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
