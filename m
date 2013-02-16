Return-Path: <ordex@autistici.org>
Date: Sat, 16 Feb 2013 13:35:12 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130216123512.GD3157@ritirata.org>
References: <1360682516-11005-1-git-send-email-ordex@autistici.org>
 <201302162022.37757.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <201302162022.37757.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: free an hard-interface
 before adding it
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


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2013 at 08:22:37PM +0800, Marek Lindner wrote:
> On Tuesday, February 12, 2013 23:21:55 Antonio Quartulli wrote:
> > @@ -347,6 +342,13 @@ int batadv_hardif_enable_interface(struct
> > batadv_hard_iface *hard_iface, goto err_dev;
> >  	}
> >=20
> > +	/* check if the interface is enslaved in another virtual one and
> > +	 * in that case unlink it first
> > +	 */
> > +	master =3D netdev_master_upper_dev_get(hard_iface->net_dev);
> > +	if (master)
> > +		netdev_upper_dev_unlink(hard_iface->net_dev, master);
> > +
> >  	hard_iface->soft_iface =3D soft_iface;
> >  	bat_priv =3D netdev_priv(hard_iface->soft_iface);
>=20
> Seems we need some compat code here:
>=20
> hard-interface.c:348:2: error: implicit declaration of function=20
> 'netdev_master_upper_dev_get'

Correct. I'm not used to test code for master on kernel older than net-next.
I'll send v2 with the proper support for ancient kernels.

Cheers (:D),


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRH30AAAoJEADl0hg6qKeOlC4QAK0rL3LLiP1Mz4Zr7SJFFOmW
qcHLxv6XhZDwAst5xBSpk45D6njEjvwziren68UVPw5vBybxB9GeNBBNAnDAScgH
0HzqaIz1CbDw62WCCXW6U+o3Kaiig6bzEzj6I9rSGwr8tK4wXgM16ztrAvn4JaWU
uyiXudY4GMG8TwLlHTQTqQAXbHoglSQe14A7hjiFMTIFq4Yt0w+czWSvzjfxzNV5
LTnlkJqorqyviYAxGUwgxSAfxuvYeb7vZdgNySNZ7q4iNyL6ogZ3FnUUqkAsg31S
V1jdU7StxsNC1hyVvJxxgCu/EnK9gmt14jU4gvwx5N/6cTEN86WDcbhR6TmhLnIV
6kboiEKCFK5qu4MK5uBqM3jGRlFLcasCz3/H+A051BG8/xKdzdfcuE1CdhR6yMGd
Fr6SxNzV+VgGBpAO28ZPxq25JlXU6OTQRLM3/DyWZJdIixPZdFkV7l+PoMpG4H4O
1snDQ0Q5ngegjA18BS4PNtw4nK1AW8L/Nbz75S9z1p2RfAIN+Iud1BCkJTe2GIhI
j0462kvXzeed+9CRN6bosNis7QPYk6V4+aaaqpXK8k67vHEK7PFOT9M4MF7ubCLa
BSuN0hwQuih+5eb0+XHRJOidqnqimEtafUFT+pPozFHyx0vwk02b0c462coigSzC
OOo3t0vwFzNbzojZ/wxJ
=9aTS
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
