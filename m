Return-Path: <ordex@autistici.org>
Date: Sun, 26 Aug 2012 01:01:58 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120825230158.GB5003@ritirata.org>
References: <1345825951-24041-1-git-send-email-ordex@autistici.org>
 <20120824191804.232524cc@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20120824191804.232524cc@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: print packets re-routing
 on DBG_TT and ratelimit it
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2012 at 07:18:04 +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> Please add net_ratelimited_function() to compat.h, since it didn't make
> its way into mainline before 3.5.

oh right. Thank Martin. I'll send a new version of the patch including the
change in compat.h

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA5WWYACgkQpGgxIkP9cwe/vwCfZR80S48BLDRTB2/vuHxdYmzk
bQ0AnAh10vlzCsMe34/EC/YweB159icL
=9Rbt
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
