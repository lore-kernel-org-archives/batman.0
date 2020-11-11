MIME-Version: 1.0
References: <0000000000008fddd805adc8c56f@google.com> <000000000000abcd5505b0a06d96@google.com>
In-Reply-To: <000000000000abcd5505b0a06d96@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Nov 2020 12:19:45 +0100
Message-ID: <CACT4Y+bpDs82p-+vV2fki3STcdZaGcrmOqO1qh-agE7couKBHw@mail.gmail.com>
Subject: Re: general protection fault in rt6_fill_node
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com>
Cc: John.Linn@xilinx.com, a@unstable.cc, Anant Thazhemadam <anant.thazhemadam@gmail.com>, Andrii Nakryiko <andriin@fb.com>, anirudh@xilinx.com, Alexei Starovoitov <ast@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>, hancock@sedsystems.ca, John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, michal.simek@xilinx.com, netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Song Liu <songliubraving@fb.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yhs@fb.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

On Thu, Oct 1, 2020 at 8:46 PM syzbot
<syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit eeaac3634ee0e3f35548be35275efeca888e9b23
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Sat Aug 22 12:06:36 2020 +0000
>
>     net: nexthop: don't allow empty NHA_GROUP
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12beed5b900000
> start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=81af6e9b3c4b8bc874f8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ff8539900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f3a96900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: nexthop: don't allow empty NHA_GROUP
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net: nexthop: don't allow empty NHA_GROUP

