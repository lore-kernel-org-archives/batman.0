Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Aug 2015 20:49:26 +0800
Message-ID: <2835831.4kMXp0CIbH@voltaire>
In-Reply-To: <1438693798-21807-1-git-send-email-mareklindner@neomailbox.ch>
References: <1438693798-21807-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1794176.HjmC8eNGJO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/4] batman-adv: add list of unique
	single hop neighbors per hard-interface
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


--nextPart1794176.HjmC8eNGJO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, August 04, 2015 21:09:55 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> v3: prevent inconsistencies when adding new neighbors
> v2: last_seen added & checkpatch cleaner
> 
>  net/batman-adv/hard-interface.c |   3 +
>  net/batman-adv/originator.c     | 156
> ++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/originator.h     |   7 ++
>  net/batman-adv/types.h          |  22 ++++++
>  4 files changed, 188 insertions(+)

Applied in revision fed2826.

Regards,
Marek

--nextPart1794176.HjmC8eNGJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVw1faAAoJEFNVTo/uthzAsvcH/Al15aa4lzkj7wZ5aYHxHXYC
w3Gclv6s9FW01Y3dO4GOma5pflERrsk/8jVbYX9+WrJsUwQkXNl5tYqv51SArHJz
4gm927rcZP+e6AXtP4JMw9+EK3i88dQwxCv6DRwpq5KHijCCzz1gJTq96hybj6Bm
jLmIB3EHQaKnm1Jg4GvR85cu9ECEu6p2H2IUmahCDHTsTolUAT4LwN+Cvuy3oyKG
T+yt9EB0eDW9Yvn1bvZlgLdCzKF/FcgU7cgYEvRTpCDeUBuDtVEyR0y3v1r2skIP
IX5q2ND3UvA4isIUz2kXxz4s08O/DfRSOX2maJbKRGzx2WHAkFkVGr9i+MDjJkI=
=jeeM
-----END PGP SIGNATURE-----

--nextPart1794176.HjmC8eNGJO--

