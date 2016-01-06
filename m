Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 07 Jan 2016 00:12:16 +0800
Message-ID: <2479138.RDhDv8WkTO@voltaire>
In-Reply-To: <1451992006-13191-3-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2317101.eDGVPmYztp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 03/31] batman-adv: Avoid recursive
	call_rcu for batadv_bla_claim
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2317101.eDGVPmYztp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:18 Sven Eckelmann wrote:
> The batadv_hardif_neigh_free_ref function uses call_rcu to delay the free

batadv_hardif_neigh_free_ref() ? Not batadv_claim_free_ref() ?

Cheers,
Marek

--nextPart2317101.eDGVPmYztp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjTzgAAoJEFNVTo/uthzAREsH/iuAhczbf48Q/LqbvI8ZtdeV
kFQ6Zf2knlQm5MmueLdZAGTs2dJomUMZ1nVDRnSQCWYCM+fGk88HT58nh/OFleJe
wtp5U1ABJHiTjAsG9V78bqrDx5pysrZO889xvamu0JLg5h8keRpo/BxtB6r4ScXp
coJ+8zi6EMqXb39KXvHuFjpJ/tWHlv2z35LKjtGmM/aKimY6apraBVPK0GOJlxXL
A81kEL5Kl4Y6MjbevW49JMUYgicRrY+7VQdMbv1VO/v+kD4cDpNVKQdJ2BuHQqRR
R0fZvtL3YdSM1obSU8xeK1XWNsu9d01AMvPgVm8Cqoo1MenpdAKILWHPSBB5M7Q=
=W2gc
-----END PGP SIGNATURE-----

--nextPart2317101.eDGVPmYztp--

