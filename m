Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 7 Jul 2010 01:45:30 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070021.43888.clemens-john@gmx.de>
	<201007070030.30940.lindner_marek@yahoo.de>
In-Reply-To: <201007070030.30940.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7797788.aG1P4gRxrl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007070145.39178.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

--nextPart7797788.aG1P4gRxrl
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch 07 Juli 2010, 00:30:30 schrieb Marek Lindner:
> On Wednesday, July 07, 2010 00:21:38 Clemens John wrote:
> > I still got two question left that I remembered when I read your answer=
s:
> > We discussed our networksetup on IRC (you remember?) and we decided to
> > choose the setup with tinc an not sending batman advanced packages over
> > VPN.
>=20
> Oh yeah, I remember. Did you document your setup somewhere ? Others might
> find it useful to see why & how you did it.

Yes we did some verry little documentation [1] but this is still the pure=20
configuraion without explenations  because we are currently testing some=20
different configurations for example some IPv6 stuff and a script which can=
=20
automatically announce tinc installations with configuration and certificat=
es on=20
a central server for automatic tinc installations etc..

I hope this will get better in the next time.

[1] http://wiki.freifunk-
ol.de/index.php?title=3DOpenWrt_Freifunk_Standartkonfiguration

> > Now batman advanced nodes behind the VPN does not get listet in the
> > originator tables of nodes on the other side of the VPN.
> > But do they get listed on the gateway list? Can Batman advanced choose a
> > gateway behind the VPN?
>=20
> No, because the gateway information travel with the OGMs which you don't
> have on your VPN. Sending dhcp requests via unicast also does not work
> because the VPN interfaces are not controlled by batman.

Mhh...
The only way to solve this would be to send whole batman advanced frames ov=
er=20
Tinc VPN right (we called this solution 3 in the irc session)?

Would this be possible? I know that we than have the MTU problem again and=
=20
higher traffic load (what would not be so fatal because we have no cetral s=
erver=20
with tinc).

Our current setup makes not much sense if we use Batman advanced with gatew=
ay=20
mode because we do not have a gateway in each cloud and it would be difficu=
lt to=20
get one to each cloud.
The best way would be a solution that can use all gateways available in the=
=20
network without extra configuration for each cloud.

Can you give me a short example of how to fix the mtu problem with this met=
hod?=20
Offcourse we are going to document both solutions ;)

Thank you
Clemens

--nextPart7797788.aG1P4gRxrl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwzwBsACgkQZgdHbA22lqNl2gCg0oMLRjjDzzMR/lFs5kLWVXZt
hzYAoMZeiGRTNh2l21or+Yah7ljUdmMP
=hbsN
-----END PGP SIGNATURE-----

--nextPart7797788.aG1P4gRxrl--
