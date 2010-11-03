Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 3 Nov 2010 11:12:12 +0100
References: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
In-Reply-To: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1988295.zTvOpfjHI8";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011031112.20044.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: Use
	linux/etherdevice.h address helper functions
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
To: Tobias Klauser <tklauser@distanz.ch>
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.org, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart1988295.zTvOpfjHI8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 03 November 2010 10:59:02 you wrote:
> Replace custom ethernet address check functions by calls to the helpers
> in linux/etherdevice.h

Have you proven that the addresses are always two bytes aligned in memory?=
=20
Afaik this function needs it.

> In one case where the address was tested for broadcast and multicast
> address, the broadcast address check can be omitted as broadcast is also
> a multicast address.

We need to distinguish between these two types for different optimizations=
=20
(research is currently done for multicast over mesh - but currently not par=
t=20
of batman-adv).


Best regards,
	Sven

--nextPart1988295.zTvOpfjHI8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM0TV+AAoJEF2HCgfBJntG9LQP/3Z1vj4V4d6pJjpWQXSpvj8x
dvAp9FIbhC73S1dQbxG+BsuXVmODoIczYs4MeyDgyblhrQGRBFHze9huE/5j8kIb
Cvy97mcWwkDDjZphxQJiRWiC8UJ8A+GS1ojHxexyDeQqBcxej7uFDjA+5fX6bo6u
Y3I32f2Iy7Ja+b07CopTDYu/AUHFUrV/W9WQQG3a6yYxUsDSm3nZj5PkLe64w2/h
52anyMv8P1Twvl/oUNj2SRrAcJ+Mz8AvFhbWZtB63rCR3u0whVd+MMRP/DrB55x/
FY1KJBe7o12qLmj9B1/fV2RAeSwcb9HmCUlwbSBWAm0N3GdSsyGz667EMVIDQmhH
l0oeDM0o3EPAZcBOAo250kDUu4KnTleovAtSSlh7tet87H0+r39aB+I+V2LlYWCm
aTeoAKShIZgiOQ16HNJ5otP49WdXJRm9MRrFKGYEr0CAANYdNepf3wkFEPRiKOTA
zgPz/nb67gq0WaWFKAJiPKyPBu3uEB0t4+7v8rAj3AYSiNBv/yJe1nRhjqoFlCNQ
m9/MImWXqONlrpAjWUaB7/biwKrIPODb28Z9bwULeyqlPZJ65chP4awLxwnhHb3W
FtavXICa0k3NEAsJnWCVI6AhIHy65Fnlp+gQ/F0RwTIdqJxlaZ4R2NxpGCw5Toby
y7aD4dOwVAl2k/Z69CQs
=TOnc
-----END PGP SIGNATURE-----

--nextPart1988295.zTvOpfjHI8--
