Return-Path: 
  <3SFg0YAkbANEFLM7x881ExCC50.3BB381HF1EzBAG1AG.zB9@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Mon, 22 Feb 2021 17:20:08 -0800
In-Reply-To: <0000000000007f199405baa1ffc4@google.com>
Message-ID: <00000000000013b2eb05bbf6b8ce@google.com>
Subject: Re: WARNING in init_timer_key
From: syzbot <syzbot+105896fac213f26056f9@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, gerrit@erg.abdn.ac.uk, hkallweit1@gmail.com, johannes.berg@intel.com, johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit b9df4fd7e99cb8bfd80c4143f3045d63b1754ad0
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sun Oct 6 16:19:54 2019 +0000

    net: core: change return type of pskb_may_pull to bool

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b4545cd00000
start commit:   1048ba83 Linux 5.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b4545cd00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4545cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ae5569643a9955f
dashboard link: https://syzkaller.appspot.com/bug?extid=105896fac213f26056f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f0e564d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147075e8d00000

Reported-by: syzbot+105896fac213f26056f9@syzkaller.appspotmail.com
Fixes: b9df4fd7e99c ("net: core: change return type of pskb_may_pull to bool")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
