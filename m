Return-Path: <3LLokXgkbACsZfgRHSSLYHWWPK.NVVNSLbZLYJVUaLUa.JVT@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 19 Jan 2020 12:21:00 -0800
In-Reply-To: <0000000000006d7b1e059c7db653@google.com>
Message-ID: <000000000000cbfd34059c83e917@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_ext_cleanup
From: syzbot <syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, nikolay@cumulusnetworks.com, pablo@netfilter.org, roopa@cumulusnetworks.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 3d26eb8ad1e9b906433903ce05f775cf038e747f
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Tue Jul 2 12:00:20 2019 +0000

    net: bridge: don't cache ether dest pointer on input

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bb1cc9e00000
start commit:   9aaa2949 Merge branch '1GbE' of git://git.kernel.org/pub/s..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=147b1cc9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=107b1cc9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66d8660c57ff3c98
dashboard link: https://syzkaller.appspot.com/bug?extid=b554d01b6c7870b17da2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15db12a5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15316faee00000

Reported-by: syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com
Fixes: 3d26eb8ad1e9 ("net: bridge: don't cache ether dest pointer on input")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
