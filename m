Return-Path: <andrew@lunn.ch>
Date: Tue, 29 Nov 2011 09:45:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111129084509.GB15521@lunn.ch>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<201111290345.29771.lindner_marek@yahoo.de>
	<20111129060924.GF13600@lunn.ch>
	<201111291435.10033.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201111291435.10033.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv
 algorithm to use dynamic infrastructure
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Nov 29, 2011 at 02:35:09PM +0800, Marek Lindner wrote:
> On Tuesday, November 29, 2011 14:09:24 Andrew Lunn wrote:
> > On Tue, Nov 29, 2011 at 03:45:29AM +0800, Marek Lindner wrote:
> > > On Tuesday, November 29, 2011 03:02:45 Andrew Lunn wrote:
> > > > > +static struct bat_algo bat_algo_iv __read_mostly = {
> > > > > 
> > > > >  	.name = "BATMAN IV",
> > > > > 
> > > > > +	.bat_ogm_init = bat_ogm_init,
> > > > > +	.bat_ogm_init_primary = bat_ogm_init_primary,
> > > > > +	.bat_ogm_update_mac = bat_ogm_update_mac,
> > > > > +	.bat_ogm_schedule = bat_ogm_schedule,
> > > > > +	.bat_ogm_emit = bat_ogm_emit,
> > > > > +	.bat_ogm_receive = bat_ogm_receive,
> > > > > 
> > > > >  };
> > > > 
> > > > This needs an .owner = THIS_MODULE,
> > > > 
> > > > so you can do reference counting on the module.
> > > 
> > > It is not a separate module ..
> > 
> > Which leads to the question, why is it not a separate module?
> 
> Why should it be ? 

I can think of a couple of reasons.

1) You might get asked when you post the code upstream, why you have
the ability to register algorithms, but have not taken it further to
allow modules to load algorithms. That seems to be the normal case in
kernel code, registration implies modules. You probably need an
argument ready why you don't want it.

2) It helps shows you have the split between the routing algorithm and
the rest of the code correct. If you need to add lots of
EXPORT_SYMBOL_GPL() for functions which the routing algorithm needs to
call then maybe the abstraction is wrong?

     Andrew
