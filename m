Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 20:27:24 +0800
References: <1360682516-11005-1-git-send-email-ordex@autistici.org>
 <201302162022.37757.lindner_marek@yahoo.de>
In-Reply-To: <201302162022.37757.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302162027.24930.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: free an hard-interface
	before adding it
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, February 16, 2013 20:22:37 Marek Lindner wrote:
> On Tuesday, February 12, 2013 23:21:55 Antonio Quartulli wrote:
> > @@ -347,6 +342,13 @@ int batadv_hardif_enable_interface(struct
> > batadv_hard_iface *hard_iface, goto err_dev;
> > 
> >  	}
> > 
> > +	/* check if the interface is enslaved in another virtual one and
> > +	 * in that case unlink it first
> > +	 */
> > +	master = netdev_master_upper_dev_get(hard_iface->net_dev);
> > +	if (master)
> > +		netdev_upper_dev_unlink(hard_iface->net_dev, master);
> > +
> > 
> >  	hard_iface->soft_iface = soft_iface;
> >  	bat_priv = netdev_priv(hard_iface->soft_iface);
> 
> Seems we need some compat code here:
> 
> hard-interface.c:348:2: error: implicit declaration of function
> 'netdev_master_upper_dev_get'

I wouldn't be surprised if netdev_upper_dev_unlink() also needed some compat 
code ...

Cheers,
Marek
