Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 19 Nov 2016 12:06:14 +0100
Message-Id: <20161119110614.23325-3-sw@simonwunderlich.de>
In-Reply-To: <20161119110614.23325-1-sw@simonwunderlich.de>
References: <20161119110614.23325-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Detect missing primaryif
	during tp_send as error
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

The throughput meter detects different situations as problems for the
current test. It stops the test after these and reports it to userspace.
This also has to be done when the primary interface disappeared during the
test.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2333777..8af1611 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -837,6 +837,7 @@ static int batadv_tp_send(void *arg)
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (unlikely(!primary_if)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
+		tp_vars->reason = err;
 		goto out;
 	}
 
-- 
2.10.2

