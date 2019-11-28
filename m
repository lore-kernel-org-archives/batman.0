Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
References: <0000000000009aa32205985e78b6@google.com>
 <2825703.dkhYCMB3mh@sven-edge>
 <CACT4Y+YwNGWCXBazm+7GHpSw-gXsxmA8NA-o7O7Mpj3d-dhGYA@mail.gmail.com>
 <1809369.KjlzdqruN6@sven-edge>
In-Reply-To: <1809369.KjlzdqruN6@sven-edge>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 28 Nov 2019 09:54:15 +0100
Message-ID: <CACT4Y+abQSWfiN16BwXFOBi+d3CFGk53oj+5+zZwQPbcYu-Rew@mail.gmail.com>
Subject: Re: WARNING in mark_lock (3)
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
Cc: syzkaller <syzkaller@googlegroups.com>, syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jamal Hadi Salim <jhs@mojatatu.com>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, vinicius.gomes@intel.com, wang.yi59@zte.com.cn, Cong Wang <xiyou.wangcong@gmail.com>

On Thu, Nov 28, 2019 at 9:46 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Thursday, 28 November 2019 09:40:32 CET Dmitry Vyukov wrote:
> > On Thu, Nov 28, 2019 at 8:25 AM Sven Eckelmann <sven@narfation.org> wrote:
> > >
> > > On Thursday, 28 November 2019 03:00:01 CET syzbot wrote:
> > > [...]
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132ee536e00000
> > > > start commit:   89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
> > > > git tree:       upstream
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=10aee536e00000
> > >
> > > Can the syzbot infrastructure be told to ignore this crash in the bisect run?
> > > Because this should be an unrelated crash which is (hopefully) fixed in
> > > 40e220b4218b ("batman-adv: Avoid free/alloc race when handling OGM buffer").
> >
> > +syzkaller mailing list for syzbot discussion
> >
> > Hi Sven,
> >
> > There is no such functionality at the moment.
> > What exactly do you mean? Somehow telling it interactively? Or
> > hardcode some set of crashes for linux? I don't see how any of these
> > options can really work...
>
> I was thinking more about rerunning the same bisect but tell it to assume
> "crashed: general protection fault in batadv_iv_ogm_queue_add" as OK instead
> of assuming that it is a crashed like the previous "crashed: WARNING in
> mark_lock". Just to get a non-bogus bisect result. Or try to rerun the
> bisect between 40e220b4218b and 89d57dddd7d319ded00415790a0bb3c954b7e386

But... but this done by a program. What do you mean by "tell it"?
