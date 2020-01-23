Return-Path: <3ihwqXgkbAGMTZaLBMMFSBQQJE.HPPHMFVTFSDPOUFOU.DPN@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Thu, 23 Jan 2020 14:22:02 -0800
In-Reply-To: <000000000000da7a79059caf2656@google.com>
Message-ID: <00000000000001df94059cd612b2@google.com>
Subject: Re: WARNING in __proc_create (2)
From: syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>
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
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, dan.carpenter@oracle.com, davem@davemloft.net, dhowells@redhat.com, info@drgreenstore.com, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit f4b3526d83c40dd8bf5948b9d7a1b2c340f0dcc8
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 2 15:27:48 2017 +0000

    afs: Connect up the CB.ProbeUuid

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627a721e00000
start commit:   d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527a721e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1127a721e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=b904ba7c947a37b4b291
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c96185e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f859c9e00000

Reported-by: syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com
Fixes: f4b3526d83c4 ("afs: Connect up the CB.ProbeUuid")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
