Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2016 12:38:31 +0200
Message-ID: <2789203.91ASHWIDJV@bentobox>
In-Reply-To: <1462962557-23950-1-git-send-email-a@unstable.cc>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2964070.q8o1DZ99e3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove forward
	declaration by including proper header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2964070.q8o1DZ99e3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 May 2016 18:29:16 Antonio Quartulli wrote:
> If main.h is included, the forward declaration for struct batadv_priv=

> is not required.
>=20
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>=20
> Sven, is there any special region for not having the include in this =
file ?
> It seems to be compiling just fine.
>=20
> Cheers,

We have some files which don't include main.h:

 * net/batman-adv/bat_algo.h
 * net/batman-adv/bat_v_ogm.h
 * net/batman-adv/netlink.h

There is a special exception which should not include it to avoid cycle=
s in
the includes:

 * net/batman-adv/packet.h

The reason for the other three is just... there is no reason I can prov=
ide
other than it was not necessary for these files :). But if you want tha=
t to
have "main.h" included everywhere then please do it really everywhere:


diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 03dafd3..b727762 100644
=2D-- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -18,7 +18,7 @@
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
 #define _NET_BATMAN_ADV_BAT_ALGO_H_
=20
=2Dstruct batadv_priv;
+#include "main.h"
=20
 int batadv_iv_init(void);
=20
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index d849c75..4c4d45c 100644
=2D-- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -18,10 +18,10 @@
 #ifndef _BATMAN_ADV_BATADV_V_OGM_H_
 #define _BATMAN_ADV_BATADV_V_OGM_H_
=20
+#include "main.h"
+
 #include <linux/types.h>
=20
=2Dstruct batadv_hard_iface;
=2Dstruct batadv_priv;
 struct sk_buff;
=20
 int batadv_v_ogm_init(struct batadv_priv *bat_priv);
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index fa152a8..39044cc 100644
=2D-- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -18,6 +18,8 @@
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
 #define _NET_BATMAN_ADV_NETLINK_H_
=20
+#include "main.h"
+
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
=20

Kind regards,
=09Sven
--nextPart2964070.q8o1DZ99e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMwunAAoJEF2HCgfBJntG69IQAIChoNA+03GEfJB6csG4voT2
r9Teq1O7+DqZC6SePtF3WSWbJYxkc6hDRLqRxAIr3xU1EpS0rYHDQvwIEUYFkqIu
D1Jo+VLps1cYAXKXJR00pm5nlWfAhW5Kf54+hnP2ZyLLCkIqPToGjWzmqDQHixP6
LMgClHJPkQadV+zdRtmIlYYvROdLAKw1715OVSdvfKh32FXyNyt1blMbWbWcY/8P
UhmTlIcKTAA+AMtCKDo65VgUu9Qj/ALO/wdBWDAktUuR67AZA9oXn4m1LEXn9feD
msepYjqN3JEQW1Ap/yvKoc9XdQZRxFbvJthzE/pGMPfaUBfPoYGCLCWaIFFMKId/
anqtlV0gv1YtwO03fSxn1yw4Uyi5xzqbCvhlVhq4uAXKCHxvmfSTooyt//EWUfQJ
MkyZ0oN+O5MdOcrsvfrartGM/jlx5+aeQQ4vVcjM1IltEKL1CMQcsEii8ACQPQs3
CWNh5QAahaJU2eM0R0l2100p+DK921ZW2SJahqRF86ms5LlGQgWeeTZNI8vcJZJC
VZl6bPq7Nt5T9rV9AVq3aVHNif7TbZhdOqbsBUsYLYnD5QbcuCaK+9OpWcCXVVMP
3I/nngMNw0pDVHusUy+nim8iF5ii9CIMNaydTUzkiNREuF8qAl7+7IOpE5wrZyG9
phJ2J4jisQw6q2bWL9vQ
=zJ1K
-----END PGP SIGNATURE-----

--nextPart2964070.q8o1DZ99e3--

