Return-Path: <linus.luessing@web.de>
Date: Fri, 7 Jun 2013 23:16:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130607211644.GE6426@Linus-Debian>
References: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
 <201305281755.44921.lindner_marek@yahoo.de>
 <20130528155114.GA27671@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130528155114.GA27671@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Add dummy soft-interface
 rx mode handler
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

On Tue, May 28, 2013 at 05:51:14PM +0200, Linus Lüssing wrote:
> On Tue, May 28, 2013 at 05:55:44PM +0800, Marek Lindner wrote:
> > On Sunday, May 26, 2013 23:56:07 Linus Lüssing wrote:
> > > @@ -572,6 +584,7 @@ static const struct net_device_ops batadv_netdev_ops =
> > > { .ndo_get_stats = batadv_interface_stats,
> > >         .ndo_set_mac_address = batadv_interface_set_mac_addr,
> > >         .ndo_change_mtu = batadv_interface_change_mtu,
> > > +       .ndo_set_rx_mode = batadv_interface_set_rx_mode,
> > >         .ndo_start_xmit = batadv_interface_tx,
> > >         .ndo_validate_addr = eth_validate_addr,
> > >         .ndo_add_slave = batadv_softif_slave_add,
> > 
> > Do we need compat code for this API call ?
> > 
> > Cheers,
> > Marek
> 
> Yes it does, actually. A PATCHv3 will follow soonish. Thanks for
> the hint!

Hm, I changed my mind, it actually shouldn't need any compat code.
At least compiling worked fine for me for 2.6.29 to 3.9 kernels.

There was a .ndo_set_multicast_list once with all these calls
being reassigned to .ndo_set_rx_mode and .ndo_set_multicast_list
being removed since 3.2 ("net: remove use of
ndo_set_multicast_list in drivers":afc4b13df143122f99a0eb10bfefb216c2806de0).
However .ndo_set_rx_mode has always been threre for
kernels >= 2.6.29, <= 3.9.

Cheers, Linus
