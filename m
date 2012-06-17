Return-Path: <ordex@autistici.org>
Date: Sun, 17 Jun 2012 20:05:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120617180549.GA25505@ritirata.org>
References: <1339709917-15971-1-git-send-email-ordex@autistici.org>
	<1339828061-15884-1-git-send-email-ordex@autistici.org>
	<201206170300.14767.lindner_marek@yahoo.de>
	<20120616221117.GB15888@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20120616221117.GB15888@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: don't try to re-route
 tt_request for me
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 17, 2012 at 12:11:18AM +0200, Antonio Quartulli wrote:
> On Sun, Jun 17, 2012 at 03:00:14AM +0800, Marek Lindner wrote:
> > On Saturday, June 16, 2012 14:27:41 Antonio Quartulli wrote:
> You are right. I misinterpreted this skb.
> I'll send v4 soon!
>=20
> Thank you
>=20

After having read this patch more and more I can conclude that we do not re=
ally
need it. send_my_tt_response() will always return true and so the problem I
mentioned cannot be triggered at all.
I don't know if we really need a bool function if it does always return tru=
e.
But this is a different issue.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/eHH0ACgkQpGgxIkP9cwc+5gCgiC5yY0VGRcx6TBTmKDdepyNV
rAcAoId7Qrw4M6BJbvJhYWbjATdRPm9I
=iGdz
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
