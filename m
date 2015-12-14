Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Dec 2015 15:00:26 +0100
Message-Id: <1450101627-9692-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Fix typo Retreive -> Retrieve
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/alfred.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/alfred.8 b/man/alfred.8
index 95241a7..49d42bc 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -130,7 +130,7 @@ Send data to the alfred server and store it under id 65:
 .br
 \fB     cat /etc/hostname | alfred -s 65\fP
 
-Retreive all data stored as id 65 from all connected alfred servers:
+Retrieve all data stored as id 65 from all connected alfred servers:
 .br
 \fB     alfred -r 65\fP
 .nf
-- 
2.6.4

