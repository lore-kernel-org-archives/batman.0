Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Sep 2016 18:01:33 +0200
Message-Id: <20160901160134.15593-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix minor typos in manpage
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

 * s/criterias/criteria/
 * s/succesful/successful/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 8bac727..17549c0 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -129,7 +129,7 @@ examples:  5000 \->  5.0/1.0 MBit
  5mbit/1mbit
 .RE
 .RS 7
-If the node is a gateway client the parameter will decide which criterias to consider when the batman-adv module has to choose
+If the node is a gateway client the parameter will decide which criteria to consider when the batman-adv module has to choose
 between different internet connections announced by the aforementioned servers.
 .RE
 .RS 17
@@ -337,7 +337,7 @@ protocol used to transfer the data is somehow similar to TCP, but simpler: some
 TCP features are still missing, thus protocol performances could be worst. Since
 a fixed amount of data is transferred the experiment duration depends on the
 network conditions. The experiment can be interrupted with CTRL + C. At the end
-of a succesful experiment the throughput in KBytes per second is returned,
+of a successful experiment the throughput in KBytes per second is returned,
 togheter with the experiment duration in millisecond and the amount of bytes
 transferred. If too many packets are lost or the specified MAC address is not
 reachable, a message notifing the error is returned instead of the result.
-- 
2.9.3

