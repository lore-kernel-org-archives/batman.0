Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 Apr 2016 15:50:39 +0200
Message-ID: <3374405.0Pi9Duaxya@bentobox>
In-Reply-To: <1458101205-26316-3-git-send-email-linus.luessing@c0d3.blue>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2127730.bgOsu6q9xh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 2/4] batman-adv: Add multicast
	optimization support for bridged setups
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

--nextPart2127730.bgOsu6q9xh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 16 March 2016 05:06:43 Linus L=FCssing wrote:
> --- /dev/null
> +++ b/compat-sources/net/bridge/br_multicast.c
> @@ -0,0 +1,33 @@
> +#include <linux/if_bridge.h>
> +#include <linux/printk.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0) || \
> +    LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3, 16, 0) && \
> +       (!IS_ENABLED(CONFIG_BRIDGE) || \
> +       !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
> +
> +int br_multicast_list_adjacent(struct net_device *dev,
> +                              struct list_head *br_ip_list)
> +{
> +       return 0;
> +}
> +
> +bool br_multicast_has_querier_adjacent(struct net_device *dev, int p=
roto)
> +{
> +       return false;
> +}
> +
> +#endif /* < KERNEL_VERSION(3, 16, 0) ||
> +       * !IS_ENABLED(CONFIG_BRIDGE) ||
> +       * !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING) */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
> +
> +bool br_multicast_has_querier_anywhere(struct net_device *dev, int p=
roto)
> +{
> +       pr_warn_once("Old kernel detected (< 3.17) - multicast optimi=
zations disabled\n");
> +
> +       return false;
> +}
> +
> +#endif /* < KERNEL_VERSION(3, 17, 0) */

Why must there be a special compat-sources/*.c file for these tiny
functions?

Kind regards,
=09Sven
--nextPart2127730.bgOsu6q9xh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXBmWvAAoJEF2HCgfBJntGjQkQAKkKmeywhfYjdy01dQHMfjKS
OU8TsCdErArZjIhQfnv2d9OP0cx5QWGeCEwCOgbFfw82pCf0caFqxxJDRpRlUUUh
iKTZxqKXX0s3viK9ZzQ3lDB311woD+JNgFptzXiJOmuJxJkItsKJdNbM7JPEtnz2
vYBKcS6yddF23MeGyxG9kxEUtEy2CPP2j72GZwd1RqDMdUUxS8Jb5xYKvbNPQ6eR
6xm46/tbdDf754TfWEpR0USV5bA6DK0LDHah8AwEYlEW2pV61LAm3MscgeGM+Ih2
qGHBqlnqspq8CnCRCDFMe+dUr6oOcuPmUbPFkrUAeFdCtpiJTXli202t1GOSv1WK
2GlBjSiH0Ao9Go7WHlw9Pq6sJvMQmtvQ/5cwqViEf9eq/fuGcE3ewVk6YfdF958l
MlCZUfTv6Q2minKTIkwvL28QssLsHDYmC3qK9AfDQhfMYJPrEILQAHLJtzL67V+g
RaMjc3gZ8O4/qIEMijf8yecf/N12j3oNgQ/iiJE8BJ/GZGz2lIVNJl9/RqrYdYHw
jJXUDK2/UHPLBL2r/WL+I333jIF9NYQbYOnV3Q9WmQ+GgOWHqaJ+m626cUeWvmf2
uX1FGUIaztmCOIVRv152UhA5TxJ2o3apNydR1q2WF/4h2iJtnc+W0fvPeH+y4ova
L+jFK1SdO5TsWvJv1v2+
=macB
-----END PGP SIGNATURE-----

--nextPart2127730.bgOsu6q9xh--

