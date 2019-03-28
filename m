Return-Path: <3uVydXAkbANIGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Thu, 28 Mar 2019 16:46:01 -0700
In-Reply-To: <000000000000ea60e6058529d77b@google.com>
Message-ID: <0000000000001a141505853028fd@google.com>
From: syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [B.A.T.M.A.N.] kernel BUG at
 drivers/android/binder_alloc.c:LINE! (3)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, arve@android.com, b.a.t.m.a.n@lists.open-mesh.org, christian@brauner.io, davem@davemloft.net, devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, joel@joelfernandes.org, linux-kernel@vger.kernel.org, maco@android.com, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tkjos@android.com, tkjos@google.com

syzbot has bisected this bug to:

commit 1a7c3d9bb7a926e88d5f57643e75ad1abfc55013
Author: Todd Kjos <tkjos@android.com>
Date:   Fri Feb 8 18:35:14 2019 +0000

     binder: create userspace-to-binder-buffer copy function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b9383f200000
start commit:   1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17b9383f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9383f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f3f388440283da2965
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d05637200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1677e62f200000

Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
Fixes: 1a7c3d9bb7a9 ("binder: create userspace-to-binder-buffer copy  
function")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
