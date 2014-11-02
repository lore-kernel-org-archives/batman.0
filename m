Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  2 Nov 2014 11:29:57 +0100
Message-Id: <1414924197-24141-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1414924197-24141-1-git-send-email-antonio@meshcoding.com>
References: <1414924197-24141-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove useless return at the
	of a void function
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reported-by: checkpath
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/debugfs.c b/debugfs.c
index d9b9a8e..a497287 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -233,7 +233,6 @@ static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 
 static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 {
-	return;
 }
 #endif
 
-- 
2.1.3

