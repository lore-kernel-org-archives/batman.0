Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  3 May 2010 00:14:16 +0200
Message-Id: <1272838458-13899-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005030012.18621.sven.eckelmann@gmx.de>
References: <201005030012.18621.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Merge CHANGELOG with 0.2.1
	release
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


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/CHANGELOG |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/CHANGELOG b/batman-adv-kernelland/CHANGELOG
index 8a18163..c8f9d9e 100644
--- a/batman-adv-kernelland/CHANGELOG
+++ b/batman-adv-kernelland/CHANGELOG
@@ -1,3 +1,17 @@
+batman-adv 0.2.1:
+
+* support latest kernels (2.6.20 - 2.6.33)
+* receive packets directly using skbs, remove old sockets and threads
+* fix various regressions in the vis server
+* don't disable interrupts while sending
+* replace internal logging mechanism with standard kernel logging
+* move vis formats into userland, one general format remains in the kernel
+* allow MAC address to be set, correctly initialize them
+* code refactoring and cleaning for coding style
+* many bugs (null pointers, locking, hash iterators) squashed
+
+ -- Sun, 21 Mar 2010 20:46:47 +0100
+
 batman-adv 0.2:
 
 * support latest kernels (2.6.20 - 2.6.31)
-- 
1.7.1

