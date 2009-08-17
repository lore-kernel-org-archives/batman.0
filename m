Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 17 Aug 2009 21:33:18 +0200
References: <20090817183644.GC20229@ma.tech.ascom.ch>
	<20090817192041.GA25229@pandem0nium>
In-Reply-To: <20090817192041.GA25229@pandem0nium>
MIME-Version: 1.0
Message-Id: <200908172133.18656.sven.eckelmann@gmx.de>
Content-Type: multipart/signed; boundary="nextPart7280647.xzfkn2oIht";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv packet.h license
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart7280647.xzfkn2oIht
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Hello Andrew,
>
> this is fine with me, let's hear what marek thinks. BTW, there are
> excellent batman dissectors for wireshark, have you tried them already?
The B.A.T.M.A.N. dissector is in Wireshark 1.2, but the B.A.T.M.A.N. advanc=
ed=20
dissector is still waiting in=20
https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=3D2631 and/or=20
http://gitorious.org/wireshark-batman-plugins/wireshark-batman-adv

And I think that it is still a good idea to have tcpdump dissectors as you=
=20
maybe want to have live output over your seriell interface on you embedded=
=20
device without much hassle.

Best regards,
	Sven

--nextPart7280647.xzfkn2oIht
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKibB+AAoJEF2HCgfBJntGE7kP/2e9Fc2Bs0XS+QaDZhx/b1Bp
G2D1K+SloNilIxJK6RPfjEidjIHJNStqQTajcv53Qi8aJmSmRejKqMmFQx6DJcq6
Q1YQJkvCi+K6rwlnyJOyev0uG0SD35dTLrOOTKaYkseOhfy98IRxpeLNOI3+QRPg
i89fyVF+AfkEFajnZdKXcozw5HQeOGAcpY4ABp6XMZeflzjcD7m6r9KQ9gl2w9aK
e/EkW2ThKfkfBpG9GtQgQ3TdhKsIbI3ndmWTKsMC6kgvZn+1rKdfbLsg7p24e6h7
/3FTkEvHsdEHA5/ogqsbRCIRYyiJJdrFxiJBztrc//9bzlhysfLSUttLwCWcHTpg
IPO6Qy7R30YUP6rFxVe22KF6xZDoCfOb9zwYd0/kiAirjp4KEZrfLca1R/QNBeoe
pwZdjQtDPC6adDBq9Fpjr+t7MVKUS9FDPsO+7FrQTisoiZUICgKH42Hfj3+WaxeR
If8ynFDIyjeybmT6go7V4GPt9P0Dx9G0HVTQmozG2O4nf1R2W3pHTO02kiV6S4Zu
6Jj/eYH5MHJz0ApepxCOlPmPYnMqS+Du70POkXGDppJG+SFuthz1vJd83gZJRM8m
wCIGdQjnzoLyBo41BwvLSrPM6egYlaqH0XtfmshoJbjpFbREuaCPRs/2A7ZnZhNc
6u/LaOfe5XS4rgdUrj3T
=A2D6
-----END PGP SIGNATURE-----

--nextPart7280647.xzfkn2oIht--
