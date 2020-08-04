Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Tue, 04 Aug 2020 06:01:06 -0700
In-Reply-To: <000000000000a7eb5e05abeb197d@google.com>
Message-ID: <0000000000002da68705ac0cd9ab@google.com>
Subject: Re: general protection fault in hci_event_packet
From: syzbot <syzbot+0bef568258653cff272f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, geert@linux-m68k.org, javier@osg.samsung.com, johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, marcel@holtmann.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 941992d2944789641470626e9336d663236b1d28
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Mon Sep 12 14:03:34 2016 +0000

    ethernet: amd: use IS_ENABLED() instead of checking for built-in or module

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155180c2900000
start commit:   bcf87687 Linux 5.8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175180c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=135180c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b489d75d0c8859d
dashboard link: https://syzkaller.appspot.com/bug?extid=0bef568258653cff272f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043af04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ca1dea900000

Reported-by: syzbot+0bef568258653cff272f@syzkaller.appspotmail.com
Fixes: 941992d29447 ("ethernet: amd: use IS_ENABLED() instead of checking for built-in or module")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
