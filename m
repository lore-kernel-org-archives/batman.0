Return-Path: <linus.luessing@web.de>
Date: Fri, 11 Dec 2009 14:45:35 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091211134535.GA2879@Linus-Debian>
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
	<20091112005149.GA2879@Linus-Debian>
	<87fx8fvhpg.fsf@trurl.pps.jussieu.fr>
	<20091123142151.GA21537@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20091123142151.GA21537@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2009 at 03:21:51PM +0100, Linus L=C3=BCssing wrote:
> > > Hmm, yes, true, IPv6 does not support fragmentation at all...
> >=20
> > It does, but it's done end-to-end, not at intermediate routers.  See
> > Section 5 of RFC 2460.
> Ah, ok, yes, you're right, forgot about the fragmentation header
> in IPv6 :).
By the way, does anyone know if it is possible to encapsulate
packets with the ethernet frame / packets from a brdige port in ipv6?
RFC 4303 for encapsulating security payload looks like only tunnelling of
ip-traffic is possible with the standardised features of IPv6.

Cheers, Linus

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLIkz/AAoJEBKw7u43QNpf70gQALyhHK+zZprqilQt3cTNN1NF
RwGNBUDSCOMW6rD8hbAB4FUyJJy+ydN/5ralUBX8MUE+XZhKt9pLsoaJWToc8a60
CjmpX4lEp+lRhExAA8eS81EIYVDmL6R2aMfrBgE7NBJHq0yoZjWfTW6anQB5OmfY
nq+UjkXP1z30jZ35DPvhxjfDpL7YatJqDExol7x+B9HVIP1xjxwNbRSWGCpRiEnp
we+CorYYq3pQh4ll15rSYmQ+4Bl6yyMw19IRoFDobccpjQu0mY8Q/JAX0vIpsKDy
jHDNv60CnSuNKgnGvvVckDm5StrfiIAc4Wlebngf6B7q/Nn2iqfK9S1jh1Rw0YVS
umzL22tkBdU+BEexwN0IbIja6UI/X5vxP1780uDpqG8Oa7AQkr7SyVEbwDIE3+vR
VBIxbU66/JCl0RVLzVKahJz9hiYOjIATmghC9Cu+unFKD5U7daZsYyMHwa3lGH7q
2h4dTgvO6IoCKnq1niC91HCaIWXzFj9asl0Pa1kUpFrTbLmHZ7IvvEmlZL6cnWK2
KO332iGUyAlD2qfpmbrBxiHmtgpwPWirIxFg7Q7W9z+A14/wg1OEesvob/18VcpM
jVgqfY2s5VJ4BJMuM8jFoV2GT9jrp/SDwUiXV1w9nnvvYxMu1FimnJDZSierIyTc
mKTm6fyuRtrPq47qowjl
=2uVa
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
