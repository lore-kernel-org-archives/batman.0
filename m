From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 8 Apr 2009 23:30:27 +0200
References: <20090408205926.GA5316@chunche.ms20.nix>
In-Reply-To: <20090408205926.GA5316@chunche.ms20.nix>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1634253.CLRt2OpbG2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904082330.28300.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] bmxd rv1197 changelog
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

--nextPart1634253.CLRt2OpbG2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 08 April 2009 22:59:26 Jan Hetges wrote:
> Hi Axel
> http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-a
>lpha-current_sources/CHANGELOG this seems to be empty!?
Thanks. The autogeneration of the changelog is easy to break. If you want a
recent version of it, please visit
 http://www.open-mesh.net/log/trunk/batman-experimental

I don't know how exactly the current version of the script looks like on the
server but a line like this should be the problem:
 awk '/View revision/,/10\/01\/06 20:23:03/' changelog.txt > $(FILE_NAME)/CHANGELOG
The format of the trac log changed in such a way that it isn't compatible
anymore to this script. Maybe it should be replaced by something which builds
on top of
 http://www.open-mesh.net/log/trunk/batman-experimental?limit=999999&mode=follow_copies&format=changelog

Best regards,
	Sven

--nextPart1634253.CLRt2OpbG2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkndF3QACgkQqQGwKVlMoDssWwCePiTxZMtlAjQ5Il98stL5+Xul
KzoAnja4+9QTGKzK7rPEOS+qddQKuxP3
=aQa+
-----END PGP SIGNATURE-----

--nextPart1634253.CLRt2OpbG2--
