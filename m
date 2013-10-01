Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue,  1 Oct 2013 22:22:40 +0200
Message-Id: <1380658960-14434-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH] Alfred: Fix the list email address in the
	README.
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
To: siwu@hrz.tu-chmnitz.de, sven@open-mesh.com
Cc: Janne.Paatero@ruag.com, b.a.t.m.a.n@lists.open-mesh.org

The address is wrong,  missing the hostname.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 3e1001f..3b1820e 100644
--- a/README
+++ b/README
@@ -234,7 +234,7 @@ As alfred was developed to help on batman-adv, we share communication channels.
 Please send us comments, experiences, questions, anything :)
 
 IRC:            #batman   on   irc.freenode.org
-Mailing-list:   b.a.t.m.a.n@open-mesh.org (optional  subscription
+Mailing-list:   b.a.t.m.a.n@lists.open-mesh.org (optional  subscription
                 at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
 If you have test reports/patches/ideas, please read the wiki for further instruction
-- 
1.8.4.rc3

