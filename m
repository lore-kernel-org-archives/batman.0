Return-Path: <3zsFtXgkbAAMv12ndoohudsslg.jrrjohxvhufrqwhqw.frp@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 14 Mar 2020 22:49:02 -0700
In-Reply-To: <000000000000e0ab4c059c79f014@google.com>
Message-ID: <00000000000080d06405a0de4277@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_port_ext_cleanup
From: syzbot <syzbot+7b6206fb525c1f5ec3f8@syzkaller.appspotmail.com>
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
To: a@unstable.cc, andrew@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, grygorii.strashko@ti.com, j-keerthy@ti.com, jeremy@azazel.net, johannes.berg@intel.com, kadlec@blackhole.kfki.hu, kadlec@netfilter.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D122e7c1de000=
00
start commit:   d5d359b0 Merge branch 'for-linus' of git://git.kernel.org/.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcf8e288883e40ab=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7b6206fb525c1f5ec=
3f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15909f21e0000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a1611e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
