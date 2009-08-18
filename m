Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 18 Aug 2009 20:38:01 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090818183801.GE20229@ma.tech.ascom.ch>
References: <20090817183644.GC20229@ma.tech.ascom.ch>
	<20090817192041.GA25229@pandem0nium>
	<200908190039.42236.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908190039.42236.lindner_marek@yahoo.de>
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

> yeah, also fine with me. Although I don't understand why we have to
> change the licence of our file for that (I never wrote dissectors
> for tcpdump).

I'm directly using packet.h. As is, no changes. I need the packet
structure definitions. The file has a GPL header, so its licensed
under GPL. If you mix that file with the rest of tcpdump, which is
BSD, tcpdump becomes GPL. I'm guessing this is not acceptable. So for
the copy of packet.h i include in tcpdump, i want to put a BSD license
on the file. The version in the batman repository can stay GPL. 

Thanks for O.K.ing this. I will post a patch to tcpdump here for
testing, before sending it to the tcpdump maintainers.

         Andrew
