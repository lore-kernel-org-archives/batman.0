Return-Path: <linus.luessing@web.de>
Date: Thu, 11 Feb 2010 03:25:43 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100211022543.GA6493@Linus-Debian>
References: <20100208193848.GA8545@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20100208193848.GA8545@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] race condition with activate_module?
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
To: b.a.t.m.a.n@lists.open-mesh.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Okay, I could narrow it down a little further: There is a problem
with the num_ifs variable. When activate_module() gets called in
proc_interfaces_write() and an ogm of a neighbour arrives after
this for the first time but before we've set 'num_ifs =3D if_num + 1;',
then we're not allocating enough space in get_orig_node(), leading
to a kernel panic.

num_ifs is just getting used in those two functions,
locking this variable seemed an easy choice for fixing this. But
nevertheless, I'm unsure if this might be enough, as quite a lot
of copies of num_ifs are being stored/modified in a lot of other
functions (if_num for instance) which gave me some headaches
today :). Therefore I'm doubting the simple locking of num_ifs
might be enough. Any ideas how this problem could be dealt with
instead?

The problem can be easily reproduced by adding a "ssleep(3)" for
instance in front of "num_ifs =3D if_num + 1;" in
proc_interfaces_write(). Then insmod, connect a running batman-adv
node to the other end of the interface being used and set those
interfaces up. Adding the interface to batman-adv then causes the
kernel panic within those 3 seconds then.
Putting the ssleep behind num_ifs =3D ... does not cause any kernel
panics on my vm here.

Cheers, Linus

On Mon, Feb 08, 2010 at 08:38:48PM +0100, Linus L=C3=BCssing wrote:
> Hi guys,
>=20
> I think I've seen this bug a couple of times but I've never been
> able to reproduce it. Now I added a little patch to slow down the
> activate_module() procedure and the bug occures every time now. My
> question is, did I make a race condition apparent or did I introduce
> a bug with this patch?
>=20
> Cheers, Linus

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLc2qnAAoJEBKw7u43QNpfdiQP/jpD7Q1U3H0gpVfeJwzm1CFL
BXiSvqXVBqYL0pkI90kcCB5yj2X2vK2UDJxR8GnwtD553CBzaSrqKG9YDSxvNTtH
pP+Zn/QjPnpWR3zk8MSp4DgQTvyrU4H13IpvC+6fnoARnMz4d4pwhy0RSRJLoUoY
VkWRrGf701pDNvDCrRWioSCb9uy1pJQ9WV+SW5lfvNypxcflpraKHUhAcvBjO4Qs
+UcgFYPwP1mhhjsxf0QdK5Wn80qNlHIWAUroCU4WWGLKh74EI0OTyqIJUFj7jSXR
+q77BKAAts5eXx9mCfo2E1ihbBFzlcWLt1QjfSEie+CvZm1uZLwjf8xtZzO3aftU
30QRTKlZHgDv3X66ZktOLpFMB8SjwFxazJ/D9eHcGMl3PYWO45Q3ghnGzUtBF2fJ
jzWsQXTD7l5E3AwWpP2xLeangozOFzyBDqghaXR0PEUS8L8BNxHSY5ySHgMHc8ix
J1gKJJgijfh5Nqfkg0ZaarkWKXx+yOAOIh9m3xAMe/lqjdpMq6xyf3IvyGCi9O87
VW5gXAAg8XEjktSu15Li4cKzdPhSS0U9CIhzBu5JuzaIRvl4ilTysVAJK1Wir5Hn
L38Hqcm4LDRCzaJkovtwwWgngsGqJCI86FkAQs1ZLqxvNkPS0wnJH7RDN1bRQk6M
7v6jWRx0nsOdIDsz6UHc
=4bPm
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
