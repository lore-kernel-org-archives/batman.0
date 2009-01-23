From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 23 Jan 2009 11:19:52 +0100
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<278AF6CA06F13D4C9E9F69C7B9AB3B8303504623@MBX21.stu.nus.edu.sg>
	<200901231109.27846.sven.eckelmann@gmx.de>
In-Reply-To: <200901231109.27846.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3410440.g8hsD9ahN8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901231119.53205.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart3410440.g8hsD9ahN8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 January 2009 11:09:24 Sven Eckelmann wrote:
> $ ifconfig ath0 $IP
> $ ip a add $IP brd $BRDCAST dev ath0
Ok, definitely need some sleep. Please merge this one to:
 $ ip addr add $IP brd $BRDCAST dev ath0
or just use elektra's "ready to go" configuration.

Regards,
	Sven


--nextPart3410440.g8hsD9ahN8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl5mckACgkQqQGwKVlMoDvnswCcDUtsST+eq2vn2ooHR34dF6dH
po0AoLu1H4rlBtgChjh2nks8pUMLTz1V
=HEQu
-----END PGP SIGNATURE-----

--nextPart3410440.g8hsD9ahN8--
