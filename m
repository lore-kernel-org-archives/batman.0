Return-Path: <a@unstable.cc>
Date: Tue, 26 Jan 2016 13:43:14 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160126054314.GC9299@prodigo>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-3-git-send-email-andrew@lunn.ch>
 <20160125032853.GA15121@prodigo.lan>
 <20160125131239.GY3880@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <20160125131239.GY3880@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
 interfaces within correct netns.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 02:12:39PM +0100, Andrew Lunn wrote:
> On Mon, Jan 25, 2016 at 11:28:53AM +0800, Antonio Quartulli wrote:
> > On Wed, Jan 20, 2016 at 06:48:28PM +0100, Andrew Lunn wrote:
> > >  int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_if=
ace,
> > > -				   const char *iface_name)
> > > +				   struct net *net, const char *iface_name)
> >=20
> > Andrew,
> > minor style note here: instead of passing the namespace as argument, co=
uld we
> > just invoke dev_net() on hard_iface->net_dev inside
> > batadv_hardif_enable_interface() ?
>=20
> Hi Antonio
>=20
> The problem with that is register_netdevice() is used to register the
> soft interface in batadv_softif_create(). Calling it after
> registrations would mean it needs to change netns. The default
> namespace might already have a bat0, so it is given the name bat1, but
> then gets moved to the target netns, and will keeps its name, unless
> there already is a bat1 interface. But people expect the newly created
> interface to be called bat0.
>=20
> I think passing the namespace is correct, so the softif can be created
> in the correct place to start with.
>=20


Yeah, you are right, I overlooked something in my review.
The patch looks good to me.

Cheers,

--=20
Antonio Quartulli

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWpwdyAAoJENpFlCjNi1MRwHcQAJ2Z9gZDlqiIcPsS2xv9UuBl
U9xSrcqigRMRA0NSq4QK/MwLIsRTKl9GsOIbflf/VSbQyiurCl+wM9pwvz55bGiX
o4Qwao+vkgAQyJhDK+M9M4Q7Q3HVr3mOFE6CQyIonn91fp2Tm8YaA8GAWB/X5rT9
YwBTcOjyAWwC4PUXh9I/COqTHefe3cqUxyHfT0nhWyJK25lzFhXadu0sslv3+4m6
M7bBgILdQl6ZtXNd8wgufQyCDxi35dEuy+UJI98rDHCc30Jon1DKix7HFK2m0RZi
1HLRLIyH/3g35xZvV/fY3vu5swxj/NbKeHNGjbZrP0Ca2vkFj51w22We83dIU0hV
ITXBpUNoIBqJC0dnRkudXH42TJiYS23oNNQzIQrFv9oHpht7QeJgp9cPLmptLxVG
SUQcO//fBShAIbihG0WEItJJHK+rx9gMAFUfLc+2oB5pjkBJwr4m5evZ27GYSf8I
8padcpOsCZn6IVeZIANAWYLQ77DEhMh6EGdrnSTElGmVz1tbTB5ybspm5HqfRcud
Ofw576GIZiuhXli9VazDBYDYeKch89G3Q6OIm0IQgFE9qwTAGg5oW+ptMYS4g2Wi
rfKPIDoKHsb3+WDQg5jCWk1bOfct0Od3X22HCxmW6YWgfRe0wz8g9RIeUMCwnswL
6Rg5xDNcFvzKEZmoh50E
=L0nn
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
