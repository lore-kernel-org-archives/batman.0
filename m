Return-Path: <3_R6XXAkbAIIy45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 23 Mar 2019 23:09:01 -0700
In-Reply-To: <000000000000bc9ddf057e577c98@google.com>
Message-ID: <0000000000009c14c60584d0ec76@google.com>
From: syzbot <syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [B.A.T.M.A.N.] WARNING: ODEBUG bug in netdev_freemem
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, alexander.h.duyck@intel.com, amritha.nambiar@intel.com, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, decot@googlers.com, digetx@gmail.com, dmitry.torokhov@gmail.com, jeffrey.t.kirsher@intel.com, joe@perches.com, jonathanh@nvidia.com, ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, pdeschrijver@nvidia.com, petrm@mellanox.com, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, thierry.reding@gmail.com, treding@nvidia.com, tyhicks@canonical.com, xiyou.wangcong@gmail.com

syzbot has bisected this bug to:

commit 96e5da7c842424bcf64afe1082b960b42b96190b
Author: Dmitry Osipenko <digetx@gmail.com>
Date:   Sun Oct 21 18:30:52 2018 +0000

     memory: tegra: Introduce Tegra20 EMC driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14450b93200000
start commit:   28e8c4bc Merge tag 'rtc-4.21' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16450b93200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12450b93200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=979ffc89b87309b1b94b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a93c4b400000

Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com
Fixes: 96e5da7c8424 ("memory: tegra: Introduce Tegra20 EMC driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
