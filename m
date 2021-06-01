Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Mon, 31 May 2021 22:00:10 -0700
In-Reply-To: <000000000000f32b3c05958ed0eb@google.com>
Message-ID: <0000000000006bd5ff05c3ad37da@google.com>
Subject: Re: [syzbot] INFO: task hung in register_netdevice_notifier (2)
From: syzbot <syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, brouer@redhat.com, daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com, john.fastabend@gmail.com, kafai@fb.com, kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, songliubraving@fb.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org, yhs@fb.com

syzbot has bisected this issue to:

commit 6bf071bf09d4b2ff3ee8783531e2ce814f0870cb
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue Jun 18 13:05:27 2019 +0000

    xdp: page_pool related fix to cpumap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1397c4a7d00000
start commit:   7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1057c4a7d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1797c4a7d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=355f8edb2ff45d5f95fa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cc630fd00000

Reported-by: syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com
Fixes: 6bf071bf09d4 ("xdp: page_pool related fix to cpumap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
