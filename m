Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 24 Feb 2014 05:11:42 +0100
Message-Id: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: fix wrong header lines number
	for local translation table
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

A commit in batman-adv has added a second header line to the local
translation table output.

Introduced by 59cb0861498776c62bd17584c31f34477fa301a0
("batman-adv: improve local translation table output")

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debug.c b/debug.c
index d57324d..6836857 100644
--- a/debug.c
+++ b/debug.c
@@ -45,7 +45,7 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_long = "translocal",
 		.opt_short = "tl",
 		.debugfs_name = "transtable_local",
-		.header_lines = 1,
+		.header_lines = 2,
 	},
 	{
 		.opt_long = "transglobal",
-- 
1.7.10.4

