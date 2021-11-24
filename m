Return-Path: 
  <3cnmeYQkbAPElrsdTeeXkTiibW.ZhhZeXnlXkVhgmXgm.Vhf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 24 Nov 2021 09:42:10 -0800
In-Reply-To: <000000000000ba80b905cdcd8b19@google.com>
Message-ID: <0000000000009f52f205d18c60a7@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in batadv_v_ogm_free
From: syzbot <syzbot+0ef06384b5f39a16ebb9@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jason@zx2c4.com, a@unstable.cc, amcohen@nvidia.com, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, idosch@OSS.NVIDIA.COM, justin.iurman@uliege.be, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, paskripkin@gmail.com, praveen5582@gmail.com, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, willemb@google.com, yoshfuji@linux-ipv6.org, zxu@linkedin.com

syzbot suspects this issue was fixed by commit:

commit 6f68cd634856f8ca93bafd623ba5357e0f648c68
Author: Pavel Skripkin <paskripkin@gmail.com>
Date:   Sun Oct 24 13:13:56 2021 +0000

    net: batman-adv: fix error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114e3c16b00000
start commit:   cf52ad5ff16c Merge tag 'driver-core-5.15-rc6' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9479508d7bb83ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=0ef06384b5f39a16ebb9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17af7344b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dc02fb300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: batman-adv: fix error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
