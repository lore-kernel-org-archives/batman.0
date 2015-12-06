Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:14:44 +0100
Message-Id: <1449414884-21267-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Switch to HTTPS version of links
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

open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
requests are currently redirected automatically to HTTPS but references in
the source code should be only https.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 6bbf915..fbca7d1 100644
--- a/README
+++ b/README
@@ -312,7 +312,7 @@ Mailing-list:   b.a.t.m.a.n@lists.open-mesh.org (optional  subscription
 If you have test reports/patches/ideas, please read the wiki for further instruction
 on how to contribute:
 
-http://www.open-mesh.org/projects/open-mesh/wiki/Contribute
+https://www.open-mesh.org/projects/open-mesh/wiki/Contribute
 
 You can also contact the Authors:
 
-- 
2.6.2

