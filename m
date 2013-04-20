Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 20 Apr 2013 15:59:13 +0200
Message-Id: <1366466353-18495-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: switch to a new packet
	compatibility version
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>

With this change batman-adv is breaking compatibility with
older versions and it is moving to compat-version 15.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index a51ccfc..11a22c8 100644
--- a/packet.h
+++ b/packet.h
@@ -48,7 +48,7 @@ enum batadv_subtype {
 };
 
 /* this file is included by batctl which needs these defines */
-#define BATADV_COMPAT_VERSION 14
+#define BATADV_COMPAT_VERSION 15
 
 enum batadv_iv_flags {
 	BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
-- 
1.8.1.5

