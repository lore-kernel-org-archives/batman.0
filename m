Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 5 Jan 2019 16:12:24 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190105151224.GQ21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-4-sven@narfation.org>
 <20190104003954.GD21623@otheros> <9046472.zWXYbWcy6o@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9046472.zWXYbWcy6o@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 03/19] batman-adv: Prepare framework for
 hardif genl config
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

On Fri, Jan 04, 2019 at 08:52:22AM +0100, Sven Eckelmann wrote:
> > It seems unnecessary to keep holding a reference to hard_dev on
> > successful return here (and releasing it in post_doit).
> [...]
> 
> Ok.
> 
> > often with these net_device reference counters...) Same for
> > batadv_get_softif_from_info().
> 
> No, no, no, no, no, no, no and again no. The net_device is the only thing with 
> a refcounter here. The bat_priv doesn't have a refcounter because it is just a 
> memory region in the net_device.

With "Same for batadv_get_softif_from_info()" I was talking about
the

> In any case, maybe it would make sense to mention increased refcounts in
> the kerneldoc?

That is to add a line like "Increases the refcount of foo and
bar." So that users know which references to release and how to
use this function just from reading the kerneldoc.

I'm not talking about bat_priv here.
