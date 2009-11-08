Return-Path: <Juliusz.Chroboczek@pps.jussieu.fr>
From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
	<200911071842.08599.lindner_marek@yahoo.de>
	<7iocnez3p1.fsf@lanthane.pps.jussieu.fr>
	<3F4B7F12-DB83-4483-AE6F-4B615E3A0AFE@lo-res.org>
Date: Sun, 08 Nov 2009 02:08:48 +0100
In-Reply-To: <3F4B7F12-DB83-4483-AE6F-4B615E3A0AFE@lo-res.org> (L. Aaron
	Kaplan's message of "Sun, 8 Nov 2009 00:35:39 +0100")
Message-ID: <7i4op5lt5r.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] [Olsr-users] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
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
To: "L. Aaron Kaplan" <aaron@lo-res.org>
Cc: olsr list users mailing <olsr-users@lists.olsr.org>, The Ad-hoc Networking list for a Better Approach To Mobile <b.a.t.m.a.n@lists.open-mesh.net>, jerryw@uow.edu.au, babel-users@lists.alioth.debian.org, brett_hagelstein@uow.edu.au, mehrana@uow.edu.au

> I would have liked to see a comparison with OLSR.org default settings
> (ETX metric) instead of hopcount metric.

Agreed.

Note however that this doesn't entirely explain why OLSR collapsed in
their tests.  If you look at table I, you'll notice that in the case of
node Babel did choose the shortest hop-count route, and Babel and OLSR
exhibited similar levels of route flapping; in other words, in this
particular test ETX and shortest-hop coincide.  However, Figure 2
indicates that OLSR's throughput was half that of Babel, and in
Figure 3, OLSR's packet delivery ratio was just 75%.

                                        Juliusz
