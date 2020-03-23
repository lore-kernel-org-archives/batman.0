Return-Path: <3Hmd4XgkbAMc5BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 23 Mar 2020 00:37:02 -0700
In-Reply-To: <000000000000e9e518059fd84189@google.com>
Message-ID: <0000000000007ab36905a180b328@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_bind (2)
From: syzbot <syzbot+04e804c8c2224b6a9497@syzkaller.appspotmail.com>
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
To: a@unstable.cc, andrew@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, f.fainelli@gmail.com, johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 7d13eca09ed5e477f6ecfd97a35058762228b5e4
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Sat Aug 27 22:34:20 2016 +0000

    Documentation: networking: dsa: Remove platform device TODO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1746f3f9e00000
start commit:   770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14c6f3f9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6f3f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=04e804c8c2224b6a9497
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fc5e75e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10707013e00000

Reported-by: syzbot+04e804c8c2224b6a9497@syzkaller.appspotmail.com
Fixes: 7d13eca09ed5 ("Documentation: networking: dsa: Remove platform device TODO")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
