Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 21 Jul 2021 19:37:44 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [syzbot] WARNING in sta_info_alloc
Message-ID: <20210721173744.GN19710@twin.jikos.cz>
References: <00000000000055e16405b0fc1a90@google.com>
 <0000000000007cbbcd05c745a560@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007cbbcd05c745a560@google.com>
Reply-To: dsterba@suse.cz, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
Cc: a@unstable.cc, anand.jain@oracle.com, b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com, clm@fb.com, davem@davemloft.net, dsterba@suse.com, johannes@sipsolutions.net, josef@toxicpanda.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, will.deacon@arm.com, will@kernel.org, zlim.lnx@gmail.com

On Fri, Jul 16, 2021 at 04:07:06PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 282ab3ff16120ec670fe3330e85f8ebf13092f21
> Author: David Sterba <dsterba@suse.com>
> Date:   Mon Oct 14 12:38:33 2019 +0000
> 
>     btrfs: reduce compressed_bio members' types
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d5f6f2300000
> start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
> dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f385ad00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1427af9ad00000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: btrfs: reduce compressed_bio members' types
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That's completely unrelated and probably result of unreliable
biscection. There's a different patch referenced in the dashboard

https://groups.google.com/g/syzkaller-lts-bugs/c/ntHpclbYBMM/m/WG3hW1DvAgAJ

  commit 25487a5ff100398cb214ae854358609e4bbd4e7d
  Author: Johannes Berg <johann...@intel.com>
  Date: Mon May 17 14:47:17 2021 +0000

  mac80211: remove warning in ieee80211_get_sband()

that looks more relevant but I don't know if it's the real fix.
