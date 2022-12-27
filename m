Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] build_test: don't warn about "Macro argument reuse" in
 multicast_forw.c
Date: Tue, 27 Dec 2022 18:45:54 +0100
Message-Id: <20221227174554.13168-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

It's tricky to avoid reusing an argument in a for-each like macro. This i=
s
to silence the following warning:

  CHECK: Macro argument reuse 'num_dests' - possible side-effects?
  #789: FILE: net/batman-adv/multicast_forw.c:35:
  +#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
  +	for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)

  CHECK: Macro argument reuse 'num_dests' - possible side-effects?
  #792: FILE: net/batman-adv/multicast_forw.c:38:
  +#define batadv_mcast_forw_tracker_for_each_dest_rev(dest, num_dests) \
  +	for (; num_dests; num_dests--, (dest) -=3D ETH_ALEN)

Later, once < 5.18 is out of our compat range we can rely on C99 syntax
and use variable declarations inside a for loop, readd the check and
rewrite the macro to something like this:

  #define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests)       =
 \
          for (typeof(num_dests) __batadv_forw_num_dests =3D num_dests;  =
   \
               *__batadv_forw_num_dests;                                 =
 \
               (*__batadv_forw_num_dests)--, (dest) +=3D ETH_ALEN)

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 checkstuff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkstuff.sh b/checkstuff.sh
index 207652ce4fbe..be49709dcb3b 100755
--- a/checkstuff.sh
+++ b/checkstuff.sh
@@ -191,7 +191,7 @@ test_checkpatch()
 			continue
 		fi
=20
-		if [ "${fname}" =3D "log.h" ]; then
+		if [ "${fname}" =3D "log.h" -o "${fname}" =3D "multicast_forw.c" ]; th=
en
 			cp_extra_params=3D"${cp_extra_params} --ignore MACRO_ARG_REUSE"
 		fi
=20
--=20
2.39.0
