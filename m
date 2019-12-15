Return-Path: <35Iv1XQkbAMc5BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 14 Dec 2019 17:27:00 -0800
In-Reply-To: <000000000000c71dcf0579b0553f@google.com>
Message-ID: <000000000000dcc9b10599b3fd5e@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From: syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
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
To: a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com, b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au, davem@davemloft.net, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tytso@mit.edu

syzbot has bisected this bug to:

commit 8835cae5f2abd7f7a3143afe357f416aff5517a4
Author: Chris Lapa <chris@lapa.com.au>
Date:   Wed Jan 11 01:44:47 2017 +0000

     power: supply: bq27xxx: adds specific support for bq27520-g4 revision.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16661f41e00000
start commit:   ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15661f41e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11661f41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec1332e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163455dee00000

Reported-by: syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com
Fixes: 8835cae5f2ab ("power: supply: bq27xxx: adds specific support for  
bq27520-g4 revision.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
