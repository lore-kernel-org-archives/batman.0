Return-Path: <gfree.wind@foxmail.com>
From: "Gao Feng" <gfree.wind@foxmail.com>
References: <1493121800-28066-1-git-send-email-gfree.wind@foxmail.com>
 <1756616.320MP6AHYH@bentobox> <002901d2be25$d9092bd0$8b1b8370$@foxmail.com>
 <3994535.Z9kqCnttI2@bentobox>
In-Reply-To: <3994535.Z9kqCnttI2@bentobox>
Date: Wed, 26 Apr 2017 14:44:24 +0800
Message-ID: <002101d2be58$8bcaaa00$a35ffe00$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: 'Sven Eckelmann' <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, 'Gao Feng' <fgao@ikuai8.com>, davem@davemloft.net

> From: Sven Eckelmann [mailto:sven@narfation.org]
> Sent: Wednesday, April 26, 2017 1:58 PM
> On Mittwoch, 26. April 2017 08:41:30 CEST Gao Feng wrote:
> > On Dienstag, 25. April 2017 20:03:20 CEST gfree.wind@foxmail.com wrote:
> > > From: Gao Feng <fgao@ikuai8.com>
> > >
> > > Because the func batadv_softif_init_late allocate some resources and
> > > it would be invoked in register_netdevice. So we need to invoke the
> > > func batadv_softif_free instead of free_netdev to cleanup when fail
> > > to register_netdevice.
> >
> > I could be wrong, but shouldn't the destructor be replaced with
> > free_netdevice and the batadv_softif_free (without the free_netdev)
> > used as ndo_uninit? The line you've changed should then be kept as
> free_netdevice.
> >
> > At least this seems to be important when using rtnl_newlink() instead
> > of the legacy sysfs netdev stuff from batman-adv. rtnl_newlink() would
> > also only call free_netdevice and thus also not run
> > batadv_softif_free. This seems to be only fixable by calling ndo_uninit.
> >
> > Sorry, I don't get you.
> > The net_dev is created in this func batadv_softif_create.
> > Why couldn't invoke batadv_softif_free to cleanup when fail to
> > register_netdevice?
> >
> 
> Because it is the legacy way to create the batadv interfaces and there is
a
> "new" one. The new way is to use rtnl link (see batadv_link_ops).
> 
> The rtnl linke (rtnl_newlink) would not benefit from your fix and
therefore still
> show the old behavior. I think a different fix is necessary to solve the
problem
> for both ways to create an batadv interface.
> 
> Kind regards,
> 	Sven

I get it now, thanks.
Actually I sent another patch about the memleaks when invoke newlink and
fail to register_netdev.
You could refer to it by
https://www.mail-archive.com/netdev@vger.kernel.org/msg165253.html.

In this patch, I add the cleanup when fail to register_netdev.
It would be more simple if modify the rtnl_newlink and invoke the destructor
of netdev when failed.
Like the following codes.
	if (ops->newlink) {
		err = ops->newlink(link_net ? : net, dev, tb, data);
		if (err < 0) {
			if (dev->reg_state == NETREG_UNINITIALIZED)
				if (dev->destructor)
					dev->destructor(dev)
				else
					free_netdev(dev);
				goto out;
			}
		} else {
			err = register_netdevice(dev);
			if (err < 0) {
				if (dev->destructor)
					dev->destructor(dev);
				else
					free_netdev(dev);
				goto out;
			}
	}

But I don't know if it breaks the design newlink and destructor.

BTW, I think although the batadv_softif_create is legacy, we should fix it
when it still exists :)

Regards
Feng


