Return-Path: <3QhJtXgkbABUDJK5v66zCvAA3y.19916zFDzCx98Ez8E.x97@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 14 Mar 2020 10:20:02 -0700
In-Reply-To: <000000000000cdbe79059ce82948@google.com>
Message-ID: <000000000000dccd2405a0d3cb04@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_destroy
From: syzbot <syzbot+a85062dec5d65617cc1c@syzkaller.appspotmail.com>
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
To: a@unstable.cc, arvid.brodin@alten.se, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net, johannes.berg@intel.com, kadlec@blackhole.kfki.hu, kadlec@netfilter.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10aef753e000=
00
start commit:   4703d911 Merge tag 'xarray-5.5' of git://git.infradead.org.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D83c00afca9cf515=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da85062dec5d65617c=
c1c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1301ed85e0000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14b7b79ee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
