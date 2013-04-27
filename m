Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Apr 2013 16:22:28 +0800
Message-Id: <1367050948-7626-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: check proto length before
	accessing proto string buffer
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

batadv_param_set_ra() strips the trailing '\n' from the supplied
string buffer without checking the length of the buffer first. This
patches avoids random memory access and associated potential
crashes.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 8a8fd00..f07dd6b 100644
--- a/main.c
+++ b/main.c
@@ -1106,7 +1106,7 @@ static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 	char *algo_name = (char *)val;
 	size_t name_len = strlen(algo_name);
 
-	if (algo_name[name_len - 1] == '\n')
+	if (name_len > 0 && algo_name[name_len - 1] == '\n')
 		algo_name[name_len - 1] = '\0';
 
 	bat_algo_ops = batadv_algo_get(algo_name);
-- 
1.7.10.4

