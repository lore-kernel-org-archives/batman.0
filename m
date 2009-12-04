Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 4 Dec 2009 14:42:07 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1751240.ZAiVohoN35";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912041442.11944.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Missing depends in staging Kconfig
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1751240.ZAiVohoN35
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

just did a small test an I think you must change the Kconfig for the batman-
adv for staging. I am not 100% sure what is needed, but we definitely need=
=20
PACKET or otherwise batman-adv will not be able to create a raw socket.

More information about that can be found in
 linux-2.6/Documentation/kbuild/kconfig-language.txt

Best regards,
	Sven

--nextPart1751240.ZAiVohoN35
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLGRGwAAoJEF2HCgfBJntGZVkP/jeWmSZyoAj5bhhusw6vymwd
zqVPxn7m+KUWVzZb50F6PvVfTCuwy6ziCzADAYqtvfQ0pUF3zyqvGd3MbdaKzBka
we+Ij22od83bP56+O3dcjEM333z+/LM+JPW7PcH5RARGpMss2FPfMkYe2ww2hdbg
qjvXGSsVO/dd/vRAhGz3wQObtrsavtU+2v3MAGqiarw8BcVFRwK5UlM1zhkuhdJY
eHxKXaz+NCMzyZKn8q66Qo6QzzdDz1vY2HZhV/2TcuE38IgPp10mOqoAVNKqyRq/
s6I99OXeyYHCXpDou3uymn94giUBpqB5vuUGwSkn08YD/406Pyfwzc28fYt3jAN8
NB00zaUNEScHhFX+kJGhcAqNB1lu7EG0dxBy2Rf7Y6j6wyyQer+kT6d0edr7Mi49
fbe3/K/I/RDAGcMDMBUSLEhMZxMv8bfGyRzKpYPd7Rcj9ZNpD3Cs74b7yNrqjg/U
NyjL1pddRlm1mU65ZVJ9wDpY8yt0WSYt7yu8NEIMr3TORLoTazhNjdgYNlhlH0VQ
9cOprcxxKEjp3/YjLqmIh8Qskb432Po2AZIRoOkPoF+7JdLeUU9lnVffz2lrGqs5
cv786cp1IFALxbbX8i5o+LBRBza0LakixA6MzG4N0/1dW/vL2OGBlxFqGAjfbk4Q
Z/nSKKX5hsZDWGV4sKg1
=bHTx
-----END PGP SIGNATURE-----

--nextPart1751240.ZAiVohoN35--
