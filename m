Return-Path: <bart.vanassche@gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
References: <0000000000004760b805a1cc03fc@google.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <60bb3266-03fb-acfc-d285-b0249bb5e57d@acm.org>
Date: Thu, 26 Mar 2020 20:00:15 -0700
MIME-Version: 1.0
In-Reply-To: <0000000000004760b805a1cc03fc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>, a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dongli.zhang@oracle.com, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk

On 2020-03-26 18:28, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 768134d4f48109b90f4248feecbeeb7d684e410c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Nov 11 03:30:53 2019 +0000
> 
>     io_uring: don't do flush cancel under inflight_lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14233ef5e00000
> start commit:   1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16233ef5e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12233ef5e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> dashboard link: https://syzkaller.appspot.com/bug?extid=313d95e8a7a49263f88d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13850447e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a26f5e00000
> 
> Reported-by: syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com
> Fixes: 768134d4f481 ("io_uring: don't do flush cancel under inflight_lock")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


#syz fix: blk-mq: Fix a recently introduced regression in
blk_mq_realloc_hw_ctxs()
