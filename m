Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Mon, 09 Nov 2020 03:03:05 -0800
In-Reply-To: <000000000000a48f9e05aef6cce1@google.com>
Message-ID: <000000000000b4227e05b3aa8101@google.com>
Subject: Re: INFO: rcu detected stall in exit_group
From: syzbot <syzbot+1a14a0f8ce1a06d4415f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dhowells@redhat.com, fweisbec@gmail.com, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mareklindner@neomailbox.ch, mike.kravetz@oracle.com, mingo@kernel.org, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b65c3a500000
start commit:   34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=1a14a0f8ce1a06d4415f
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c6642d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132d00fd900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
