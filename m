Return-Path: <davem@davemloft.net>
Date: Wed, 11 Dec 2013 00:20:40 -0500 (EST)
Message-Id: <20131211.002040.1061939246483044835.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1386738050.git.joe@perches.com>
References: <cover.1386738050.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH -next 0/3] seq_printf/puts/putc: Start to
 convert to return void
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: joe@perches.com
Cc: coreteam@netfilter.org, keescook@chromium.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Tue, 10 Dec 2013 21:12:41 -0800

> Many uses of the return value of seq_printf/seq_puts/seq_putc are
> incorrect.  Many assume that the return value is the number of
> chars emitted into a buffer like printf/puts/putc.
> 
> It would be better to make the return value of these functions void
> to avoid these misuses.
> 
> Start to do so.
> Convert seq_overflow to a public function from a static function.
> 
> Remove the return uses of seq_printf/seq_puts/seq_putc from net.
> Add a seq_overflow function call instead.

I'm fine with this going in whatever tree is appropriate for
the seq_overflow un-static change:

Acked-by: David S. Miller <davem@davemloft.net>
