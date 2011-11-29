Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 14:35:09 +0800
References: <201111290028.01655.lindner_marek@yahoo.de>
	<201111290345.29771.lindner_marek@yahoo.de>
	<20111129060924.GF13600@lunn.ch>
In-Reply-To: <20111129060924.GF13600@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111291435.10033.lindner_marek@yahoo.de>
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

On Tuesday, November 29, 2011 14:09:24 Andrew Lunn wrote:
> On Tue, Nov 29, 2011 at 03:45:29AM +0800, Marek Lindner wrote:
> > On Tuesday, November 29, 2011 03:02:45 Andrew Lunn wrote:
> > > > +static struct bat_algo bat_algo_iv __read_mostly = {
> > > > 
> > > >  	.name = "BATMAN IV",
> > > > 
> > > > +	.bat_ogm_init = bat_ogm_init,
> > > > +	.bat_ogm_init_primary = bat_ogm_init_primary,
> > > > +	.bat_ogm_update_mac = bat_ogm_update_mac,
> > > > +	.bat_ogm_schedule = bat_ogm_schedule,
> > > > +	.bat_ogm_emit = bat_ogm_emit,
> > > > +	.bat_ogm_receive = bat_ogm_receive,
> > > > 
> > > >  };
> > > 
> > > This needs an .owner = THIS_MODULE,
> > > 
> > > so you can do reference counting on the module.
> > 
> > It is not a separate module ..
> 
> Which leads to the question, why is it not a separate module?

Why should it be ? 

Cheers,
Marek
