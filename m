Return-Path: <fgao@ikuai8.com>
From: =?gb2312?B?uN+35Q==?= <fgao@ikuai8.com>
References: <1493121800-28066-1-git-send-email-gfree.wind@foxmail.com>
 <5895676.ebVRaD88im@bentobox>
In-Reply-To: <5895676.ebVRaD88im@bentobox>
Date: Fri, 9 Jun 2017 15:26:26 +0800
Message-ID: <001a01d2e0f1$b529a070$1f7ce150$@ikuai8.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Content-Language: zh-cn
Subject: Re: [B.A.T.M.A.N.] [PATCH net] net: batman-adv: Fix possible
 memleaks when fail to register_netdevice
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: gfree.wind@foxmail.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, netdev@vger.kernel.org

> From: Sven Eckelmann [mailto:sven@narfation.org]
> Sent: Friday, June 9, 2017 3:23 PM
> Subject: Re: [B.A.T.M.A.N.] [PATCH net] net: batman-adv: Fix possible
memleaks
> when fail to register_netdevice
> 
> On Dienstag, 25. April 2017 20:03:20 CEST gfree.wind@foxmail.com wrote:
> > From: Gao Feng <fgao@ikuai8.com>
> >
> > Because the func batadv_softif_init_late allocate some resources and
> > it would be invoked in register_netdevice. So we need to invoke the
> > func batadv_softif_free instead of free_netdev to cleanup when fail to
> > register_netdevice.
> >
> > Signed-off-by: Gao Feng <fgao@ikuai8.com>
> > ---
> >  net/batman-adv/soft-interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/batman-adv/soft-interface.c
> > b/net/batman-adv/soft-interface.c index d042c99..90bf990 100644
> > --- a/net/batman-adv/soft-interface.c
> > +++ b/net/batman-adv/soft-interface.c
> > @@ -1011,7 +1011,7 @@ struct net_device *batadv_softif_create(struct net
> *net, const char *name)
> >  	if (ret < 0) {
> >  		pr_err("Unable to register the batman interface '%s': %i\n",
> >  		       name, ret);
> > -		free_netdev(soft_iface);
> > +		batadv_softif_free(soft_iface);
> >  		return NULL;
> >  	}
> 
> It looks to me like this change is invalid after David's change [1]. Can
you
> confirm that?
> 
> Thanks,
> 	Sven
> 
> [1]
>
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=cf1
> 24db566e6b036b8bcbe8decbed740bdfac8c6
[Gao Feng] 

yes, this change is unnecessary. 

Best Regards
Feng




