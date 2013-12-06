Return-Path: <joe@perches.com>
Message-ID: <1386364621.31845.32.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Fri, 06 Dec 2013 13:17:01 -0800
In-Reply-To: <20131206.153944.1382127535160341376.davem@davemloft.net>
References: <1386317890.31845.26.camel@joe-AO722>
 <20131206.153944.1382127535160341376.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
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
To: David Miller <davem@davemloft.net>
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com

On Fri, 2013-12-06 at 15:39 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Fri, 06 Dec 2013 00:18:10 -0800
> 
> > @@ -266,7 +266,11 @@ static inline void batadv_dbg(int type __always_unused,
> >   */
> >  static inline int batadv_compare_eth(const void *data1, const void *data2)
> >  {
> > -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
> > +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> > +	return ether_addr_equal(data1, data2);
> > +#else
> > +	return memcmp(data1, data2, ETH_ALEN) == 0;
> > +#endif
> >  }
> 
> Let's not crap up implementations with these ifdefs.
> 
> What's the specific situation here?  Is it that 'data1' and/or
> 'data2' my not be u16 aligned?

Yes.

> If so, make a function for that in linux/etherdevice.h and invoke it
> in such places.  You can name it something like
> "ether_addr_equal_unaligned()" or similar.

I'll resubmit if/after you apply the
ether_addr_equal/compare_ether_addr removal.

cheers, Joe


