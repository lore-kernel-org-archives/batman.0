MIME-Version: 1.0
References: <000000000000f5964705b7d47d8c@google.com>
 <000000000000dc091705d203eac6@google.com>
In-Reply-To: <000000000000dc091705d203eac6@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 4 Dec 2021 10:32:00 +0100
Message-ID: 
 <CACT4Y+bN9OX1t4v80n5OPN68fySSVWxx0FKOsTHRTff9Xuokng@mail.gmail.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in
 l2cap_sock_teardown_cb
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bobo.shaobowang@huawei.com, davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Tue, 30 Nov 2021 at 17:19, syzbot
<syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
> Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Date:   Wed Sep 1 00:35:37 2021 +0000
>
>     Bluetooth: fix use-after-free error in lock_sock_nested()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134c881eb00000
> start commit:   73b7a6047971 net: dsa: bcm_sf2: support BCM4908's integrat..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

A use-after-free can lead to other random consequences, and there
actually was a KASAN report after the lockdep report in the original
report. So w/o a better candidate let's do:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()

