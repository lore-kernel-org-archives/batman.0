Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 May 2011 21:09:35 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1305032531-20493-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305032531-20493-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart652837563.iB9vk0FU00";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105172109.37942.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/3] batman-adv: improved client
	announcement mechanism
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

--nextPart652837563.iB9vk0FU00
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Nack

There are two many small things that need to be changed. I didn't to a
complete review, but at least the primary_if dereference is unacceptable.

=46rom IRC:

<ecsv_> could you do me the favour and go through my cleanup patches and al=
so fix your code... it is too much to send every problem=20
to the list
<ecsv_> and the kfree_rcu patches will be merged soon in linux mainline... =
so please prepare your patches for that
<ecsv_> and why is there still an align in batman_packet - this doesn't mak=
e any sense
<ecsv_> and we already have functionality to do the before-after check of t=
he ttvn
<ecsv_> and you try to dereference primary_if (without using  primary_if_ge=
t_selected) directly... this is not allowed

Kind regards,
	Sven

--nextPart652837563.iB9vk0FU00
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN0sfwAAoJEF2HCgfBJntGOkwP/jNVfvooc2yXPhf9TwTwVMjq
XpamIUW6kzeylhBuzLYN2cHLVi+RzTrSWJ4X9RIJ2y3zUiF+6DUK59DhaKGkF50u
ka9ew/AhWXUn0gZRZThBy5u3+i5sh9ZF4iLshNJAVW+MSzd81qNNXCyrD0fmbwXx
eDqnQE94kQ383CeMlnEHsjU9nLuQ+255r9LHWxnnyh0zylZOlnt0MOmnTesuUFH1
eOnzIigQkdLqOCyJFU6XxGKk2bFyAYuuNqgt3pKegAI4YDkzAjJdDn0RGYb2qiKF
zHJeNJ/W2tjjWN9N5qiyMHLi21ivPUgRu1utmMLAq4dASHlQpE1PMSwydiH6OEwy
Vns/ebPEoZjfvz/PRdlMTDs+EvBGF8IR7D6rbiken3ikX1tENHSg7sPDmuV8PFOm
8lyLOU1aV76WbfMX0bRTxGn9eA2s7+4W4jCdHQRSOv93L+LuRK1cPgYuB1MMssy0
pfT8o1XNCB8sraHn8E0uYAwZkOCB5YaM/rqYHMgFC98LxlEl89IrDURyYPkV0BgH
4N6t5lOczlqcWZNvoGJjB+uXZhHruRcpTxQTKeUfRTUA23CpVAp2qfefTYcGgYEQ
oTZTF0pDawlh3O4Dq2BEfC2G7Xq4EMCbl3M83Yz92NqW7g6fuhnRXN/DXFupdVzh
VHL6Wd8UqkaXkWHBgxP8
=0c1J
-----END PGP SIGNATURE-----

--nextPart652837563.iB9vk0FU00--
