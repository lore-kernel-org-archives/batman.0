Return-Path: <davem@davemloft.net>
Date: Fri, 20 Feb 2015 15:18:43 -0500 (EST)
Message-Id: <20150220.151843.902196140727344622.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424136699.8287.10.camel@perches.com>
References: <1424136699.8287.10.camel@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove uses of return value
	of seq_printf
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch, antonio@meshcoding.com, linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 16 Feb 2015 17:31:39 -0800

> This function is soon going to return void so remove the
> return value use.
> 
> Convert the return value to test seq_has_overflowed() instead.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to net-next.
