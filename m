Date: Sat, 17 Nov 2007 13:14:01 -0600
From: Jan Hetges <tran@ms20.net>
Message-ID: <20071117191401.GA4836@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] adding network announce
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi=20
is that supposed to work?
at least, first it says it does, but second it doesn't:
root@bla:~# bmxd -c -a 172.16.x.x/32
WARNING: You are using BatMan-eXp 0.3-alpha rv802 (compatibility version 9)=
 !
adding HNA 172.16.x.x/32, atype 1=20
bmxd -r 3 -a 172.17.x.x/24 eth1:bmx

(172.17.x.x/24 is the network already announced at startup)

cheers

  --Jan

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPz15lTtvZdk47D4RAqczAKCze6+8zh5ydQcdZZqrc5LrC+rhXQCgkhg6
BOUXSQTlNjq4TtlbADVcb5w=
=hXAc
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
