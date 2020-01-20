Return-Path: <3yO8lXgkbADclrsdTeeXkTiibW.ZhhZeXnlXkVhgmXgm.Vhf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 20 Jan 2020 10:22:00 -0800
In-Reply-To: <00000000000043aa29059c91459e@google.com>
Message-ID: <000000000000149402059c965e75@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_gc
From: syzbot <syzbot+c1a1fb435465986efe35@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de, gregkh@linuxfoundation.org, info@metux.net, jeremy@azazel.net, kadlec@netfilter.org, kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org, lipeng321@huawei.com, liuyonglong@huawei.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, salil.mehta@huawei.com, sbrivio@redhat.com, shuliubin@huawei.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yisen.zhuang@huawei.com

syzbot has bisected this bug to:

commit 0d581ba311a27762fe1a14e5db5f65d225b3d844
Author: Yonglong Liu <liuyonglong@huawei.com>
Date:   Wed Jul 3 11:12:30 2019 +0000

    net: hns: add support for vlan TSO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d5dfaee00000
start commit:   def9d278 Linux 5.5-rc7
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15d5dfaee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d5dfaee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf8e288883e40aba
dashboard link: https://syzkaller.appspot.com/bug?extid=c1a1fb435465986efe35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ac495e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153471d1e00000

Reported-by: syzbot+c1a1fb435465986efe35@syzkaller.appspotmail.com
Fixes: 0d581ba311a2 ("net: hns: add support for vlan TSO")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
