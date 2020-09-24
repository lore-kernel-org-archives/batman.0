Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2020 02:26:26 -0700
Message-ID: <000000000000578a4f05b00bcb4b@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in bpf_trace_run5
From: syzbot <syzbot+856297c51366950e115e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, andriin@fb.com, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mareklindner@neomailbox.ch, mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org, shli@fb.com, shli@kernel.org, songliubraving@fb.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com

Hello,

syzbot found the following issue on:

HEAD commit:    b10b8ad8 Add linux-next specific files for 20200921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1371eb1d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
dashboard link: https://syzkaller.appspot.com/bug?extid=856297c51366950e115e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1510d3d9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1328ecbb900000

The issue was bisected to:

commit 1e6d690b9334b7e1b31d25fd8d93e980e449a5f9
Author: Song Liu <songliubraving@fb.com>
Date:   Thu Nov 17 23:24:39 2016 +0000

    md/r5cache: caching phase of r5cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109283d9900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=129283d9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=149283d9900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+856297c51366950e115e@syzkaller.appspotmail.com
Fixes: 1e6d690b9334 ("md/r5cache: caching phase of r5cache")

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __bpf_trace_run kernel/trace/bpf_trace.c:1937 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bpf_trace_run5+0x401/0x410 kernel/trace/bpf_trace.c:1977
Read of size 8 at addr ffffc90000e80030 by task rs:main Q:Reg/6567

CPU: 1 PID: 6567 Comm: rs:main Q:Reg Not tainted 5.9.0-rc5-next-20200921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __bpf_trace_run kernel/trace/bpf_trace.c:1937 [inline]
 bpf_trace_run5+0x401/0x410 kernel/trace/bpf_trace.c:1977
 __bpf_trace_ext4_journal_start+0x142/0x180 include/trace/events/ext4.h:1788
 __traceiter_ext4_journal_start+0x83/0xd0 include/trace/events/ext4.h:1788
 trace_ext4_journal_start include/trace/events/ext4.h:1788 [inline]
 __ext4_journal_start_sb+0x228/0x440 fs/ext4/ext4_jbd2.c:96
 __ext4_journal_start fs/ext4/ext4_jbd2.h:328 [inline]
 ext4_dirty_inode+0xbc/0x130 fs/ext4/inode.c:5850
 __mark_inode_dirty+0x888/0x1190 fs/fs-writeback.c:2260
 generic_update_time+0x21c/0x370 fs/inode.c:1764
 update_time fs/inode.c:1777 [inline]
 file_update_time+0x434/0x520 fs/inode.c:1992
 file_modified fs/inode.c:2015 [inline]
 file_modified+0x7d/0xa0 fs/inode.c:2000
 ext4_write_checks fs/ext4/file.c:248 [inline]
 ext4_buffered_write_iter+0xf9/0x4a0 fs/ext4/file.c:264
 ext4_file_write_iter+0x1f3/0x13e0 fs/ext4/file.c:660
 call_write_iter include/linux/fs.h:1895 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:517
 vfs_write+0x57d/0x700 fs/read_write.c:595
 ksys_write+0x12d/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fed08e3a1cd
Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fed063f5590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fecfc0238a0 RCX: 00007fed08e3a1cd
RDX: 0000000000000dd6 RSI: 00007fecfc0238a0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fecfc023620
R13: 00007fed063f55b0 R14: 0000560a2b025360 R15: 0000000000000dd6


Memory state around the buggy address:
 ffffc90000e7ff00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e7ff80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000e80000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                     ^
 ffffc90000e80080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e80100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
