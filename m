Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Sun, 10 Jan 2021 21:16:06 -0800
In-Reply-To: <000000000000f5964705b7d47d8c@google.com>
Message-ID: <000000000000cbca0705b89900b3@google.com>
Subject: Re: INFO: trying to register non-static key in l2cap_sock_teardown_cb
From: syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 4680a7ee5db27772af40d83393fa0fb955b745b7
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat Oct 1 05:32:33 2016 +0000

    fuse: remove duplicate cs->offset assignment

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc80e7500000
start commit:   73b7a604 net: dsa: bcm_sf2: support BCM4908's integrated s..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fc80e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc80e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000

Reported-by: syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com
Fixes: 4680a7ee5db2 ("fuse: remove duplicate cs->offset assignment")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
