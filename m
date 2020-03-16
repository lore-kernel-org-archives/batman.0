Return-Path: <3vnVvXgkbAGERXYJ9KKDQ9OOHC.FNNFKDTRDQBNMSDMS.BNL@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 16 Mar 2020 05:49:02 -0700
In-Reply-To: <00000000000043aa29059c91459e@google.com>
Message-ID: <00000000000066871f05a0f83e9d@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_gc
From: syzbot <syzbot+c1a1fb435465986efe35@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, allison@lohutok.net, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de, gregkh@linuxfoundation.org, info@metux.net, jeremy@azazel.net, kadlec@blackhole.kfki.hu, kadlec@netfilter.org, kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org, lipeng321@huawei.com, liuyonglong@huawei.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, salil.mehta@huawei.com, sbrivio@redhat.com, shuliubin@huawei.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yisen.zhuang@huawei.com

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1074c2a9e000=
00
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcf8e288883e40ab=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc1a1fb435465986ef=
e35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14e36185e0000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D104a7a11e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
