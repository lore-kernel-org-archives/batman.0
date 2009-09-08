Return-Path: <andrew@lunn.ch>
Date: Tue, 8 Sep 2009 18:01:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090908160146.GA21945@lunn.ch>
References: <20090830013647.GA26017@Linus-Debian>
	<200909020247.06730.lindner_marek@yahoo.de>
	<20090902061822.GA2503@lunn.ch>
	<200909031406.49008.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200909031406.49008.lindner_marek@yahoo.de>
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

Hi Folks

Sorry for suddenly disappearing after getting some momentum going for
getting batman into mainline. My employer sent me to Finland to work
on a project for 2-3 weeks and it has been hard to find time to work
on batman. I guess i will not be back to normal working situation for
at least another week.

> > I would say the list needs to be open before we post the patches. We
> > don't want valuable comments going lost, or annoying people who do
> > reviews by bouncing there comments etc.
> 
> Ok, then who is doing the migration ? I surely can help to provide
> the list of subscribed users.

The steps as i see it:

1) Make a decision about which list server to use.
2) Contact the sysadmin and ask for a list to be setup.
3) Export the list of subscribers.
4) Import the list of subscribers.
5) Modify the MX record.
 
I guess vger is probably the least flexible about domain names. Mail
coming from the list might not be using the lists.open-mesh.net
domain. So maybe someone should ask sourceforge and sourceware if they
could provide the list using this domain.

> I can create git.open-mesh.com so that we have an official git to pull from ?

I think this is a good idea. It is probably easier for GregKH to do a
pull then handle lots of patches. 

     Andrew
