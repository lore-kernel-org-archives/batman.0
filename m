Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 6 Oct 2020 09:16:00 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: WARNING in sta_info_alloc
Message-ID: <20201006081559.GA25187@willie-the-truck>
References: <00000000000055e16405b0fc1a90@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000055e16405b0fc1a90@google.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com, davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, will.deacon@arm.com, zlim.lnx@gmail.com

On Tue, Oct 06, 2020 at 01:08:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    549738f1 Linux 5.9-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b97ba3900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
> dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bae9c0500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099b1c0500000
> 
> The issue was bisected to:
> 
> commit 643c332d519bdfbf80d21f40d1c0aa0ccf3ec1cb
> Author: Zi Shen Lim <zlim.lnx@gmail.com>
> Date:   Thu Jun 9 04:18:50 2016 +0000
> 
>     arm64: bpf: optimize LD_ABS, LD_IND
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d44477900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d44477900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d44477900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com
> Fixes: 643c332d519b ("arm64: bpf: optimize LD_ABS, LD_IND")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6879 at net/mac80211/ieee80211_i.h:1447 ieee80211_get_sband net/mac80211/ieee80211_i.h:1447 [inline]
> WARNING: CPU: 0 PID: 6879 at net/mac80211/ieee80211_i.h:1447 sta_info_alloc+0x1900/0x1f90 net/mac80211/sta_info.c:469
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 6879 Comm: syz-executor071 Not tainted 5.9.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x382/0x7fb kernel/panic.c:231
>  __warn.cold+0x20/0x4b kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:ieee80211_get_sband net/mac80211/ieee80211_i.h:1447 [inline]

The patch fingered by the bisection only affects arm64, but this is an x86
box. So this is clearly bogus.

Will
