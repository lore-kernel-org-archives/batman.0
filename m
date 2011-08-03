Return-Path: <andrew@lunn.ch>
Date: Wed, 3 Aug 2011 10:30:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110803083056.GE9901@lunn.ch>
References: <201108030952.35467.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201108030952.35467.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing code re-organization / the road ahead
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

> As a first step into that direction I worked on a set of patches to assemble 
> all B.A.T.M.A.N. IV related routing code in a single file, accessible via a 
> routing algo API which will also be used by the new code.

Hi Marek

Looking at the header files, it is not clear to me which contains this
routing algo API. Is it bat_ogm.h? 

Has there been any discussion if compile time is sufficient? How about
making it a runtime decision? I presume mixing routing algorithms
within a mesh is not going to work. However, being able to configure
the algorithm per mesh should be possible. This gives a greater degree
of interoperability, which might make the Linux Network maintainers
happier?

	Andrew
