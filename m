Return-Path: <bart.vanassche@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
References: <00000000000006e0ff05a8dfce2d@google.com>
Message-ID: <b30f9b35-1504-a8f6-91cd-828e56c59eef@acm.org>
Date: Wed, 24 Jun 2020 21:05:52 -0700
MIME-Version: 1.0
In-Reply-To: <00000000000006e0ff05a8dfce2d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>, a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dongli.zhang@oracle.com, hdanton@sina.com, jianchao.w.wang@oracle.com, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk

On 2020-06-24 20:01, syzbot wrote:
> This bug is marked as fixed by commit:
> blk-mq: Fix a recently introduced regression in
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.

#syz fix: blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()


