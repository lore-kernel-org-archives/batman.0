Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Apr 2015 19:41:16 +0800
Message-ID: <1805214.Qm0AeeOjGh@voltaire>
In-Reply-To: <1429613108-19928-2-git-send-email-sven@narfation.org>
References: <1429613108-19928-1-git-send-email-sven@narfation.org>
 <1429613108-19928-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3012503.xKyRptyfcX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Add Kconfig to the
	sources
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


--nextPart3012503.xKyRptyfcX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 12:45:07 Sven Eckelmann wrote:
> The Kconfig file is not used by the out-of-tree module but it has to be
> modified when new patches are added which would modify it in the kernel
> tree. Otherwise the information has to be stored somewhere else until
> someone submits it to the Networking maintainer.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3: No change
> v2: Moved from main patch to extra patch
> 
>  net/batman-adv/Kconfig | 70
> ++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 70
> insertions(+)
>  create mode 100644 net/batman-adv/Kconfig

Applied in revision c69c935.

Thanks,
Marek

--nextPart3012503.xKyRptyfcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVPM7cAAoJEFNVTo/uthzAi9oH/A83hUO9vS28jiPWbmS12vH8
4hMseY31fNToJf4g6akj1CymIchUguS5smhm5rjolXP2bUYuOFnPvINnSdpm+ZJa
J8eq5YOXy0EjAx2lA2cBS30bjMoMQ30ai2IZjHkp+JhsF1wMeE1bMy70TrKAOP2q
+hbG/+Xirnh2aYBLSmxGkA3aNKYIN1Y7bRPWpK/qHtsgfrpKLjFhJutgPj1wwS+8
tCDuchb4eZJdI/RYRBvAeLLYAtbaKt9r3kRrFF56DZxi6GDjvDrR5fmioCy7WT/7
chT00Ixxlg6YGjMWjDSlwM/lxWDPq4BNvWoqiUWEVy0ygxS7Sjd7bk8LKyzA+Z0=
=E4ec
-----END PGP SIGNATURE-----

--nextPart3012503.xKyRptyfcX--

