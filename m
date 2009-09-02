Return-Path: <andrew@lunn.ch>
Date: Wed, 2 Sep 2009 08:18:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090902061822.GA2503@lunn.ch>
References: <20090830013647.GA26017@Linus-Debian>
	<200908311326.29339.lindner_marek@yahoo.de>
	<20090831055007.GR16067@lunn.ch>
	<200909020247.06730.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200909020247.06730.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] development flow
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

> > I would also suggest we post our patches as soon as possible, so we
> > start getting feedback from the kernel community about what else needs
> > adding to the TODO list etc.
> 
> Yes, when and where should we post it ? Should the mailing list be
> migrated at that point (I felt a consensus concerning the ml move) ?

We should post them to GregKH. That is what he said. What happens
after that i don't know. Maybe he has an internal team which will do a
review? Maybe it goes straight into staging and anybody who is
interested can review the code.

I would say the list needs to be open before we post the patches. We
don't want valuable comments going lost, or annoying people who do
reviews by bouncing there comments etc.

> It might be a good idea to maintain the ToDo list in the wiki - what do you 
> think ?

I say the master has to be in the sources, where anybody who reviews
staging will see. The Wiki copy is just a mirror, with a big comment
that its not the master, all changes should first go into the sources
TODO list which is then re-imported into the Wiki.

Maybe we need to branch SVN, or we setup a git tree. I already have
local changes just so that it builds with linux-next.git from
Saturday.

  Andrew
