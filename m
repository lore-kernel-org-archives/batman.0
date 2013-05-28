Return-Path: <ordex@autistici.org>
Date: Tue, 28 May 2013 08:31:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130528063124.GA3333@ritirata.org>
References: <1369660201-1096-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1369660201-1096-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix num_changes type to
 uint16_t
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
To: b.a.t.m.a.n@lists.open-mesh.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, ignore this patch. It has been resent by accident.

On Mon, May 27, 2013 at 03:10:00PM +0200, Antonio Quartulli wrote:
> Since the introduction of the tvlv_tt_data struct variables
> storing the number of TT changes are always declared as
> uint16_t, however some of them were not changed.
>=20
> Switch them al to uint16_t.
>=20
> Introduced by 8405301b979466610a726b7d595b6bfee5306cf7
> ("batman-adv: tvlv - convert tt data sent within OGMs")
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpE88AAoJEADl0hg6qKeODrIP/ivdWOMl/IvG2GaJLRfmMapo
Ufg2WpgBO4q9BBzfOIAYQGLud5RF+eNZrtPacK/SrglupSgllrX0VUWFkwdjgfLm
c9sEJ4pEwEUKvC4Oc0MFSqnG8ZEW0zi3ErcryuiU93LqUHhfMjl80ufmSQHy/NiR
YdncPJVExxPLT1/MnOsTxjJb9Yot0DUqCLIsOW703aTmp5e3xcvLB+4d60iRom4v
tih6zHtiH0crz0HDYpLwZz2z1rMsMcdGUFs3f0zTpd757pLUJqyUoFUrY9bX+MjA
hshwPJOcjjH9bNxZaJ7VWSS9mjdPNTvUGb7NZdJWBLGzDmWf3BVI+20fWJnJE7fQ
Bp6ihGl91Wb5HC6uU3iyFU6m3MzOE5FpbkkHOsbOFnHb4kNzpiLw6g0mh0XVohMx
fJ4wbd6RTyliyRzqKErh5V42tfCjF2hZwrRFbM+bYJKR7SuajEcbKRnyBGJEaVc2
/tUVPTjsbH9zjYteFoa9MV1R4d0P12I3HTkNPH9n4yX42x8kY1iSB/0Mn+2Vm2ak
e/jQM48R1zpVJAI2HUWWDkxguccTNaGqaI+pVs+vBKIArYVUdaENeke0wM+/gm1s
xoZo5v27Lvhvv/NDaSKTE8O87UySMmuqncdTT4x+FkAg7BQ8x7jsP9DrUQmsqswl
tOhH2rf43LC4ZpxVuG0y
=qE2s
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
