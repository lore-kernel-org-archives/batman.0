Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:29:09 +0800
Message-ID: <1496082.2fkRiqZzWW@voltaire>
In-Reply-To: <1434890715-14370-2-git-send-email-sven@narfation.org>
References: <1434890715-14370-1-git-send-email-sven@narfation.org>
 <1434890715-14370-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1447911.aY7jJzCdjD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Add lockdep_asserts
	for documented external locks
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


--nextPart1447911.aY7jJzCdjD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 14:45:15 Sven Eckelmann wrote:
> Some functions already have documentation about looks they require inside
> their kerneldoc header. These can be directly tested during runtime using
> the lockdep asserts.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * add missing header linux/lockdep.h in fragmentation.c
> 
>  net/batman-adv/fragmentation.c     | 3 +++
>  net/batman-adv/multicast.c         | 6 ++++++
>  net/batman-adv/translation-table.c | 2 ++
>  3 files changed, 11 insertions(+)

Applied in revision 2a449bc.

Thanks,
Marek

--nextPart1447911.aY7jJzCdjD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn4JVAAoJEFNVTo/uthzAmnMH/3OEws+D9P6haKonhoFAU4hP
cUejpIfe4VAkey674Dj+H1U6g7XkHSQ6S3t1VEbntaAyh0rm9RGJXfK7JnObAXjq
tqPVLq6Wwa8oNeWzUuXNjYBN5zj90uoQfMSG14n7U2rupTbHoTc8fTQYqbLTcr+K
K27mha+xaO93WNbxddopVI9oB1UbeQnKFs/O1GorRV/5T+3XPzQFOH8Pa0BVHrx0
ztVWJaStY0pivWGMjoYNQIDHpLfaPyLvDy+wh1Ge8+109H5+10LU/A5qBRrQGbWs
Zo1pPSvsEc0evvxan5tznsdld9CAZYOHotx2GvbsYql4d9Q0ak4z+xEwAZRl3M8=
=e+By
-----END PGP SIGNATURE-----

--nextPart1447911.aY7jJzCdjD--

