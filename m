Return-Path: 
  <3RFUaXwkbAFcHNO9zAA3GzEE72.5DD5A3JH3G1DCI3CI.1DB@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Thu, 23 Jul 2020 20:28:04 -0700
In-Reply-To: <0000000000000a8e8605a22a1ae0@google.com>
Message-ID: <00000000000091792505ab278f0a@google.com>
Subject: Re: INFO: rcu detected stall in netlink_sendmsg (4)
From: syzbot <syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vinicius.gomes@intel.com, xiyou.wangcong@gmail.com

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d46e1b100000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d46e1b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=0fb70e87d8e0ac278fe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1023588f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1647a88f100000

Reported-by: syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
