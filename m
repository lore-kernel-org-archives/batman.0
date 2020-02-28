Return-Path: <paul@paul-moore.com>
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com>
 <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com>
 <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
 <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
In-Reply-To: <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2020 19:14:15 -0500
Message-ID: <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Paris <eparis@redhat.com>, syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, Dan Carpenter <dan.carpenter@oracle.com>, David Miller <davem@davemloft.net>, fzago@cray.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, john.hammond@intel.com, linux-audit@redhat.com, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, syzkaller <syzkaller@googlegroups.com>

On Thu, Feb 27, 2020 at 10:40 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Feb 24, 2020 at 11:47 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Feb 24, 2020 at 5:43 PM Eric Paris <eparis@redhat.com> wrote:
> > > https://syzkaller.appspot.com/x/repro.syz?x=151b1109e00000 (the
> > > reproducer listed) looks like it is literally fuzzing the AUDIT_SET.
> > > Which seems like this is working as designed if it is setting the
> > > failure mode to 2.
> >
> > So it is, good catch :)  I saw the panic and instinctively chalked
> > that up to a mistaken config, not expecting that it was what was being
> > tested.
>
> Yes, this audit failure mode is quite unpleasant for fuzzing. And
> since this is not a top-level syscall argument value, it's effectively
> impossible to filter out in the fuzzer. Maybe another use case for the
> "fuzer lockdown" feature +Tetsuo proposed.
> With the current state of the things, I think we only have an option
> to disable fuzzing of audit. Which is pity because it has found 5 or
> so real bugs in audit too.
> But this happened anyway because audit is only reachable from init pid
> namespace and syzkaller always unshares pid namespace for sandboxing
> reasons, that was removed accidentally and that's how it managed to
> find the bugs. But the unshare is restored now:
> https://github.com/google/syzkaller/commit/5e0e1d1450d7c3497338082fc28912fdd7f93a3c
>
> As a side effect all other real bugs in audit will be auto-obsoleted
> in future if not fixed because they will stop happening.

On the plus side, I did submit fixes for the other real audit bugs
that syzbot found recently and Linus pulled them into the tree today
so at least we have that small victory.

We could consider adding a fuzz-friendly build time config which would
disable the panic failsafe, but it probably isn't worth it at the
moment considering the syzbot's pid namespace limitations.

-- 
paul moore
www.paul-moore.com
