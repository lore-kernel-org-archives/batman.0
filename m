Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Mon, 18 May 2020 05:28:05 -0700
In-Reply-To: <000000000000ada39605a5e71711@google.com>
Message-ID: <00000000000071203205a5eb4b43@google.com>
Subject: Re: BUG: Bad rss-counter state (4)
From: syzbot <syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, akpm@linux-foundation.org, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dvyukov@google.com, jbacik@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mareklindner@neomailbox.ch, mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, songliubraving@fb.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com

syzbot has bisected this bug to:

commit 0d8dd67be013727ae57645ecd3ea2c36365d7da8
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 22:45:14 2017 +0000

    perf/headers: Sync new perf_event.h with the tools/include/uapi version

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13240a02100000
start commit:   ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a40a02100000
console output: https://syzkaller.appspot.com/x/log.txt?x=17240a02100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=347e2331d03d06ab0224
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d18e6e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104170d6100000

Reported-by: syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com
Fixes: 0d8dd67be013 ("perf/headers: Sync new perf_event.h with the tools/include/uapi version")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
