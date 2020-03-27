Return-Path: <axboe@kernel.dk>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
References: <0000000000004760b805a1cc03fc@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa743a2c-f79e-6021-7c2b-72e178f913f4@kernel.dk>
Date: Fri, 27 Mar 2020 09:06:32 -0600
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
To: syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, dongli.zhang@oracle.com, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk

On 3/26/20 7:28 PM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 768134d4f48109b90f4248feecbeeb7d684e410c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Nov 11 03:30:53 2019 +0000
> 
>     io_uring: don't do flush cancel under inflight_lock

This is definitely an utterly bogus bisect, not related at all.

-- 
Jens Axboe

