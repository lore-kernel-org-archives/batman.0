Return-Path: <ordex@autistici.org>
Date: Wed, 7 Aug 2013 11:09:41 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130807090941.GK2943@ritirata.org>
References: <52020C25.9080705@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <52020C25.9080705@gmail.com>
Subject: Re: [B.A.T.M.A.N.] DAT issue
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


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 10:58:13AM +0200, Fernando Pizarro wrote:
> Hi all!
>=20
> I'm playing with OpenWRT and BATMAN advance and I had configured one=20
> essid to serve dynamic vlans via freeradius reply attributes.
>=20
> I have a bridge (br0) with bat0, wireless and ethernet interface, and=20
> hostapd creates a new bridge by vlan (brvlanX) with vlanX and wlan1.X=20
> succefully. Br0 has configured a VLAN and IP to connect with every other=
=20
> nodes. There is the same explanation, but schematic:
>=20
> Wireless:
>=20
> phy0 -> wlan0 -> bat0
> phy1 -> wlan1 -> wlan1.1
>                       \ --> wlan1.N
>=20
> Hostapd bridge:
>=20
> wlan1 -> brvlan1 -> {wlan1.1; vlan1}
>        \ --> brvlanN -> {wlan1.N; vlanN}
>=20
> Ethernet bridge:
>=20
> br0 -> {bat0; eth0; wlan1}
>     \ --> br0.X =3D=3D IP/NETMASK
>=20
> When I look at batman dat table there aren't any registry, but variuos=20
> stations are connected. Why is that? What's wrong in my config?


Hello Fernando,

I have to say that your setup is not the easiest I've ever seen :)
However, the initial version of DAT was not made to work with VLANs, but I'=
m not
entirely sure if this should lead to an empty table.

First of all, where are all your clients connected? to wlan1?
Why did you put wlan1 into br0 and not wlan1.X?
When your clients are doing traffic, can you see ARP Req/Resp on wlan1 (whi=
ch is
the interface in br0 that will inject then the data into bat0)?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSAg7VAAoJEADl0hg6qKeOwtwQAKQCFD7pu12v1cd1gCX6YlXj
HqRYj3S9pBNluW6+IlxGDFlb4bJPHPIbmx7XXV3AE/q4LtAZIFyZfY2Bd2TT+d7z
ny5wFxgkFYbf7FNvGAw7RfpuR+npL6kyKdkdeZDjs9sA9WFMeKeXQWLv419fG1RY
2MvjnMc08RCZeZ7hmKzMqPmXWLwJJYDW07952VZ2JXfqJbNWt5vLQArg4jA4L1/y
zIux/GXMZPk9yoMdgPa4qewrEcHQl792+9k1FK2nHFu7gd74pguklCPllPzzDrFH
qQrsPlggLjfeA+zHN1m1IGb5BDoWULZrP0ucSj6O+NWmqJS4CBR9huACQozhIyxC
/AfX2XX/t1vFHXNvK/midOfjsYCDg6GrVNLZsH/OtmK3QpgwFUWuAnLxNRZfPxpN
0rYhZUKoWh3WUgvkq3qKZQUD7EOEdlnOf+6WAAIaGzRwDXhlm8gvG4r/BWCIwZJe
RPj8MLW7IUsb8AZpH0Fq2pY7er6MB48d4aFlP5TVyiaIWvSIzN8vTyHE9tl6lylx
77MqrkHR1U4F8vQp1kayMwfbxdHEGMm29BE5zcqrluSQaYeWORAtU6EGHQ70Fo0K
P4N3GbrcTOK/f60SzfdiM+Qq85N4QjOZikBTS/bVaCPg0Ky0oZX1W6mKP5SQ9t71
cdXdnvsDtlQztHsF0fxz
=1XV2
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
