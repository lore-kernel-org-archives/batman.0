Return-Path: <andrew.lunn@ascom.ch>
Date: Mon, 24 Aug 2009 12:08:17 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090824100817.GL30255@ma.tech.ascom.ch>
References: <20090823130934.GA28556@ma.tech.ascom.ch>
	<200908241702.32201.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908241702.32201.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Use prinkt instead of debug_log
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

> Does this patch mean you got in touch with a maintainer and he/she suggested 
> to do that ? What else did he/she suggest ?

No i've not asked yet. However, i don't know of any other kernel
module which does debug output in a similar way. So my guess is this
needs changing.

I keep intending to make a ToDo list. Here is what i have in my mind
at the moment. Some are just questions/ideas and all of it needs
discussing.

Finish stripping out debug_log.

Make batctl standalone.

Maybe make batctl _The_ tool for configuration and status and
depreciate direct proc access, so that we can restructure it without
too much pain for users.

Take out the dot_draw/josm formatting in vis and put it into batctl.

Think if /proc/net/batman-adv should be renamed /proc/net/bat0 giving
the option of /proc/net/bat1 etc in the future?

Should /proc/net/batman-adv/interface be replaced with an IOCTL interface
similar to brctl?

Maybe move orig_interval, aggregate_ogm and write half of vis to /sys?
At least spit vis into two.

Investigate if there is a generic linux hash algorithm which should be used?

Strip out all backward compatibility support.

Make use of printk %pM support.

     Andrew


