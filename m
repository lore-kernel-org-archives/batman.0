Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: ping: Skip sleep after last packet
Date: Fri, 22 Apr 2022 11:14:08 +0200
Message-Id: <20220422091408.383897-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>, Roman Le bg <roman@romanlebg.fr>

The -i option for ping is documented as interval between ping requests. But
the sleep was also applied after all the requested pings already sent out.
As result, the user had to wait additional time until the statistics for
the (limited) ping test was printed.

Just skip the last sleep in case there will be no next ping packet to avoid
this problem.

Reported-by: Roman Le bg <roman@romanlebg.fr>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ping.c b/ping.c
index 7565dcd..3681e7e 100644
--- a/ping.c
+++ b/ping.c
@@ -282,6 +282,10 @@ static int ping(struct state *state, int argc, char **argv)
 		}
 
 sleep:
+		/* skip last sleep in case no more packets will be sent out */
+		if (loop_count == 0)
+			continue;
+
 		if (loop_interval > 0)
 			sleep(loop_interval);
 		else if ((tv.tv_sec != 0) || (tv.tv_usec != 0))
-- 
2.30.2

