Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Sat, 03 Oct 2020 05:45:07 -0700
In-Reply-To: <000000000000fa10d905b0b1eb89@google.com>
Message-ID: <00000000000080daf705b0c39e95@google.com>
Subject: Re: WARNING in drv_bss_info_changed
From: syzbot <syzbot+4cf3e4e092f2f4120a52@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, g.nault@alphalink.fr, johannes@sipsolutions.net, ktkhai@virtuozzo.com, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 489b30b53f0540b9f8e391cbb2839cea48b5d1c1
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Thu Mar 15 09:10:57 2018 +0000

    net: Convert l2tp_net_ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175b598f900000
start commit:   fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14db598f900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10db598f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=4cf3e4e092f2f4120a52
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145eb667900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15422c1f900000

Reported-by: syzbot+4cf3e4e092f2f4120a52@syzkaller.appspotmail.com
Fixes: 489b30b53f05 ("net: Convert l2tp_net_ops")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
