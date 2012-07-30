Return-Path: <ordex@autistici.org>
Date: Mon, 30 Jul 2012 12:07:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120730100704.GG2578@ritirata.org>
References: <1343603730-3824-1-git-send-email-ordex@autistici.org>
 <201207300959.16852.lindner_marek@yahoo.de>
 <20120730092343.GF2578@ritirata.org>
 <201207301147.03506.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <201207301147.03506.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the WIFI flag from the
 local to global entry
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 11:47:03AM +0200, Marek Lindner wrote:
> On Monday, July 30, 2012 11:23:43 Antonio Quartulli wrote:
> >   On Mon, Jul 30, 2012 at 09:59:16AM +0200, Marek Lindner wrote:
> > > On Monday, July 30, 2012 01:15:30 Antonio Quartulli wrote:
> > > > in case of client roaming a new global entry is added while a
> > > > corresponding local one is still present. In this case the node can
> > > > safely pass the WIFI flag from the local to the global entry
> > >
> > > And why would we want that ?
> >=20
> > To let the AP-isolation work. If a client is known to be WIFI and we do=
 not
> > "pass" this flag on roaming, we end up in a state where this client is =
not
> > marked as WIFI anymore (even if it should be).
> >=20
> > During this time period the client will be able to talk to the other WI=
FI
> > clients even if the AP isolation is enabled
>=20
> And why is this explanation not part of the commit message ?

Because it is left as exercise for the reader ;-)
Actually I didn't mention it because the Ap-Isolation part is a "consequenc=
e".
What this patch wants to fix is an issue in the client entry state consiste=
ncy,
regardless of the semantic of such state.

Anyhow, if you think it is worth adding it, I will do that.

Cheers,

>=20
> Regards,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAWXMgACgkQpGgxIkP9cwcONQCdFzVliqqC1Bfh7nV6jRP21hHJ
DKkAn0CCP/TxCII1u9JK58jH4p6bizeD
=lo5K
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
