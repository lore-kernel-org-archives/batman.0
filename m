Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2020 11:46:04 -0700
In-Reply-To: <0000000000008fddd805adc8c56f@google.com>
Message-ID: <000000000000abcd5505b0a06d96@google.com>
Subject: Re: general protection fault in rt6_fill_node
From: syzbot <syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: John.Linn@xilinx.com, a@unstable.cc, anant.thazhemadam@gmail.com, andriin@fb.com, anirudh@xilinx.com, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com, hancock@sedsystems.ca, john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, michal.simek@xilinx.com, netdev@vger.kernel.org, nikolay@cumulusnetworks.com, songliubraving@fb.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com, yoshfuji@linux-ipv6.org

syzbot suspects this issue was fixed by commit:

commit eeaac3634ee0e3f35548be35275efeca888e9b23
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Sat Aug 22 12:06:36 2020 +0000

    net: nexthop: don't allow empty NHA_GROUP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12beed5b900000
start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=81af6e9b3c4b8bc874f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ff8539900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f3a96900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: nexthop: don't allow empty NHA_GROUP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
