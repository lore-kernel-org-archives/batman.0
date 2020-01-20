Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 20 Jan 2020 20:46:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_ext_cleanup
Message-ID: <20200120174615.GE21151@kadam>
References: <000000000000bdb5b2059c865f5c@google.com>
 <000000000000c795fa059c884c21@google.com>
 <20200120131930.pbhbsrm4bk4lq3d7@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200120131930.pbhbsrm4bk4lq3d7@wittgenstein>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: syzbot <syzbot+6491ea8f6dddbf04930e@syzkaller.appspotmail.com>, a@unstable.cc, akpm@linux-foundation.org, allison@lohutok.net, arnd@arndb.de, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, bp@alien8.de, catalin.marinas@arm.com, chris@zankel.net, christian@brauner.io, coreteam@netfilter.org, davem@davemloft.net, elena.reshetova@intel.com, florent.fourcot@wifirst.fr, fw@strlen.de, geert@linux-m68k.org, hare@suse.com, heiko.carstens@de.ibm.com, hpa@zytor.com, info@metux.net, jcmvbkbc@gmail.com, jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux@armlinux.org.uk, mareklindner@neomailbox.ch, mingo@redhat.com, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, peterz@infradead.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, will@kernel.org, x86@kernel.org

On Mon, Jan 20, 2020 at 02:19:31PM +0100, Christian Brauner wrote:
> On Sun, Jan 19, 2020 at 05:35:01PM -0800, syzbot wrote:
> > syzbot has bisected this bug to:
> >=20
> > commit d68dbb0c9ac8b1ff52eb09aa58ce6358400fa939
> > Author: Christian Brauner <christian@brauner.io>
> > Date:   Thu Jun 20 23:26:35 2019 +0000
> >=20
> >     arch: handle arches who do not yet define clone3
> >=20
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1456fed1=
e00000
> > start commit:   09d4f10a net: sched: act_ctinfo: fix memory leak
> > git tree:       net
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D1656fed1=
e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1256fed1e00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7e89bd00623=
fe71e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D6491ea8f6dddb=
f04930e
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D141af959e=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1067fa85e00=
000
> >=20
> > Reported-by: syzbot+6491ea8f6dddbf04930e@syzkaller.appspotmail.com
> > Fixes: d68dbb0c9ac8 ("arch: handle arches who do not yet define clone3")
> >=20
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>=20
> This bisect seems bogus.
>=20

Yeah.  J=F3zsef Kadlecsik already fixed the bug in a different thread.  It
was reported as seven different bugs so there was a bunch of threads for
it.

regards,
dan carpenter
