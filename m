Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 12:58:49 +0800
Message-ID: <8467251.HL6ZlSX63A@voltaire>
In-Reply-To: <1451992006-13191-5-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5808567.9gNoBDS1kP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 05/31] batman-adv: Drop immediate
	orig_node free function
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

--nextPart5808567.9gNoBDS1kP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:20 Sven Eckelmann wrote:
> It is not allowed to free the memory of an object which is part of a list
> which is protected by rcu-read-side-critical sections without making sure
> that no other context is accessing the object anymore. This usually happens
> by removing the references to this object and then waiting until the rcu
> grace period is over and no one (allowedly) accesses it anymore.
> 
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_orig_node_free_ref.
> 
> Fixes: c8bda218468a ("batman-adv: Fix rcu_barrier() miss due to double
> call_rcu() in TT code") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 88e1624.

Thanks,
Marek

--nextPart5808567.9gNoBDS1kP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmc4JAAoJEFNVTo/uthzAewsH/3pJKENhb1p+QlMz1NItx0xT
Ql3429rQ/JqMuXdkLnAYeR5Cg2AJ+LI3ap3vj9hJXgk/zpNGbyRu5KoHy30yTNFN
RH1qUww7E7MfOZCwvXXYCWUWCzFxpua1bRitTTMM2aH+AnNG60dQGZ1gM2D3Wg+K
jjfzQ73gfAI+TesIU9RM7p25OmQ7E4CxN+E4qLPm1ePOGL2BKr5Pb/VX1B+yOIuy
aBqJ/kIR3cxwXRDa4wcTKHDBqBDli8qNteZp7mNAjF3f4zmNRrDlkqCr14+yJI6Z
JGjMszbe+KxnJsRbPb+V8Xd973TXVJ52TxryX/5266W9gjHQCSr4HFXdXiY9fII=
=VgKc
-----END PGP SIGNATURE-----

--nextPart5808567.9gNoBDS1kP--

