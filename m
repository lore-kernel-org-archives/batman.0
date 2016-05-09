Return-Path: <a@unstable.cc>
Date: Mon, 9 May 2016 18:45:33 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160509104533.GI3945@prodigo.futur3.it>
References: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
 <20160508154159.GB14515@prodigo> <8890255.lVUf8VaFkP@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline
In-Reply-To: <8890255.lVUf8VaFkP@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: init ELP tweaking options
 only once
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 03:32:19PM +0800, Marek Lindner wrote:
> On Sunday, May 08, 2016 23:41:59 Antonio Quartulli wrote:
> > On Sun, May 08, 2016 at 07:47:16AM +0800, Marek Lindner wrote:
> > > The ELP interval and throughput override interface settings are
> > > initialized
> > > with default settings on every iface_enable() call. Thus, the user sp=
ace
> > > configuration is overridden as soon as an interface is going down and
> > > coming up again.
> >=20
> > iface_enable() is only invoked when an interface is added to the mesh. =
Up
> > and Down should trigger a iface_activate/deactivate() only.
> >
> > Have you seen the userspace settings being reverted ?
>=20
> Without my patch:
> root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval=20
> 500
> root@OpenWrt:/# echo 700 > /sys/class/net/eth1/batman_adv/elp_interval
> [51835.004638] batman_adv: eth1: elp_interval: Changing from: 500 to: 700
> root@OpenWrt:/# ifconfig eth1 down && ifconfig eth1 up
> root@OpenWrt:/# cat /sys/class/net/eth1/batman_adv/elp_interval=20
> 500

Performed the same, but I cannot reproduce. I tested:
- origin/maint:  9685688ae7dd85804aec2f6ce760611551fe9635
- origin/master: 7608af0adebb29dc25bd8aa489ad8a2d0e4a6317

Are you sure you are not testing this with other patches applied ?

Cheers,

--=20
Antonio Quartulli

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMGpNAAoJEJ4aZjxxc6bKUEoQAMevnIab9ygK9SiWgVPyzbHs
MgZuJVUxftaNsvf8vzAHcvZSAbl2wTMg96UsfDkYL5a/rv6yvu3tHuuX/Ci5TP3k
slWbKv0HYRVZA44GJXMuXGPDdnpqgz66PJSNSidbX5uQCPSG7G7Ap0PIAjuNtimA
2JPCkjpnBlWnXxTqipTvxZIZMVwcdlWwmd0ukBgHI3t2pxFyj/MSCcdm/W+F0MP0
8UDRujMQI4+BrcgxIuHXgl/U4vCUJcOSyTmFgOYmLM1od49NiUPZWf2gtqDyT4f8
VAXhqVydOYRLNKODNLa5K5YFWLT2VTMmsqvj5zEXXqLfwfUYTucUwvNKNA3ebs92
qZw4/CAWgXv6hw4Vzmoa/TjYSW+avnihXVXNKFmilwf4VIPHR6pRnGxNv6rzSK+p
5O7r46PiCO+dIf/cIhLkmJdl4DuN/EexRcFboxhprCpHsiqLGBHWt+90eAH3UuYl
iwaUxVPueAlT/Af+v0nTs/ep9X2mn63UtrdN1pQmVyI7HCRhYJWANIQLLlj/swAS
U6uWNP/YzUcDVFXvzGcg1bdWS6Q5VojgMeoHqfFrNYQcsTNvHrfnLEkhLn5dOTIK
oIk7vAOAeLFdP/yaWEDq9f9qgOjor6zjD3+9VgfKnRQ0P6LUIo1iv0x3HXaYq6j6
tmPfXbSWm27tVtU79kk5
=OWsM
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
