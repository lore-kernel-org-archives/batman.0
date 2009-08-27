Return-Path: <andrew@lunn.ch>
Date: Thu, 27 Aug 2009 16:17:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090827141721.GA27212@lunn.ch>
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261119.22173.onelektra@gmx.net>
	<20090826180810.GF16067@lunn.ch>
	<200908271310.34348.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908271310.34348.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
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

> Regarding a open posting list - what would be a possible migration
> scenario for a new list hosted at sourceware et al, given that we
> have an existing list with a number of subscribers?

vger is majordomo based. The current batman list is mailman. So i
doubt there is direct export/import options for all account
information. It should however to possible to simple export just the
email addresses and import them.

sourceware uses ezmlm. So again, probably no direct export/import of
everything, probably just a list of email addresses can be mass
imported.

I don't know for sourceforge. All my googles turn up the project
mailman which is hosted there, but its not clear if its what they use
for lists.

Once the list is created, the MX record for lists.open-mesh.net needs
changing to point to the new list server and the list server needs to
be configured to accept emails for that domain. This is not difficult.

Probably the best bet is to pick a list server provider and talk to
their sysadmins. I'm sure this is not the first time such an operation
has happened.

    Andrew
