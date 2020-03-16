Return-Path: <3A-duXgkbAIY289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 15 Mar 2020 19:40:03 -0700
In-Reply-To: <000000000000bdb5b2059c865f5c@google.com>
Message-ID: <0000000000007c695f05a0efbc52@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_ext_cleanup
From: syzbot <syzbot+6491ea8f6dddbf04930e@syzkaller.appspotmail.com>
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
To: a@unstable.cc, akpm@linux-foundation.org, allison@lohutok.net, arnd@arndb.de, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, bp@alien8.de, catalin.marinas@arm.com, chris@zankel.net, christian.brauner@ubuntu.com, christian@brauner.io, coreteam@netfilter.org, dan.carpenter@oracle.com, davem@davemloft.net, elena.reshetova@intel.com, florent.fourcot@wifirst.fr, fw@strlen.de, geert@linux-m68k.org, hare@suse.com, heiko.carstens@de.ibm.com, hpa@zytor.com, info@drgreenstore.com, info@metux.net, jcmvbkbc@gmail.com, jeremy@azazel.net, johannes.berg@intel.com, kadlec@blackhole.kfki.hu, kadlec@netfilter.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux@armlinux.org.uk, mareklindner@neomailbox.ch, mingo@redhat.com, netdev@vger.kernel.org, netfilter-core-owner@lists.netfilter.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, peterz@infradead.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, will@kernel.org, x86@kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16b8e545e000=
00
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcf8e288883e40ab=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3D6491ea8f6dddbf049=
30e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D126748d6e0000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1385f959e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
