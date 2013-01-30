Return-Path: <ordex@autistici.org>
Date: Wed, 30 Jan 2013 23:28:47 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130130222847.GC11109@ritirata.org>
References: <loom.20130130T212716-301@post.gmane.org>
 <20130130220316.GA11109@ritirata.org>
 <loom.20130130T231956-461@post.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <loom.20130130T231956-461@post.gmane.org>
Subject: Re: [B.A.T.M.A.N.] Using BATMAN to create a repeater
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


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 10:25:27PM +0000, Rip route wrote:
> Antonio Quartulli <ordex@...> writes:
>=20
> >=20
> > On Wed, Jan 30, 2013 at 08:30:52PM +0000, Rip route wrote:
> > > All,
> > > I am trying to create a WiFi repeater using hardware that cannot acco=
mmodate=20
> a=20
> > > normal "bridged repeater" mode. Is it possible to create this type of=
=20
> repeater=20
> > > using BATMAN adv?
> >=20
> > If I correctly got your question you may want to connect two nodes via=
=20
> wireless,
> > then install batman-adv on top of the wifi interfaces ans consequently =
bridge
> > the bat0 with the ethernet interface:
> >=20
> >      wlan0~~~~~~~wlan0
> >        .          .
> >       bat0       bat0
> >        .          .
> >       br0        br0
> >        .          .
> >      eth0        eth0
> >        |          |
> > ETH____/          \_______ETH
> >=20
> > wlan0s can be two adhoc interfaces (common case for a mesh) or also an =
AP/sta
> > pair.
> >=20
> > Cheers,
> >=20
>=20
> Thanks but I need to create a repeater where I can't load anything on the=
 root=20
> AP, I can only access the repeater.
>=20
>  client1~~~~~wlan0~~~~~~~wlan0~~~~~~client2
>                |         =20
>         ETH____/         =20


I think this detail depends on how you decide to configure the bridging on =
the
root AP. batman-adv will simply provide you the connectivity between the wi=
fi
devices and the "possibility" to create a bridge. Then it's up to you how to
configure it all.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRCZ6fAAoJEADl0hg6qKeO4xMP/2YbTg3a+PVAgYy+HpeDjYg4
3rdj95NOASA/R8JWXkJgEoBocjIFhf4PAtb5YM3jUxUhvRwB7E7aWQr8CMb5S5We
xE5UkhcfmHpKtGckNMdSJlzUHr0kPRcqDi0LFMgRKPyY+6Y735mHSOAAf1bki1m1
43AdBNoK5iGl8G1bQnXZ0KSsypFQF4PZF8Io8gZoPgz+fiuX8//+n9q2TcnPieQz
fC8MCKjHY5oOUx3lQPTVT+yd6X7aYcuoi8reZvAotINkySPeilJwXlqAj1v5MxIj
b9Mysb0VUZkHmNa9AWdMbEqODrYnlrm0XUFdkdBKBxAaScbszONUP+8bAp3IC+GE
E7y5ewlYmp4Ycz6FYdKtKPYkAvfh1oADkGslqfTR9deNFrRqkNDhAj7mTTVqXJDK
RZVZT5lXucYMx3mK5SC1ovuEfWCFmChE43fRSX6iPYzzOAq0FCqIiBPy0bc3DDR4
NdLfzgPipEr3rQhQbSL66lqc/JRg7jz851B5bFjj1WAX/ydLbmc6hiK5L7aKCKN/
C2FbHSQXDvJWCW/ncAXI0GN+yJw1pWx1KUwY23E0xhDRI73BXSQuLVNFqgxgUrGH
5QiktSxtQ4caF7krinC03SIotzpepTy9fK0LpeM0wHG3euQGZnLi0rpTG+ZFDnfG
6jsLpLSgT6Yru2fyXz0Q
=o3PU
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
