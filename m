Date: Sun, 1 Jun 2008 20:29:28 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20080601182928.GA12822@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N. wireshark dissectors available
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


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf8
Content-Disposition: inline

Hello,

thanks to Sven Eckelmann we now have Wireshark [1] dissectors available. :)

You can use them to analyze B.A.T.M.A.N. traffic in your network, it
dissects the protocol information of the incoming packets.

The dissectors are available at our tool download site[2]:

http://downloads.open-mesh.net/batman/useful-scripts-and-tools/wireshark-batman-adv-0.2.0.tar.bz2
-> Dissector for the latest batman-advanced (layer 2) revision
http://downloads.open-mesh.net/batman/useful-scripts-and-tools/wireshark-batman-0.2.2.tar.bz2
-> Dissector for batman-0.3 (layer 3)

Development is going on at
http://gitorious.org/projects/wireshark-batman and
http://gitorious.org/projects/wireshark-batman-adv

It is planned to contribute the dissectors to the upstream Wireshark soon.

Regards,
	Simon

[1] http://www.wireshark.org/
[2] http://downloads.open-mesh.net/batman/useful-scripts-and-tools/

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIQuqIrzg/fFk7axYRAtzpAKDfVIvFmeEUrvzVPlz8egMP+uUkkQCgjj4X
gsCctYw273vjiLrh8M7C+c0=
=VfvS
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
