Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:06 +0200
Message-Id: <1378741567-25152-6-git-send-email-sven@open-mesh.com>
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] alfred: Fix crash when vis opened empty
	file
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 vis/vis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 5e7a109..36ea7fe 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -59,7 +59,8 @@ static char *read_file(char *fname)
 	}
 	fclose(fp);
 
-	buf[size] = 0;
+	if (buf)
+		buf[size] = 0;
 
 	return buf;
 }
-- 
1.8.4.rc3

