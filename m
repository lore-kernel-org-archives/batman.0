Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:30:11 +0800
Message-ID: <3592560.On8nZlICRS@voltaire>
In-Reply-To: <1434892984-14142-1-git-send-email-sven@narfation.org>
References: <1434890715-14370-1-git-send-email-sven@narfation.org>
 <1434892984-14142-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3991593.SJq6j0hXPO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: Add compat code for
	lockdep_assert_held
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3991593.SJq6j0hXPO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 15:23:04 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat-include/linux/lockdep.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 compat-include/linux/lockdep.h

Applied in revision d5e1bbd.

Thanks,
Marek

--nextPart3991593.SJq6j0hXPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn4KTAAoJEFNVTo/uthzAnlYH/ApfjYko5eo/q3bNqvd+FYfA
l4o7WhEUgj4XoR3Mk1G9j8i4tqO6hfja/e1PxclI9W0mvx8GPb9JayP5jFLLrdLz
0/zenkga3f7gu1Wr8mieoLjA3y+i0gcROhKfsicLelyQeP7uA37toQNKXae4epqU
3Utzb9poQS8/iX3N9MgqL/ct3BfN4nh3dFdlq0b4ieZHRNWzfS//kQvXTTQQppUC
ShI9uAfaAzIgDD/w9WFk46jsrc+yKpa9m4jPl6BXPL0s/PxDUAIe6y2YI2rrAyNU
0ZoOBKYbS8y1Z+Cq9x9jNhlU2AIVKmvoSzvi8ZdIfJEDxzcCD1WHQizxL/cyuvs=
=031g
-----END PGP SIGNATURE-----

--nextPart3991593.SJq6j0hXPO--

