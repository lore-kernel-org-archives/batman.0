Return-Path: <3sDQmXgkbAKkbhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 20 Jan 2020 15:16:00 -0800
In-Reply-To: <000000000000c7999e059c86eebe@google.com>
Message-ID: <000000000000802f87059c9a7984@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ipmac_ext_cleanup
From: syzbot <syzbot+33fc3ad6fa11675e1a7e@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, po-hsu.lin@canonical.com, skhan@linuxfoundation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit ff95bf28c23490584b9d75913a520bb7bb1f2ecb
Author: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon Jul 1 04:40:31 2019 +0000

    selftests/net: skip psock_tpacket test if KALLSYMS was not enabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e2e966e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1412e966e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1012e966e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=33fc3ad6fa11675e1a7e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15982cc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11be38d6e00000

Reported-by: syzbot+33fc3ad6fa11675e1a7e@syzkaller.appspotmail.com
Fixes: ff95bf28c234 ("selftests/net: skip psock_tpacket test if KALLSYMS was not enabled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
