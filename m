Return-Path: <ordex@autistici.org>
From: Antonio Quartull <ordex@autistici.org>
Date: Sun, 13 Nov 2011 16:58:17 +0100
Message-Id: <1321199897-21468-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: modify tt sections in the README
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

translocal and transglobal section updated in the README file

Signed-off-by: Antonio Quartull <ordex@autistici.org>
---
 README |   45 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/README b/README
index 442f8b6..fc0a85e 100644
--- a/README
+++ b/README
@@ -313,7 +313,21 @@ Example:
 
 $ batctl translocal
 Locally retrieved addresses (from bat0) announced via TT:
- * d6:e0:fd:d9:00:00
+ * d6:e0:fd:d9:00:00 [RPNXW]
+
+In particular, RPNXW are flags which have the following meanings:
+
+- R/Roaming: this client moved to another node but it is still kept for
+		consistency purposes up to the next OGM sending.
+- P/noPurge: this client represents the local soft interface and has to never be
+		deleted.
+- N/New: this client has recently been added but it has to not be advertised up
+		to the next OGM sending (for consistency purposes).
+- X/delete: this client has to be removed for some reason, but it is still kept
+		for consistency purposes up to the next OGM sending.
+- W/Wireless: this client is connected to the node through a Wireless device.
+
+If any of the flags is not enabled, a '.' will substitute its symbol.
 
 batctl transglobal
 ==================
@@ -324,15 +338,26 @@ Usage: batctl transglobal|tg
 
 Example:
 
-Globally announced TT entries received via the mesh (translation table):
- * 16:aa:c4:a2:00:00 via fe:fe:00:00:09:01
- * 5a:32:f9:df:00:00 via fe:fe:00:00:03:01
- * 32:ae:5a:00:00:00 via fe:fe:00:00:04:01
- * 86:88:80:29:00:00 via fe:fe:00:00:08:01
- * 9e:d8:72:f2:00:00 via fe:fe:00:00:02:01
- * 76:84:68:49:00:00 via fe:fe:00:00:05:01
- * 86:4b:b2:d2:00:00 via fe:fe:00:00:07:01
- * ca:a1:5b:e5:00:00 via fe:fe:00:00:06:01
+Globally announced TT entries received via the mesh bat0
+   Client	     (TTVN)     Originator        (Curr TTVN) Flags
+ * 16:aa:c4:a2:00:00  ( 12) via fe:fe:00:00:09:01       ( 50) [RXW]
+
+where:
+- TTVN: is the translation-table-version-number which introduced this
+		client
+- Curr TTVN: is the translation-table-version-number currently advertised by
+		the originator serving this client (different clients
+		advertised by the same originator have the same Curr TTVN)
+- Flags that mean:
+	- R/Roaming: this client moved to another node but it is still kept for
+		consistency purposes up to the next OGM received from its
+		originator
+	- X/delete: this client has to be removed for some reason, but it is
+		still kept for consistency purposes.
+	- W/Wireless: this client is connected to the node through a Wireless
+		device.
+
+If any of the flags is not enabled, a '.' will substitute its symbol.
 
 batctl vis_mode
 =================
-- 
1.7.3.4

