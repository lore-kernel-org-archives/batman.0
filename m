Return-Path: 
  <3dxP0XgkbAGwcijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 24 Jun 2020 20:01:11 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
Message-ID: <00000000000006e0ff05a8dfce2d@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From: syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
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
To: a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, bvanassche@acm.org, davem@davemloft.net, dongli.zhang@oracle.com, hdanton@sina.com, jianchao.w.wang@oracle.com, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk

This bug is marked as fixed by commit:
blk-mq: Fix a recently introduced regression in
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
