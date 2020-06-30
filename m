Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Switch mailing list subscription page
Date: Tue, 30 Jun 2020 10:27:29 +0200
Message-Id: <20200630082731.2397-3-sw@simonwunderlich.de>
In-Reply-To: <20200630082731.2397-1-sw@simonwunderlich.de>
References: <20200630082731.2397-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The mailman installation on lists.open-mesh.org was switched from mailman2
to mailman3. The URL to the subscription webpage changed in this process.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/networking/batman-adv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 18020943ba25..02af49b08635 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -160,7 +160,7 @@ IRC:
   #batman on irc.freenode.org
 Mailing-list:
   b.a.t.m.a.n@open-mesh.org (optional subscription at
-  https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
+  https://lists.open-mesh.org/mailman3/postorius/lists/b.a.t.m.a.n.lists.open-mesh.org/)
 
 You can also contact the Authors:
 
-- 
2.20.1

