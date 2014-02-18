Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 18 Feb 2014 12:03:55 +0100
Message-Id: <1392721435-7461-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: make the use of braces in
	if-else consistent
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

To avoid confusion, the linux kernel coding style discourage the use
of one if-else branch with braces and another without braces.

Introduced-by: 65d8217193427026169c48112c561c5ca4d1bd18 ("batman-adv:
compat: fix null pointer exception for kernels < 3.9")

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 compat.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 7beba36..0ceb2b1 100644
--- a/compat.h
+++ b/compat.h
@@ -167,8 +167,9 @@ static inline int batadv_param_set_copystring(const char *val,
 		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	} else \
-		dev = NULL;
+	} else {\
+		dev = NULL; \
+	}
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
-- 
1.9.0

