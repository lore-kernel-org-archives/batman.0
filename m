Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2020 21:31:08 -0700
In-Reply-To: <0000000000007b357405b099798f@google.com>
Message-ID: <0000000000000a954d05b0a89a86@google.com>
Subject: Re: WARNING in cfg80211_connect
From: syzbot <syzbot+5f9392825de654244975@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, david@fromorbit.com, dchinner@redhat.com, hch@lst.de, johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 16d4d43595b4780daac8fcea6d042689124cb094
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jul 20 01:38:55 2016 +0000

    xfs: split direct I/O and DAX path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f662b7900000
start commit:   87d5034d Merge tag 'mlx5-updates-2020-09-30' of git://git...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f662b7900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f662b7900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b5cc8ec2218e99d
dashboard link: https://syzkaller.appspot.com/bug?extid=5f9392825de654244975
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100d333900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1414c997900000

Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Fixes: 16d4d43595b4 ("xfs: split direct I/O and DAX path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
