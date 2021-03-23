Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint] batman-adv: Fix order of kernel doc in batadv_priv
Date: Tue, 23 Mar 2021 21:30:07 +0100
Message-Id: <20210323203007.11014-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

During the inlining process of kerneldoc some comments were placed at
the wrong struct members. Fixing this by reordering the comments.

Fixes: 6369b8e999af ("batman-adv: Use inline kernel-doc for enum/struct")
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---

Note: checkpatch shows me a warning:

```
~/dev-priv/linux/linux/scripts/checkpatch.pl --strict ./0001-batman-adv-F=
ix-order-of-kernel-doc-in-batadv_priv.patch
CHECK: spinlock_t definition without comment
#35: FILE: net/batman-adv/types.h:1665:
+       spinlock_t forw_bat_list_lock;

CHECK: spinlock_t definition without comment
#39: FILE: net/batman-adv/types.h:1668:
+       spinlock_t forw_bcast_list_lock;

total: 0 errors, 0 warnings, 2 checks, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inpl=
ace.

./0001-batman-adv-Fix-order-of-kernel-doc-in-batadv_priv.patch has style =
problems, please review.
```

However it seems to be a false positive:

```
~/dev-priv/linux/linux/scripts/checkpatch.pl -f ./net/batman-adv/types.h
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 10, in <module>
    import git
ImportError: No module named git
total: 0 errors, 0 warnings, 2410 lines checked

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

./net/batman-adv/types.h has no obvious style problems and is ready for s=
ubmission.
```

Checkpatch version is: e0c755a45f6f from net-master


 net/batman-adv/types.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2f96e96a..30c78e6e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1658,19 +1658,19 @@ struct batadv_priv {
 	/** @tp_list: list of tp sessions */
 	struct hlist_head tp_list;
=20
-	/** @tp_num: number of currently active tp sessions */
-	struct batadv_hashtable *orig_hash;
-
 	/** @orig_hash: hash table containing mesh participants (orig nodes) */
-	spinlock_t forw_bat_list_lock;
+	struct batadv_hashtable *orig_hash;
=20
 	/** @forw_bat_list_lock: lock protecting forw_bat_list */
-	spinlock_t forw_bcast_list_lock;
+	spinlock_t forw_bat_list_lock;
=20
 	/** @forw_bcast_list_lock: lock protecting forw_bcast_list */
-	spinlock_t tp_list_lock;
+	spinlock_t forw_bcast_list_lock;
=20
 	/** @tp_list_lock: spinlock protecting @tp_list */
+	spinlock_t tp_list_lock;
+
+	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
=20
 	/** @orig_work: work queue callback item for orig node purging */
--=20
2.30.1
