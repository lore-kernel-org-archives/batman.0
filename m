Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 03 May 2016 14:32:28 +0200
Message-ID: <10228266.x0VlN5ZfLu@bentobox>
In-Reply-To: <5437772.flAExnCRQc@prime>
References: <1894217.a7ufKNXfSr@bentobox> <5437772.flAExnCRQc@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11426593.zHV3OZ73mV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v3] Add throughput meter support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart11426593.zHV3OZ73mV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 May 2016 13:28:16 Simon Wunderlich wrote:
> On Tuesday 03 May 2016 10:59:07 Sven Eckelmann wrote:
> > Hi,
> > 
> > here is the third version of the throughput meter support. It is just a
> > rebased version of the patchset with two little bugfixes. Both problems were
> > detected and reported by Antonio:
> > 
> >  * batctl didn't check if the test_time is > 0 before doing a division
> >  * batman-adv wasn't returning an error to batctl when dst was not reachable
> > 
> > 
> > I am currently unsure how we should proceed regarding the ICMP packet type
> > used to communicate to the userspace ([PATCH 2/3]). Andrew+Matthias already
> > prepared a netlink patchset which looks quite good and which should be
> > tested+applied. The consequence for this patchset would be that patch 2
> > should be completely dropped and instead the tp_meter should become its own
> > command in the netlink interface of batman-adv. Any opinions about that
> > (order in which patches should be applied/netlink interface should be
> > handled) by the Simon, Antonio, Marek, Matthias or Andrew?
> 
> Thanks for preparing the patchset! Antonio, Marek and me discussed and agreed 
> that we should adopt the patchset as it is, and have the netlink support 
> additionally at a later point.

Did read Antonio the comment in the internal ticket?

Kind regards,
	Sven
--nextPart11426593.zHV3OZ73mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKJpcAAoJEF2HCgfBJntGkboQAKOzgLtxqlsmMNf3abZ1Ih/Q
6h4NdDUN+Q/M7ur84oEByQ267bBv5/beUEv+yXZwoMKY8tTtBor/KWXBNbwObJn7
ia1jeBHa4UHMaF59SoKrMZrE0Y59KmpZL+gNRLDn0En3bIL46Pnr4gJHl4SVpXOI
5Pqg+99UhV4Ni5ccBoUDfLfXUFaS/WsN/xPQjvukdUd6S0WlE94V1J6CU/UbcvkS
cCCFUVN+dBgqNWKqH0u7kfWcLNG0wbhDMLynPcF5Szq6Q/To9JC52WlZXbLElKeD
nRkw6lB2aQpfkE6D/BbLy6q0fHz/7nZiQp7enLvQ2mSwti3CUcSH7GQwf8oJ8m60
dsvv/W3QuPxkgmjIeaztp8TuMuVYep5eYrsr0eaijE2aBTaZuLBRP4wFDJIWVzQU
M4rT8b14bQ8Ceo/qgiIZLqlf9H0y8NuibeO0f5WdDF+1D4LGlDXb5RiBN8BIZ+Bz
OkmeTePsYSnsxR5OKmIY2YEfBZ7PCnjodZ396nRihaEmwEQkxq8+E2kqRnY7JMVp
/PmhoYj/5J5kb/3EpR3iYZcdwULwmxCqFSmnwmz2Nt5SflTDcBjr4u8Q8ezgxCWw
cN39GPrQWTLCydCDr+wGOaYPSy+SQdY4Xm9HO7/YZFQyzlCF/ldsZBU6rjkWZZ3L
IBlilTU4SCEPImmXCFtn
=jqSw
-----END PGP SIGNATURE-----

--nextPart11426593.zHV3OZ73mV--

