Return-Path: <33YAmXgkbAHAgmnYOZZSfOddWR.UccUZSigSfQcbhSbh.Qca@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 20 Jan 2020 20:41:01 -0800
In-Reply-To: <000000000000bb0378059c865fdf@google.com>
Message-ID: <000000000000cfbeb5059c9f036d@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_destroy
From: syzbot <syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org, lipeng321@huawei.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tanhuazhong@huawei.com

syzbot has bisected this bug to:

commit 354d0fab649d47045517cf7cae03d653a4dcb3b8
Author: Peng Li <lipeng321@huawei.com>
Date:   Thu Jul 4 14:04:26 2019 +0000

    net: hns3: add default value for tc_size and tc_offset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cc0685e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17cc0685e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc0685e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=8b5f151de2f35100bbc5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e22559e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16056faee00000

Reported-by: syzbot+8b5f151de2f35100bbc5@syzkaller.appspotmail.com
Fixes: 354d0fab649d ("net: hns3: add default value for tc_size and tc_offset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
