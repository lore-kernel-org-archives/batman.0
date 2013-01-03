Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  3 Jan 2013 23:32:03 +0800
Message-Id: <1357227125-14190-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: man page - improve selection
	class 1 explanation
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 man/batctl.8 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 3c8edce..7e4f391 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -128,7 +128,7 @@ default: 20 \-> late switch (TQ 20)
 .RS 16
 examples:  1 -> fast connection
 .RS 16
-consider the gateway's advertised throughput as well as the link quality towards the gateway
+consider the gateway's advertised throughput as well as the link quality towards the gateway and stick with the selection until the gateway disappears
 .RE
 .RE
 .RS 25
-- 
1.7.10.4

