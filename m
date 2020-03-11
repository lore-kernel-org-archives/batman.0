Return-Path: <3P0dpXgkbAGwcijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 11 Mar 2020 13:17:03 -0700
In-Reply-To: <00000000000030395e059f6aaa09@google.com>
Message-ID: <00000000000064f9a805a099eb8a@google.com>
Subject: Re: general protection fault in j1939_netdev_start
From: syzbot <syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, jiri@mellanox.com, jiri@resnulli.us, kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, mareklindner@neomailbox.ch, mkl@pengutronix.de, netdev@vger.kernel.org, robin@protonic.nl, socketcan@hartkopp.net, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 8330f73fe9742f201f467639f8356cf58756fb9f
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Wed Sep 4 07:40:47 2019 +0000

    rocker: add missing init_net check in FIB notifier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cdcb1e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=155cdcb1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=115cdcb1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=f03d384f3455d28833eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162b8331e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f10a2de00000

Reported-by: syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com
Fixes: 8330f73fe974 ("rocker: add missing init_net check in FIB notifier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
