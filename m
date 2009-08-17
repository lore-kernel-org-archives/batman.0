Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 18 Aug 2009 00:18:38 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090817221838.GD20229@ma.tech.ascom.ch>
References: <20090817183644.GC20229@ma.tech.ascom.ch>
	<20090817192041.GA25229@pandem0nium>
	<200908172133.18656.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908172133.18656.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv packet.h license
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

> And I think that it is still a good idea to have tcpdump dissectors as you 
> maybe want to have live output over your seriell interface on you embedded 
> device without much hassle.

Yes, that is my aim. Wireshark has too much overhead for embedded
system use.

Writing the dissector was simple. Writing new filters looks a lot
harder. I don't yet understand the Flex/Bision stuff in libpcap. Does
anybody have any experience with it?

        Andrew
        
