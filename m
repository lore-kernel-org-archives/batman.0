MIME-Version: 1.0
References: <00000000000073afff05bbe9a54d@google.com> <00000000000020564605bedb716e@google.com>
 <20210401133037.GA1052133@rowland.harvard.edu>
In-Reply-To: <20210401133037.GA1052133@rowland.harvard.edu>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 13 Apr 2021 10:32:50 +0200
Message-ID: <CACT4Y+ZMFwTLrdK+8YZifJR_7V21gwOxbVKnbRP3Yj=YQ+k7xQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ieee802154_del_seclevel
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com>, a@unstable.cc, alex.aring@gmail.com, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, info@sophiescuban.com, Jiri Kosina <jkosina@suse.cz>, Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-wpan@vger.kernel.org, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, stefan@datenfreihafen.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>

On Thu, Apr 1, 2021 at 3:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Mar 31, 2021 at 02:03:08PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 416dacb819f59180e4d86a5550052033ebb6d72c
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Wed Aug 21 17:27:12 2019 +0000
> >
> >     HID: hidraw: Fix invalid read in hidraw_ioctl
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000
> > start commit:   6e5a03bc ethernet/netronome/nfp: Fix a use after free in n..
> > git tree:       net
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117430fcd00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167430fcd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fbf4fc11a819824e027b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfe45ed00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e31ad00000
> >
> > Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com
> > Fixes: 416dacb819f5 ("HID: hidraw: Fix invalid read in hidraw_ioctl")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> It seems likely that the bisection ran off the rails here.  This commit
> could not have caused a problem, although it may have revealed a
> pre-existing problem that previously was hidden.

Hi Alan,

Yes, bisection log shows it was derailed by:
KASAN: use-after-free Read in batadv_iv_ogm_queue_add
and:
BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000


> By the way, what happened to the annotated stack dumps that syzkaller
> used to provide in its bug reports?

Nothing has changed in this respect, they are still in bug reports:
https://lore.kernel.org/lkml/00000000000073afff05bbe9a54d@google.com/

