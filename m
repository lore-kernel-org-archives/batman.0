Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Date: Fri, 06 Nov 2009 20:05:31 +0100
Message-ID: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] A peer-reviewed assessment of OLSR, BATMAN and Babel
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
To: babel-users@lists.alioth.debian.org, olsr-users@lists.olsr.org, b.a.t.m.a.n@lists.open-mesh.net
Cc: jerryw@uow.edu.au, brett_hagelstein@uow.edu.au, mehrana@uow.edu.au

I've just come upon an interesting paper that experimentally compares
the performance of OLSR, BATMAN and Babel.

    Real-world Performance of Current Proactive Multi-hop Mesh
    Protocols.  M. Abolhasan, B. Hagelstein, J. C.-P. Wang.

    http://ro.uow.edu.au/cgi/viewcontent.cgi?article=1747&context=infopapers

Short summary: see Table II on the last page.


A few comments on the paper:

1. Section II (the informal description of the protocols) doesn't make
   much sense.  Ignore it.

2. They evaluated original OLSR, not OLSR-ETX as used by our friends in
   Vienna and Berlin.

3. The results in Figure 3 would appear to imply that there's a bug in
   Babel -- it loses a packet every time it switches routes.  I think
   I understand why.

4. They ran the routing daemons with the default parameters.  This means
   that BATMAN ran with an OGM interval of 1 second, while Babel used
   a Hello interval of 4 seconds.  It would have been interesting to see
   the results with similar parameters.

5. They didn't measure the amount of routing protocol traffic.

                                        Juliusz
