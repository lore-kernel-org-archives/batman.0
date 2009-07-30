Return-Path: <andrew.lunn@ascom.ch>
Date: Thu, 30 Jul 2009 20:40:00 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090730184000.GA3396@ma.tech.ascom.ch>
References: <20090718145236.GN4656@ma.tech.ascom.ch>
	<200907251950.58372.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907251950.58372.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Cleanup proc.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Sat, Jul 25, 2009 at 07:50:55PM +0800, Marek Lindner wrote:
> On Saturday 18 July 2009 22:52:36 Andrew Lunn wrote:
> > Make proc.[ch] clean with respect to the 2.6.29 checkpatch
> > script. Exceptions are long lines with printk/seq_print.
> 
> I just applied this patch with a small modification. You changed the vis output 
> from float link quality to integer. This removes valuable information and I 
> don't see why this is necessary, hence I changed it back. May be I overlooked 
> something - please let us know the reasoning behind this.

Upps, sorry. That was an error. We have a graphing tool which uses
both vis and originators. This changed made them both use the same
units for link quality. That is nice for your tool, but probably not
wanted for other people.

       Andrew
