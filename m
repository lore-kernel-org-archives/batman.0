Return-Path: <andrew@lunn.ch>
Date: Wed, 10 Feb 2010 14:11:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100210131150.GE2900@lunn.ch>
References: <20100208205602.GA9369@Sellars> <20100208213212.GA9389@Sellars>
	<20100210023641.GA2112@Linus-Debian>
	<201002101847.49306.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002101847.49306.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use original printk in
 bat_printk
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

On Wed, Feb 10, 2010 at 06:47:49PM +0800, Marek Lindner wrote:
> On Wednesday 10 February 2010 10:36:41 Linus L??ssing wrote:
> > bat_printk is calling a printk which got previously
> > substituted because of the define in compat.h.
> > This patch removes the define for the scope of
> > bat_printk.c.
> 
> After seeing your patch I understand the issue. We redefine printk()
> to bat_printk() which works fine for all functions except for
> bat_printk() itself.  I think your approach seems to be a solution
> although we don't need to define printk at the end again, do we ?

I think Simon added compat.h when he reworked the patch. My original
version did not use it to avoid this recursion problem. Linus's
solution looks O.K, but as you said it is not necessary to redefine it
at the end. I also don't see why the ___printk is needed.

While we are at it, please also remove the "foo:". That i do claim
responsibility for. I developed the patch on a kernel which is %pM
capable and i wanted to be sure it was using bat_printk and not the
native printk when testing. So i put in the foo. It never got removed
:-(

   Andrew
