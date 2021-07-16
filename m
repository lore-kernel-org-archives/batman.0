Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Fri, 16 Jul 2021 16:07:06 -0700
In-Reply-To: <00000000000055e16405b0fc1a90@google.com>
Message-ID: <0000000000007cbbcd05c745a560@google.com>
Subject: Re: [syzbot] WARNING in sta_info_alloc
From: syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, anand.jain@oracle.com, b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com, clm@fb.com, davem@davemloft.net, dsterba@suse.com, johannes@sipsolutions.net, josef@toxicpanda.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, will.deacon@arm.com, will@kernel.org, zlim.lnx@gmail.com

syzbot suspects this issue was fixed by commit:

commit 282ab3ff16120ec670fe3330e85f8ebf13092f21
Author: David Sterba <dsterba@suse.com>
Date:   Mon Oct 14 12:38:33 2019 +0000

    btrfs: reduce compressed_bio members' types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d5f6f2300000
start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f385ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1427af9ad00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: reduce compressed_bio members' types

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
