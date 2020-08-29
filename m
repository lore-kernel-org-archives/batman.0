Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
Date: Sat, 29 Aug 2020 11:23:07 -0700
In-Reply-To: <000000000000d3d67f05a20d2027@google.com>
Message-ID: <000000000000d8002705ae084273@google.com>
Subject: Re: INFO: task hung in tls_sk_proto_close
From: syzbot <syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: a@unstable.cc, aviadye@mellanox.com, aviadye@nvidia.com, b.a.t.m.a.n@lists.open-mesh.org, borisp@mellanox.com, borisp@nvidia.com, daniel@iogearbox.net, davem@davemloft.net, idosch@mellanox.com, john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, petrm@mellanox.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

syzbot has bisected this issue to:

commit 02d21b59d5cc4b4b395bbc2a29319b8a529ebeff
Author: Ido Schimmel <idosch@mellanox.com>
Date:   Wed Jan 23 14:32:59 2019 +0000

    mlxsw: spectrum_nve: Enable VXLAN on Spectrum-2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e89b05900000
start commit:   5438dd45 net_sched: fix error path in red_init()
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e89b05900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e89b05900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=ca1345cca66556f3d79b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14acdfe5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1792598e900000

Reported-by: syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com
Fixes: 02d21b59d5cc ("mlxsw: spectrum_nve: Enable VXLAN on Spectrum-2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
