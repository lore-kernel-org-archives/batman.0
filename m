Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2020 08:34:05 -0700
In-Reply-To: <0000000000009383f505adc8c5a0@google.com>
Message-ID: <0000000000000b380805b09dbf40@google.com>
Subject: Re: general protection fault in nexthop_is_blackhole
From: syzbot <syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, anant.thazhemadam@gmail.com, andriin@fb.com, anmol.karan123@gmail.com, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com, hariprasad.kelam@gmail.com, herbert@gondor.apana.org.au, john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, nikolay@cumulusnetworks.com, songliubraving@fb.com, steffen.klassert@secunet.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com, yoshfuji@linux-ipv6.org

syzbot suspects this issue was fixed by commit:

commit eeaac3634ee0e3f35548be35275efeca888e9b23
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Sat Aug 22 12:06:36 2020 +0000

    net: nexthop: don't allow empty NHA_GROUP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116177a7900000
start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c08a2f5cfef635cc3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d75e39900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aea519900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: nexthop: don't allow empty NHA_GROUP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
