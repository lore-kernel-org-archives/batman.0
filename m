Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 27 Jun 2010 18:15:35 +0200
References: <20100627172416.62e7554d@rechenknecht>
In-Reply-To: <20100627172416.62e7554d@rechenknecht>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2364451.NxtxFzjxer";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006271815.37040.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] PATCH fragmentation of unicast packets
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

--nextPart2364451.NxtxFzjxer
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andreas Langer wrote:
> If fragmentation is on, the mtu of the bat interface will be set to 1500
> and bigger packets will be splitted in two parts. The receiver stores the
> packets in a buffer list for each originator, which will be created with
> the first fragmented packet. For this handling i added a sequenznumber and
> the orig address to the unicast_packet definition.
>=20
> regards,
> Andreas
>=20
> Signed-off-by: Andreas Langer <an.langer at gmx.de>

This patch cannot be applied because the mailer added automatically wordwra=
ps.
Either find a way to forbid such a behavior for your mailer or try to use
git-send-email. There are explanations how you do that can be found at
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3DDocumentation/email-clients.txt

And please try to check your patches with checkpatch.pl from the linux
sources. You will notice that you've removed a newline after the function
bat_set_rx_csum. This is important because we try to submit those patches to
the mainline linux kernel.

There are also other styling changes I don't understand. For example a newl=
ine
before create_neighbor. I haven't checked really more as I couldn't apply i=
t.

And can you try to add [] around PATCH in the summary line and remove the
regards... stuff from the commits message? Otherwise it will be part of
the commit message and the patch we send to the kernel folks.

=46or more information please read
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3DDocumentation/SubmittingPatches

Best regards,
	Sven

--nextPart2364451.NxtxFzjxer
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMJ3koAAoJEF2HCgfBJntGB8MQAIayM92nNh/WVz/S6qXfrgAs
RQAN5fnxqgL0/FmuzerCeDKzApQWxoORYIpNmU2uoJhly7WyPJumsGOGWmwT0mf4
4ONkNPBdNLUILjKkVo6KrFjfjRcElPIXcoU2ggPD1FsQEjrCdC3uMK0mHJEDdu9R
uWH4M9DIOvoVqzxHjTEs0v6Gwv3nt5g6fyjHYOwTSf5Kfj0WwjqUCyAOynwuUcKA
ghRx4/5tK/yCMEQP79oO/d+v1sIJLbJmo8mGGoHppgqWitZEi4ou3ylVSawQ27TH
bzLuWnR4G38Hr2SxzF3SqehZmYpi0vZxUWAfxBpmSiwIzw18GCnk3IkvhIW5R7A5
+D/RF0vWj2eALEkdvKTYcwWnWcafHZH3u3mhx7356wp3xWAulk/AJXgn10vR73Sg
PAHrRo7cg4IEcrtWHGoVzkdnNof7WjU7dRm/qSYEtNWZX4z5qjcuQNe+mgYETg5N
3Tg93NyBH1l6LCXGyjV1EwpIe0k4HFFk1mmUtDn3TUl6eHYYzosA4PlOX3ka8fGy
CSJuWTEULc36+T293FQQ5w5UEL6IPqppUZFbJvoWA4+DYmAT7FNSrMRY/4Z+Klom
QPOTMI8+jDYG7/dQrU8baiMiX83kEaodfQ4xCuTGxuQf23eBsIZIIlKRJ+zLUR97
bRU/3jQ2atp372MwfFJe
=458N
-----END PGP SIGNATURE-----

--nextPart2364451.NxtxFzjxer--
