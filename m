Return-Path: <3ISrfXQkbAOYaghSITTMZIXXQL.OWWOTMcaMZKWVbMVb.KWU@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 27 Nov 2019 18:00:01 -0800
In-Reply-To: <00000000000038b5c205983c2df4@google.com>
Message-ID: <0000000000009aa32205985e78b6@google.com>
Subject: Re: WARNING in mark_lock (3)
From: syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, wang.yi59@zte.com.cn, xiyou.wangcong@gmail.com

syzbot has bisected this bug to:

commit d665c1281bc89ac85b8b0c058c22a3f94640a1d6
Author: Yi Wang <wang.yi59@zte.com.cn>
Date:   Mon Oct 21 23:57:42 2019 +0000

     net: sched: taprio: fix -Wmissing-prototypes warnings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132ee536e00000
start commit:   89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10aee536e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=172ee536e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595c15c951695d1b
dashboard link: https://syzkaller.appspot.com/bug?extid=a229d8d995b74f8c4b6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511af5ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e0f17ae00000

Reported-by: syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com
Fixes: d665c1281bc8 ("net: sched: taprio: fix -Wmissing-prototypes  
warnings")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
