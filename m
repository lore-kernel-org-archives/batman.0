Return-Path: <davem@davemloft.net>
Date: Fri, 06 Dec 2013 15:39:44 -0500 (EST)
Message-Id: <20131206.153944.1382127535160341376.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1386317890.31845.26.camel@joe-AO722>
References: <1386317890.31845.26.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH -next] batadv: Slight optimization of
	batadv_compare_eth
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
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com

From: Joe Perches <joe@perches.com>
Date: Fri, 06 Dec 2013 00:18:10 -0800

> @@ -266,7 +266,11 @@ static inline void batadv_dbg(int type __always_unused,
>   */
>  static inline int batadv_compare_eth(const void *data1, const void *data2)
>  {
> -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
> +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +	return ether_addr_equal(data1, data2);
> +#else
> +	return memcmp(data1, data2, ETH_ALEN) == 0;
> +#endif
>  }

Let's not crap up implementations with these ifdefs.

What's the specific situation here?  Is it that 'data1' and/or
'data2' my not be u16 aligned?

If so, make a function for that in linux/etherdevice.h and invoke it
in such places.  You can name it something like
"ether_addr_equal_unaligned()" or similar.

Thanks.
