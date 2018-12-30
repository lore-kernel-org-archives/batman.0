Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
References: <000000000000d89413057e3aeec2@google.com>
 <3100603.HWLWhOUWpG@sven-edge>
In-Reply-To: <3100603.HWLWhOUWpG@sven-edge>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 30 Dec 2018 12:08:53 +0100
Message-ID: <CACT4Y+Yb+OvJ8c4Vot9pcTEF1OhTHeu=XK5Jb=EXEBv6xmNwnQ@mail.gmail.com>
Subject: Re: WARNING in batadv_is_on_batman_iface
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: syzbot <syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>

On Sun, Dec 30, 2018 at 12:00 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Sunday, 30 December 2018 11.41.03 CET syzbot wrote:
> [...]
> > HEAD commit:    d8924c0d76aa Merge tag 'devprop-4.21-rc1' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=122a373f400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c764de0fcfadca9a8595
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd1d67400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com
>
> What is the bug here? The kernel module showed a warning because the parent
> device cannot be found in the same netns using __dev_get_by_index.
>
> The test system was just configured to panic on warnings. So are we now
> expected to show warnings or what is the expected behavior?
>
> This behavior was added with commit b7eddd0b3950 ("batman-adv: prevent using
> any virtual device created on batman-adv as hard-interface") - 3d48811b27f5 in
> the out-of-tree module.

Hi Sven,

The problem is that kernel code uses WARNING when it should not.
For WARN guidelines please see this:
https://elixir.bootlin.com/linux/v4.20/source/include/asm-generic/bug.h#L81
and this (search for WARN_ON_ONCE):
https://lwn.net/Articles/769365/


> Kind regards,
>         Sven
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7eddd0b3950ea9dc863f1cbfa30d172dbf772f4
