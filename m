Return-Path: <andrew@lunn.ch>
Date: Wed, 26 Aug 2009 13:01:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090826110131.GI20818@lunn.ch>
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
	<200908261651.16980.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908261651.16980.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Configuration interface...
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

> > > Should /proc/net/batman-adv/interface be replaced with an IOCTL interface
> > > similar to brctl?
> >
> > How to design the kernel<->userspace interface that it doesn't end like
> > wireless-tools?
> 
> I'm not so familiar with the iwconfig situation you seem to refer to. Could you 
> outline the issues ?

It is complex and horrible. It is also badly implemented by many
wireless devices so is inconsistent.

However, batman has a much simpler interface. There is a lot less to
configure:

originator interval
aggregation to enable/disable
vis server/client mode
interfaces to use

So it should be possible to implement a reasonably simple interface. I
think only the interfaces is somewhat tricky and needs thinking
about. The rest can be individual files in /sys.

       Andrew
