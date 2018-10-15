Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 15 Oct 2018 12:02:01 +0200
Message-Id: <20181015100201.17348-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix minor typos in manpage
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man/batctl.8 b/man/batctl.8
index d5fc5302ffd5d6a5ab1dfcb164c57a9f7f8e398f..3e210281fcf4d5d3c1d76b1f9c02459f4828979e 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -338,7 +338,7 @@ given batctl will not replace the MAC addresses with bat\-host names in the outp
 This command starts a throughput test entirely controlled by batman module in
 kernel space: the computational resources needed to align memory and copy data
 between user and kernel space that are required by other user space tools may
-represent a bootleneck on some low profile device.
+represent a bottleneck on some low profile device.
 
 The test consist of the transfer of 14 MB of data between the two nodes. The
 protocol used to transfer the data is somehow similar to TCP, but simpler: some
@@ -346,9 +346,9 @@ TCP features are still missing, thus protocol performances could be worst. Since
 a fixed amount of data is transferred the experiment duration depends on the
 network conditions. The experiment can be interrupted with CTRL + C. At the end
 of a successful experiment the throughput in KBytes per second is returned,
-togheter with the experiment duration in millisecond and the amount of bytes
+together with the experiment duration in millisecond and the amount of bytes
 transferred. If too many packets are lost or the specified MAC address is not
-reachable, a message notifing the error is returned instead of the result.
+reachable, a message notifying the error is returned instead of the result.
 .RE
 .br
 .SH FILES
