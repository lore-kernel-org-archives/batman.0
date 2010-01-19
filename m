Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 19 Jan 2010 20:37:01 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100119193701.GA18515@pandem0nium>
References: <20100118112706.91160@gmx.net>
	<201001182138.32432.lindner_marek@yahoo.de>
	<20100119074334.275290@gmx.net>
	<201001192007.38210.lindner_marek@yahoo.de>
	<20100119145151.294630@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20100119145151.294630@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just as a side note, would you mind sharing your changes which were require=
d to cross compile=20
for ARM? batman-adv is supposed to support 2.6.24, and if there is any trou=
ble with this
on ARM i'd like to add support for it.

Thank you very much,
	Simon

On Tue, Jan 19, 2010 at 03:51:51PM +0100, "Juha Yl=C3=B6nen" wrote:
>=20
> -------- Original-Nachricht --------
> > Datum: Tue, 19 Jan 2010 20:07:38 +0800
> > Von: Marek Lindner <lindner_marek@yahoo.de>
> >
> > It confirmed what we saw in the other logs: This device (the laptop?) d=
oes
> > not=20
> > see the packets from the other side, therefore the protocol correctly
> > assumes =20
> > a dead link. There might be 2 reasons: either the wifi layer does not
> > really=20
> > work or batman-adv drops the packets without any further warning.=20
> > You can try the latest trunk and/or run batctl/wireshark on the laptop =
to=20
> > deep-inspect the packets. Feel free to share the logs with us.
>=20
> I got the latest trunk up and running, some changes were required to get =
it to crosscompile for ARM (and 2.6.24 kernel). Same behaviour as before, d=
evice log shows a lot of activity, but laptop batman doesn't seem to be doi=
ng much anything. I tried the wireshark and got a log ok (which shows a lot=
 of multicast traffic from the device until I disabled the service) but I'm=
 at loss to decipher possible batman packages. What should they look like i=
n wireshark? I only noticed couple of IPX packages from device to (broadcas=
t?) but nothing else. I attached the log file, is anyone able to say if the=
re are batman packages included?
>=20
> -Juha
> --=20
> Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.=
5 -
> sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser



--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktWCd0ACgkQrzg/fFk7axaWQQCfeQosqc3o+58vSJe18jnU2qsQ
OQAAoOqGvAVItmWAV+oIiq0o8IIOO9NE
=+40r
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
