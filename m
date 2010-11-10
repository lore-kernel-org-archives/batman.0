Return-Path: <gregkh@suse.de>
Date: Wed, 10 Nov 2010 08:04:55 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20101110160455.GC10561@suse.de>
References: <12893476522148@site> <201011101117.03979.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201011101117.03979.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] patch "staging: batman-adv: Use
	linux/etherdevice.h address	helper functions" added to staging tree
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: tklauser@distanz.ch, b.a.t.m.a.n@lists.open-mesh.org, siwu@hrz.tu-chemnitz.de

On Wed, Nov 10, 2010 at 11:17:03AM +0100, Marek Lindner wrote:
> 
> Greg,
> 
> > The patch is only compile-tested.
> 
> [..]
> 
> > diff --git a/drivers/staging/batman-adv/main.c
> > b/drivers/staging/batman-adv/main.c index 0587940..6ea6420 100644
> > --- a/drivers/staging/batman-adv/main.c
> > +++ b/drivers/staging/batman-adv/main.c
> > @@ -149,7 +149,7 @@ void dec_module_count(void)
> > 
> >  int compare_orig(void *data1, void *data2)
> >  {
> > -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
> > +	return (compare_ether_addr(data1, data2) == 0 ? 1 : 0);
> >  }
> 
> I'm wondering why you accepted this patch despite the raised objections 
> regarding alignment problems. [1][2]

Because at the end of that thread, it sounded like you all agreed that
this patch was acceptable.

If not, then please let me know and I will revert it.

thanks,

greg k-h
