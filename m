Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
Date: Thu, 31 Dec 2009 02:44:52 +0100
In-Reply-To: <391345.99048.qm@web111612.mail.gq1.yahoo.com> (George Sanders's
	message of "Tue, 8 Dec 2009 20:24:01 -0800 (PST)")
Message-ID: <87eimbyl0r.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer only
	mesh
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: George Sanders <gosand1982-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>

> Who provides IP addresses in a truly ad-hoc, truly "peer only" mesh
> network ?

Nobody, as far as I know.

You may want to have a look at AHCP[1], however.  When configured for
IPv6 only, it gets configuration information (such as the IPv6 prefix
and the name server address) from central servers, but behaves in
a completely stateless manner -- there is no information stored in the
servers.

In IPv4, however, it uses leases, just like DHCP, so it needs to store
state in the servers.

> Please do point me to any writings or information related to this.

Search for draft-bernardos-manet-autoconf-survey.

                                        Juliusz

[1] http://www.pps.jussieu.fr/~jch/software/ahcp/

