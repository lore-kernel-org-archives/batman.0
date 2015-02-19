Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 13:35:23 +0800
Message-ID: <2621923.3aVJ40SYcy@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7118432.r3sj3hsGxB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] checkpatch: CHECK: No space is necessary after a cast
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Joe Perches <joe@perches.com>, "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>, linux-kernel@vger.kernel.org


--nextPart7118432.r3sj3hsGxB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


Hi Joe,

we have come across a checkpatch false-positive:

>>>>
static void batadv_recv_handler_init(void)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(batadv_rx_handler); i++)
		batadv_rx_handler[i] = batadv_recv_unhandled_packet;

	for (i = BATADV_UNICAST_MIN; i <= BATADV_UNICAST_MAX; i++)
		batadv_rx_handler[i] = batadv_recv_unhandled_unicast_packet;

	/* compile time checks for sizes */
	BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);
	BUILD_BUG_ON(sizeof(struct batadv_ogm_packet) != 24);
	BUILD_BUG_ON(sizeof(struct batadv_icmp_header) != 20);
        ..
}
<<<<<

The following warnings are triggered:

CHECK: No space is necessary after a cast
#440: FILE: main.c:440:
+       BUILD_BUG_ON(sizeof(struct batadv_bla_claim_dst) != 6);

CHECK: No space is necessary after a cast
#441: FILE: main.c:441:
+       BUILD_BUG_ON(sizeof(struct batadv_ogm_packet) != 24);

CHECK: No space is necessary after a cast
#442: FILE: main.c:442:
+       BUILD_BUG_ON(sizeof(struct batadv_icmp_header) != 20);

Can you make a suggestion / patch for checkpatch to better handle this case ?

Thanks,
Marek

--nextPart7118432.r3sj3hsGxB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5XYkAAoJEFNVTo/uthzABk4H/3K5BYigogqfUPD/yztgTAUJ
iaOWKmpHTkVvRnnBiB+hDXTmERMpBuIWvnndCO4ewU25DtgJCr9siK+3m4UM9gr7
jdgPYGcKwxVfokJ/4Qb3jNYV1N8j9NFbir9PT1Q202s2Sgmf0RStbx0DmWIfxnx3
h6AX62ZXtx6LBjmVRmFVaih/ZCRYtti840w1uLwlWVbPzXrCXyHUc3Zj8PouiUIt
GUI9R8troDfDUGMp8SnJvqSaVoNttqtwQZe/JXoKCycCUUF5W/UESCHRurUT79YF
JXO0lVjwkQw6agYc0x61xmlVYZhuPXCfSgpXnNntpsbdPalNaoeZGFnGlE5YKyc=
=FOGe
-----END PGP SIGNATURE-----

--nextPart7118432.r3sj3hsGxB--

