Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 15 Jan 2014 20:39:33 +0800
Message-Id: <1389789573-1680-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH-next] batman-adv: fix batman-adv header
	overhead calculation
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Batman-adv prepends a full ethernet header in addition to its own
header. This has to be reflected in the MTU calculation.

Introduced by f1f310d5c261f0214f85afea95d5cd11d49d64c6
("batman-adv: consider network coding overhead when calculating required mtu")

Reported-by: cmsv <cmsv@wirelesspt.net>
Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 4547bf0..fd85205 100644
--- a/main.c
+++ b/main.c
@@ -277,7 +277,7 @@ int batadv_max_header_len(void)
 			   sizeof(struct batadv_coded_packet));
 #endif
 
-	return header_len;
+	return header_len + ETH_HLEN;
 }
 
 /**
-- 
1.8.4.4

