Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 May 2011 21:48:04 +0200
Message-Id: <1304797684-31778-2-git-send-email-sven@narfation.org>
In-Reply-To: <1304797684-31778-1-git-send-email-sven@narfation.org>
References: <1304797684-31778-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Remove unused variable r in
	bat_printk
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/compat.c b/compat.c
index 34b27a1..70de376 100644
--- a/compat.c
+++ b/compat.c
@@ -909,11 +909,10 @@ int bat_vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 asmlinkage int bat_printk(const char *fmt, ...)
 {
 	va_list args;
-	int r;
 	char buf[256];
 
 	va_start(args, fmt);
-	r = bat_vsnprintf(buf, sizeof(buf), fmt, args);
+	bat_vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	return printk("%s", buf);
-- 
1.7.5.1

