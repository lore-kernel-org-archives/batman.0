Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2020 22:53:05 -0700
In-Reply-To: <0000000000003d6e8405abeb1da7@google.com>
Message-ID: <00000000000070529b05ac06deaa@google.com>
Subject: Re: KASAN: use-after-free Read in hci_send_acl
From: syzbot <syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org, mareklindner@neomailbox.ch, michael.chan@broadcom.com, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 4ffcd582301bd020b1f9d00c55473af305ec19b5
Author: Michael Chan <michael.chan@broadcom.com>
Date:   Mon Sep 19 07:58:07 2016 +0000

    bnxt_en: Pad TX packets below 52 bytes.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167b0f04900000
start commit:   ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157b0f04900000
console output: https://syzkaller.appspot.com/x/log.txt?x=117b0f04900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=98228e7407314d2d4ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f1904900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1482dfca900000

Reported-by: syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com
Fixes: 4ffcd582301b ("bnxt_en: Pad TX packets below 52 bytes.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
