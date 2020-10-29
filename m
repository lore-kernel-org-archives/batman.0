Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Thu, 29 Oct 2020 16:49:05 -0700
In-Reply-To: <000000000000bd1edd05b087535a@google.com>
Message-ID: <000000000000e0a53705b2d7ec44@google.com>
Subject: Re: INFO: rcu detected stall in security_file_open (3)
From: syzbot <syzbot+d2b6e8cc299748fecf25@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dhowells@redhat.com, fweisbec@gmail.com, ktkhai@virtuozzo.com, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, miklos@szeredi.hu, mingo@kernel.org, mszeredi@redhat.com, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bc220a500000
start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=d2b6e8cc299748fecf25
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1249c717900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1048d9e3900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
