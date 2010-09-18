Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:12 +0200
Message-Id: <1284836482-23431-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/12] Staging: batman-adv: Move mailing list
	address to .org
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

The official mailing list is run on lists.open-mesh.org and it should be
avoided to sent them to lists.open-mesh.net to reduce the number of
receipents and double posts.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/README |    5 +++--
 drivers/staging/batman-adv/TODO   |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index 3a975fc..7c878bb 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -229,8 +229,9 @@ CONTACT
 Please send us comments, experiences, questions, anything :)
 
 IRC:            #batman   on   irc.freenode.org
-Mailing-list:   b.a.t.m.a.n@open-mesh.net (optional  subscription
-          at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
+Mailing-list:   b.a.t.m.a.n@b.a.t.m.a.n@lists.open-mesh.org
+                (optional   subscription   at
+                 https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
 You can also contact the Authors:
 
diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 3af8028..76b2acd 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -11,5 +11,5 @@ Please send all patches to:
 	Marek Lindner <lindner_marek@yahoo.de>
 	Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 	Andrew Lunn <andrew@lunn.ch>
-	b.a.t.m.a.n@lists.open-mesh.net
+	b.a.t.m.a.n@lists.open-mesh.org
 	Greg Kroah-Hartman <gregkh@suse.de>
-- 
1.7.2.3

