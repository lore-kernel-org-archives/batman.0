Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Wed, 31 Mar 2021 14:03:08 -0700
In-Reply-To: <00000000000073afff05bbe9a54d@google.com>
Message-ID: <00000000000020564605bedb716e@google.com>
Subject: Re: [syzbot] WARNING in ieee802154_del_seclevel
From: syzbot <syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, alex.aring@gmail.com, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, info@sophiescuban.com, jkosina@suse.cz, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, stefan@datenfreihafen.org, stern@rowland.harvard.edu, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 416dacb819f59180e4d86a5550052033ebb6d72c
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Aug 21 17:27:12 2019 +0000

    HID: hidraw: Fix invalid read in hidraw_ioctl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000
start commit:   6e5a03bc ethernet/netronome/nfp: Fix a use after free in n..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117430fcd00000
console output: https://syzkaller.appspot.com/x/log.txt?x=167430fcd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf4fc11a819824e027b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfe45ed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e31ad00000

Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com
Fixes: 416dacb819f5 ("HID: hidraw: Fix invalid read in hidraw_ioctl")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
