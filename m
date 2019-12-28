Return-Path: <3-RoHXgkbAEIw23oeppivettmh.ksskpiywivgsrxirx.gsq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 28 Dec 2019 01:06:01 -0800
In-Reply-To: <0000000000004718ff059abd88ef@google.com>
Message-ID: <0000000000005c669c059abfebe7@google.com>
Subject: Re: general protection fault in nf_ct_netns_do_get
From: syzbot <syzbot+19616eedf6fd8e241e50@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de, hpa@zytor.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org, linux@roeck-us.net, mareklindner@neomailbox.ch, mingo@redhat.com, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org

syzbot has bisected this bug to:

commit 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Wed Aug 15 20:22:27 2018 +0000

     x86: i8259: Add missing include file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1579e751e00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1779e751e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1379e751e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=19616eedf6fd8e241e50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a47ab9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f2485e00000

Reported-by: syzbot+19616eedf6fd8e241e50@syzkaller.appspotmail.com
Fixes: 0a957467c5fd ("x86: i8259: Add missing include file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
