Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 13:17:08 +0800
Message-ID: <1564058.lsq1E5ZD8y@voltaire>
In-Reply-To: <1451992006-13191-7-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6073879.47bQ6EYi7v";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 07/31] batman-adv: Drop immediate
	batadv_neigh_node free function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart6073879.47bQ6EYi7v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:22 Sven Eckelmann wrote:
> It is not allowed to free the memory of an object which is part of a list
> which is protected by rcu-read-side-critical sections without making sure
> that no other context is accessing the object anymore. This usually happens
> by removing the references to this object and then waiting until the rcu
> grace period is over and no one (allowedly) accesses it anymore.
> 
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_neigh_node_free_ref.
> 
> Fixes: 9bb33b8d88e3 ("batman-adv: split tq information in neigh_node
> struct") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 977871f.

Thanks,
Marek

--nextPart6073879.47bQ6EYi7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmdJUAAoJEFNVTo/uthzAmzMH/jWi5tTzHJCKfy1fBLGIkd7s
Mq98X2ViS/N54iDvH5QNSCXGG8NdQIvu45mWAtS57vRjMmvs4x+yheN10dc+6weu
sbFu/wNqNuRHEYNZPUkwA/HhnRna2AAktdcmG4IHn/gJB0nnCUvSAdWXPJcA+aPs
srr4PWxcRqcIh2L2VtKValtbIZbAlOYeRMh+wEnakIZF+KpAu61ywQy5A4AtaO2v
bdy8D72fr6qtfe3DySLbmAKBxcXmWm8Ph1Vfv0D8eNnCRRXyF+kQ9YUmJFOON1XH
tEdy3mfovYYqTbhz0do6z4gJafBGSez0jZylhaSQ5r6AdbkSjqG18Kzu7TyAHLI=
=jdWf
-----END PGP SIGNATURE-----

--nextPart6073879.47bQ6EYi7v--

