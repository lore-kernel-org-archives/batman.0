MIME-Version: 1.0
References: <0000000000009383f505adc8c5a0@google.com> <0000000000000b380805b09dbf40@google.com>
In-Reply-To: <0000000000000b380805b09dbf40@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Nov 2020 12:19:09 +0100
Message-ID: <CACT4Y+ZM6kjJjaiocArfb2EEhJKqqA3=S2Y_7GeTx2SXz-xVAQ@mail.gmail.com>
Subject: Re: general protection fault in nexthop_is_blackhole
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com>
Cc: a@unstable.cc, Anant Thazhemadam <anant.thazhemadam@gmail.com>, Andrii Nakryiko <andriin@fb.com>, anmol.karan123@gmail.com, Alexei Starovoitov <ast@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>, hariprasad.kelam@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>, John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Song Liu <songliubraving@fb.com>, Steffen Klassert <steffen.klassert@secunet.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yhs@fb.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

On Thu, Oct 1, 2020 at 5:34 PM syzbot
<syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit eeaac3634ee0e3f35548be35275efeca888e9b23
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Sat Aug 22 12:06:36 2020 +0000
>
>     net: nexthop: don't allow empty NHA_GROUP
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116177a7900000
> start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2c08a2f5cfef635cc3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d75e39900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aea519900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: nexthop: don't allow empty NHA_GROUP
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


#syz fix: net: nexthop: don't allow empty NHA_GROUP

