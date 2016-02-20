Return-Path: <a@unstable.cc>
Date: Sat, 20 Feb 2016 13:10:12 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160220051012.GD5584@prodigo.lan>
References: <1792155.rcBUdH4UUQ@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <1792155.rcBUdH4UUQ@bentobox>
Subject: Re: [B.A.T.M.A.N.] Unsigned integer overflow in
	batadv_iv_ogm_calc_tq
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>, Marek Lindner <mareklindner@neomailbox.ch>


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 01:35:31PM +0100, Sven Eckelmann wrote:
> It is easy to see that
>=20
>     batadv_ogm_packet::tq (u8 255) *
>     tq_own (u8 255) *
>     tq_asym_penalty (int 134) *
>     tq_iface_penalty (int 255)
>=20
> is outside the range of an signed integer (32 bit). The maximum seen
> here is 255 for each entry. So should tq_iface_penalty +
> tq_iface_penalty, inv_asym_penalty be changed to unsigned int?

Given that all these values are in the TQ domain I'd say that they should a=
ll be
positive all the time, therefore there is no gain in using a signed variable
here.

Marek, what do you think ?

Cheers,

--=20
Antonio Quartulli

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWx/U0AAoJENpFlCjNi1MRHH8P/A87ABXiFZQRx7LMUaAtRnI9
JTIN+fUSpjn0Uu840xJVU/mk5o9Prixp3f8d1xDxBEql8uNJhPqiAjlQP/meDvCF
I7C6g3qraRaz4+RK3rUNpOuY1Y5dn7Uto5mu7xAP41iw0E2Y2S6kLkpJBvLl5dM3
bgpj1R84JZvYQGSNP0fuKcFotdl5j8W4zJzxe/0yW0lTIYjk22fiMv1i188JMU1D
wWd6FC7BOqYj2OhTuqFxj6HawTAq/2VxUODtWFdeYeK0xFZVDzivqPz9JTnVlTyb
Bs7H1wMiEA38AoO799ZnwtR868tEFlpzwfzxrOe/sO2lDY5tjLQYCvtTWKjk9KZr
G/pOy4vlfvEK1+7pV4CLtAauQqIBz+wtPneMJUYl9A0meysjpasaUJR2B2/3GDpm
gNlHXGoBWXsXTOiUng4QZEZWAXBnhsw0z97t4VxZnEkrtdaQ+lrC3WrxxEFSXOFK
+x8I6t5UR0ehMtJpXzcSIHCyeFX8w7bJdXV7CmoQ7KguDDp2ktSvXvPMsCYQCLur
XTKa+lXbQJ1a49GxvfYjcYO7lSCPry8K+7byb0G3I/CrgiuXzb9RwF9IQ8iumt34
MrqYUKk3Ag3EE9oHL3hLuR55J9yz6YE4JdqQhF+bscFRbpGNfurMHlkwaIrbwk3Z
eYrA+HyUXtWcPH3yAwbf
=j2A3
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
