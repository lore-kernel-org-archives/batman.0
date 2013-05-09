Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 12:56:44 +0200
Message-Id: <1368097007-817-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1368097007-817-1-git-send-email-ordex@autistici.org>
References: <1368097007-817-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: check proto length before
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Marek Lindner <lindner_marek@yahoo.de>

batadv_param_set_ra() strips the trailing '\n' from the supplied
string buffer without checking the length of the buffer first. This
patches avoids random memory access and associated potential
crashes.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3e30a0f..9c620cd 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -475,7 +475,7 @@ static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 	char *algo_name = (char *)val;
 	size_t name_len = strlen(algo_name);
 
-	if (algo_name[name_len - 1] == '\n')
+	if (name_len > 0 && algo_name[name_len - 1] == '\n')
 		algo_name[name_len - 1] = '\0';
 
 	bat_algo_ops = batadv_algo_get(algo_name);
-- 
1.8.1.5

