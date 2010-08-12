Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 12 Aug 2010 13:29:28 +0200
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121250.07216.lindner_marek@yahoo.de>
	<AANLkTimnri5HYfhPWEhvwGsoaKzhSn6d2MvrRjV8KVQg@mail.gmail.com>
In-Reply-To: <AANLkTimnri5HYfhPWEhvwGsoaKzhSn6d2MvrRjV8KVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18318329.L9YVB6BoUz";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008121329.29995.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
Cc: David Beaumont <djb31st@gmail.com>

--nextPart18318329.L9YVB6BoUz
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David Beaumont wrote:
> Hopefully attachments come though ok?
>=20
> net_ is from the router connected to the internet
> mesh_ is the other side of the mesh

to the mesh thing:

 * Why has ath0 an IP... which also conflicts with the ip range of bat0 and
   br-lan?

 * Why has bat0 an ip when it is part of br-wan.

 * Why has the ath0 device iptables entries?

to the net thing:

 * why has bat0 an ip when it is part of br-lan?


Why don't I see masquerade anywhere in the iptables output (-t nat)?

Best regards,
	Sven

--nextPart18318329.L9YVB6BoUz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMY9sZAAoJEF2HCgfBJntGu1kP/2LdTUwJdQ1C2zRTya5TITru
WcClgrcLu/JbLJL2LrHg7idTD4lRlVP2jtp5K9Ni6VUValGUNsvKCLQyhpZcglld
zooub4QH0jE7XKX60e3tYhtacCVsuV+zdcoZQC7b8B6L8anb8tHoEqe9cUICGxvO
jTxFDM5e5OjACeyueF+t6mvQxutxPoWHy8C/HO3Hjn+WCWtHrPs71x463wmrvWVF
EqVoBhTyCuBXFPcHVbfiDl4o6wjG6gRBDEgES1AZvk2Z46K5fhYTQO9SrryiEugf
MA39xx1q3m27ypmE5IGcZepkwBirEtcixU7m4FOIIndOjRpuVe8LYFX7sjQw5wXA
AH3NMz/lEc9Sl2eQfEE95KD/Uxe3mC0mGrf8TkON6kst8ipMc/+FnhF/DDGMGWlE
eCH9QE+XAOdcFP5DFCvG4HuWyo0ybyQTYkrPyws8jkH1553GsAVsO+3HsRMB3auq
ulULT/SWQ0Rh8MLBYEraTtwoIWH42fkKlt65oQJQ4Im5S/Zz4POBNhZZgvf9UF8U
7y1P7QWLcqlHtD5T91yR5wMAvZtAL4QF+Dm0rg9bQoApzMgDTvHlAVbo9lQPMJ1L
ebSrMmUR1yORU/8JbL67qsxLUbTYymzqos3LJwHGeEYZHSknK/m/gribcrob4AJ8
h4bWulCUhcmM/E6A5GjM
=MRds
-----END PGP SIGNATURE-----

--nextPart18318329.L9YVB6BoUz--
