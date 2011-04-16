Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Apr 2011 09:54:48 +0200
References: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6824641.DljaMUkiyu";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104160954.49563.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix crash on module shutdown
	with multiple ifaces
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

--nextPart6824641.DljaMUkiyu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> hardif_remove_interfaces() removes all hard interfaces from the
> hardif_list before freeing and cleaning up any device. However the clean
> up procedures in orig_hash_del_if()
> (hardif_remove_interface()->hardif_disable_interface()->
> orig_hash_del_if())
> need the other interfaces still to be present in the hardif_list.
> Otherwise it won't renumber any preceding interfaces, which leads to an
> unhandled kernel paging request in orig_node_del_if()'s "/* copy second
> part */" due to wrong hard_if->if_num's.
>=20
> With this commit the interface removal on module shutdown will be down
> in the same way as removing single interfaces from batman only: One
> interface will be removed and cleaned at a time.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>


Please use --patience as requested in
 http://www.open-mesh.org/wiki/open-mesh/Contribute

Please show us (as part of the commit message) why the information in
 http://www.open-mesh.org/projects/batman-adv/repository/revisions/132b776c=
22c9b71962a3ed9a33e5b6f9218dae1b
isn't valid anymore and explain why it is save to use the spin_lock only
inside the loop (but it would have to protect the loop in normal situations=
).

Kind regards,
	Sven

--nextPart6824641.DljaMUkiyu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNqUtIAAoJEF2HCgfBJntGgZ8QAMrcOGeGaPncylBRA9LSDBI6
yA5qpHEjW1VGNhghVgTvrQXsTn5tMRzuHFeDKyfwMFk/GryZKbIv0wz6Khs06q45
LlrAstri99KYPdMRDb40qoc6gGhjeDnnPnU7Kda2YhbJLdmYckRLMCQ0G6XQy6bQ
2nZiDeTwTqf77N3zAgWUaktIDtWihlu9rK6wmfHsAXRk5MFMmBgXLJIoWgO/v62I
mvmE7Un2vZyOlOXYTobFQa5nbZQBw9KMezl5yI0fR+CMiukoYHYLnrJfWJ3UE6YS
SjPI3VZTiYFtjje+xnpaRn5EIBQVd6mbDZHmRagQz3Uj8G/73M8yZGyfX2G+7S9w
7r6VTcSKmxCn/mIzPfZb72+6TaE9z0jV9GV/69KdsCIKlibrdUcVBb7su/PJSVpB
Xb0+TtMXBPKJ2zZ7Q+ruMF83nNOC4bahUqgdh4KDMML78loZcnHFKCNIt59qpn4h
NfvB5AppMeFYBCDZPCjThN0g/mcZ6J4XNr+MsXqA0eIcRD85SrGrFmXTF8CTjZ3B
4Ia0By638oV21pKu9MDl9piQVD++oWHbM2J/gKvf2pMbc3tiuUt6dx8QUth8VSg/
G5NMC8RyCq7jTFdAa/DOWWjQr4BvFpRGriXuAlSseQubWLt26cpa7auBynmH+0Ua
t75CzkOW28szupA7q1+v
=Dgmx
-----END PGP SIGNATURE-----

--nextPart6824641.DljaMUkiyu--
