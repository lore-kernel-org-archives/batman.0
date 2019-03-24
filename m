Return-Path: <3JTOXXAkbANIGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 24 Mar 2019 00:35:01 -0700
In-Reply-To: <000000000000fa4f60057e499989@google.com>
Message-ID: <0000000000002c5a7f0584d220fa@google.com>
From: syzbot <syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [B.A.T.M.A.N.] WARNING in batadv_mcast_mla_tt_retract
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, alexander.h.duyck@intel.com, amritha.nambiar@intel.com, avagin@gmail.com, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, heiko@sntech.de, jeffrey.t.kirsher@intel.com, joe@perches.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org, robh+dt@kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tyhicks@canonical.com

syzbot has bisected this bug to:

commit 2ed30cfcf866f657349bf9f54a017a957cd98378
Author: Heiko Stuebner <heiko@sntech.de>
Date:   Thu Aug 2 11:36:41 2018 +0000

     arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177e9917200000
start commit:   4b3c31c8 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14fe9917200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe9917200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=83f2d54ec6b7e417e13f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139c6408c00000

Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com
Fixes: 2ed30cfcf866 ("arm64: dts: rockchip: enable dwc2-based otg  
controller on px30-evb")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
