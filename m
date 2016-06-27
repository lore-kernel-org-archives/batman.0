Return-Path: <a@unstable.cc>
Date: Mon, 27 Jun 2016 10:36:13 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160627023613.GX10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
 <1613308.eWzkVEsf7s@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tTm07/aDcFLy+pwu"
Content-Disposition: inline
In-Reply-To: <1613308.eWzkVEsf7s@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
 implement GW selection logic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--tTm07/aDcFLy+pwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 01:26:31PM +0200, Sven Eckelmann wrote:
> On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> > +       if (orig_throughput < (gw_throughput + threshold))
> > +               goto out;
>=20
> Possible overflow problem in batadv_v_gw_is_eligible. We don't
> know what the user will add here and what the gw_throughput is.
>=20
> We already had a similar problem in the BATMAN_IV gw selection
> code which resulted in weird gw selections. See f63c54bba31d
> ("batman-adv: Avoid u32 overflow during gateway select").

Sven, correct me if I am wrong, but in f63c54bba31d we are changing the typ=
e of
the variables aimed to contain the value computed by the "overflowing"
operation, while in this case we have everything in a if condition: should =
the
temporary result be implicitly casted to a larger variable as required ?

I may be wrong - but I wanted to ask you to be sure.

Cheers,


--=20
Antonio Quartulli

--tTm07/aDcFLy+pwu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXcJEdAAoJEJ4aZjxxc6bKJqsP/jEAocnsco7H6FZMjyxytKTE
NBtPFtkGS0p6J2WJSOP6dldEgRBFR9Yi9JrK7nCCRYZB3tKwAaqu0xVA/z2AIZE1
lECGqM19jYxlsZ4vVOawghlvGKaWnjNntzrDScEOIMmK59mJmk2huuEOE9qwtsR4
o2uiade7EwlEyZpBQmUHAoP/UBQPId9IIZlkyhDuSW5lHeHr87+t9t5Tu7v5vU7l
F+t5hIY4do3TpKE3GVcTcJ77ikWBlne6zWctgDGL43geyy6JUBZ+uuB5FAfX0+Wa
FmCObZDfrWF4tjyP1FfoWUUGIKAprRpyc/KJLQn8y6JNYMkKN6YIPKbag03UyMiM
PC4b4bip5LkqBF9NY5+3vbgusCInWZtQYlMACU7SL2HPK1OLUabr/0HmGAZm91Om
LvI0pshxbuS1NKi83vFvbDJpPaaiYY4LHb8sBvja2BPfpEgigpH1TReC2SO+hJsd
LaEWz+eaRmTTOdfrNFD45iP0RrD+w4Lh1elHlGQc41IpN7YYfacjSzoakhMG48RM
fA/ntDVLNUkWp0Wm+zxIVPgdKJVOqZjcwLChnkKqUzzNeB+2SCahIGgdyhMWXemV
T8+6e5p3Z/n5OsVj8a5dUPlEqBv4G+lkST0c0zwjPVULZ8uOmOCvjpGYdIQegVmy
hb7iTKJKIUHr06UOr1FI
=8gZE
-----END PGP SIGNATURE-----

--tTm07/aDcFLy+pwu--
