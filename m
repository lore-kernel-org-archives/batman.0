Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batman-adv: Move IRC channel to hackint.org
Date: Sun, 13 Jun 2021 17:01:43 +0200
Message-Id: <20210613150144.525655-1-sven@narfation.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

Due to recent developments around the Freenode.org IRC network, the
opinions about the usage of this service shifted dramatically. The majority
of the still active users of the #batman channel prefers a move to the
hackint.org network.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.rst | 2 +-
 MAINTAINERS                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 74821d29a22f..b85563ea3682 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -157,7 +157,7 @@ Contact
 Please send us comments, experiences, questions, anything :)
 
 IRC:
-  #batman on irc.freenode.org
+  #batadv on ircs://irc.hackint.org/
 Mailing-list:
   b.a.t.m.a.n@open-mesh.org (optional subscription at
   https://lists.open-mesh.org/mailman3/postorius/lists/b.a.t.m.a.n.lists.open-mesh.org/)
diff --git a/MAINTAINERS b/MAINTAINERS
index c6cdd550cd3a..b0cebd3a2e21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3169,7 +3169,7 @@ S:	Maintained
 W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 B:	https://www.open-mesh.org/projects/batman-adv/issues
-C:	irc://chat.freenode.net/batman
+C:	ircs://irc.hackint.org/batadv
 T:	git https://git.open-mesh.org/linux-merge.git
 F:	Documentation/networking/batman-adv.rst
 F:	include/uapi/linux/batadv_packet.h
-- 
2.30.2

