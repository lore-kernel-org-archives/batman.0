Return-Path: <kadlec@blackhole.kfki.hu>
Date: Wed, 19 Feb 2020 07:50:33 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_destroy
In-Reply-To: <0000000000000d774c059ee442e6@google.com>
Message-ID: <alpine.DEB.2.20.2002190746590.20111@blackhole.kfki.hu>
References: <0000000000000d774c059ee442e6@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="110363376-950394365-1582095033=:20111"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, David Miller <davem@davemloft.net>, florent.fourcot@wifirst.fr, Florian Westphal <fw@strlen.de>, jeremy@azazel.net, johannes.berg@intel.com, linux-kernel@vger.kernel.org, lipeng321@huawei.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tanhuazhong@huawei.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--110363376-950394365-1582095033=:20111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


#syz fix: netfilter: ipset: use bitmap infrastructure completely

On Tue, 18 Feb 2020, syzbot wrote:

> syzbot suspects this bug was fixed by commit:
>=20
> commit 32c72165dbd0e246e69d16a3ad348a4851afd415
> Author: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
> Date:   Sun Jan 19 21:06:49 2020 +0000
>=20
>     netfilter: ipset: use bitmap infrastructure completely
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17fc79b5e0=
0000
> start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.k=
e..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcfbb8fa33f49f=
9f3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8b5f151de2f3510=
0bbc5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12e22559e00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16056faee0000=
0
>=20
> If the result looks correct, please mark the bug fixed by replying with:
>=20
> #syz fix: netfilter: ipset: use bitmap infrastructure completely
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>=20

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
--110363376-950394365-1582095033=:20111--
