Return-Path: <baolex.ni@intel.com>
From: Baole Ni <baolex.ni@intel.com>
Date: Tue,  2 Aug 2016 20:15:13 +0800
Message-Id: <20160802121513.22526-1-baolex.ni@intel.com>
Subject: [B.A.T.M.A.N.] [PATCH 1086/1285] Replace numeric parameter like
	0444 with macro
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, jiangshanlai@gmail.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: aarcange@redhat.com, mhocko@suse.com, gang.chen.5i5j@gmail.com, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, baolex.ni@intel.com, aryabinin@virtuozzo.com, chuansheng.liu@intel.com, koct9i@gmail.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5f2974b..25759b9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1313,7 +1313,7 @@ static struct kparam_string batadv_param_string_ra = {
 };
 
 module_param_cb(routing_algo, &batadv_param_ops_ra, &batadv_param_string_ra,
-		0644);
+		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 module_init(batadv_init);
 module_exit(batadv_exit);
 
-- 
2.9.2

