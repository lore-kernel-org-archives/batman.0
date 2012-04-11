Return-Path: <ordex@autistici.org>
Date: Wed, 11 Apr 2012 22:52:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120411205246.GA29501@ritirata.org>
References: <1333832769-28493-1-git-send-email-ordex@autistici.org>
	<1333832769-28493-2-git-send-email-ordex@autistici.org>
	<20120408223849.GB10101@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20120408223849.GB10101@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix comments ending style
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2012 at 12:38:49AM +0200, Simon Wunderlich wrote:
> On Sat, Apr 07, 2012 at 11:06:07PM +0200, Antonio Quartulli wrote:
> > @@ -732,7 +732,7 @@ static int handle_claim(struct bat_priv *bat_priv,
> >  }
> > =20
> >  /**
> > - *
> > + * @bat_priv: the bat priv with all the soft interface information
> >   * @bat_priv: the bat priv with all the soft interface information
> >   * @hw_src: the Hardware source in the ARP Header
> >   * @hw_dst: the Hardware destination in the ARP Header
>=20
> guess this line was duplicated by accident ...

I took 4 days to understand what you were talking about :D
Sorry!

I will arrange this clean up in the next pull request!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPhe8eAAoJEFMQTLzJFOZF6QkH/iqVrb/43rsgfM42sDlmbodF
4ogcgZSFX0yAdv2NtUtRgDcHofj+FNNsLNTQDYIqshIWKLz4s1TlpfErl1p8L2x3
tAj8IOVN5jtF3J6k02adfw1RDlw7ncTIeUIPnWUk+V+KwYV67ph1fZ84IQSHf6q1
a0jC7Jk9q1zQJN+PH3dDCeiNlQ2PIkQHIcJg0xe+W0lT0zO0nqRvMe3G3uVbP194
/Ioylwhf4eWKsvIX/8vxQ8Hl/JGYwME4E9yQbUZHomRHK4mZGUJj0DtVnbwCInOF
IEerhz+6XeB+sQ3ve6qOGSiqZ5qgmgl23yxh65mJOEysPRpNHYH1noKJpyE40X0=
=R4Hs
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
