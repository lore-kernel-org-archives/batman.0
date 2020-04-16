Return-Path: <3l6KXXgkbADYkqrcSddWjShhaV.YggYdWmkWjUgflWfl.Uge@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 15 Apr 2020 17:11:03 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
Message-ID: <000000000000ba8e5605a35d4465@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From: syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com, hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, longman@redhat.com, mareklindner@neomailbox.ch, mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tj@kernel.org, ulf.hansson@linaro.org

syzbot suspects this bug was fixed by commit:

commit 810507fe6fd5ff3de429121adff49523fabb643a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Feb 6 15:24:08 2020 +0000

    locking/lockdep: Reuse freed chain_hlocks entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1008138be00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
