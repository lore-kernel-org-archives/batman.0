Return-Path: <netdev-owner@kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Oct 2022 10:34:23 -0700
In-Reply-To: <0000000000009d327505b0999237@google.com>
Message-ID: <00000000000013612005eb2a4525@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in batadv_nc_worker (3)
From: syzbot <syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
To: a@unstable.cc, alsa-devel@alsa-project.org, b.a.t.m.a.n@lists.open-mesh.org, broonie@kernel.org, davem@davemloft.net, dvyukov@google.com, edumazet@google.com, hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz, povik+lin@cutebit.org, steve@sk2.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tiwai@suse.com, tonymarislogistics@yandex.com, xiyou.wangcong@gmail.com

syzbot has bisected this issue to:

commit f8a4018c826fde6137425bbdbe524d5973feb173
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Jun 2 13:53:04 2022 +0000

    ASoC: tas2770: Use modern ASoC DAI format terminology

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164d4978880000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=154d4978880000
console output: https://syzkaller.appspot.com/x/log.txt?x=114d4978880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e2e478880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149ca17c880000

Reported-by: syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com
Fixes: f8a4018c826f ("ASoC: tas2770: Use modern ASoC DAI format terminology")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

