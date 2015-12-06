Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:15:07 +0100
Message-Id: <1449414907-21358-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Switch to HTTPS version of links
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

open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
requests are currently redirected automatically to HTTPS but references in
the source code should be only https.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.txt | 2 +-
 MAINTAINERS                             | 2 +-
 net/batman-adv/Kconfig                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 58e4904..810becb 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -184,7 +184,7 @@ interfaces to the kernel module settings.
 
 For more information, please see the manpage (man batctl).
 
-batctl is available on http://www.open-mesh.org/
+batctl is available on https://www.open-mesh.org/
 
 
 CONTACT
diff --git a/MAINTAINERS b/MAINTAINERS
index f3de001..0223cee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2111,7 +2111,7 @@ M:	Marek Lindner <mareklindner@neomailbox.ch>
 M:	Simon Wunderlich <sw@simonwunderlich.de>
 M:	Antonio Quartulli <antonio@meshcoding.com>
 L:	b.a.t.m.a.n@lists.open-mesh.org
-W:	http://www.open-mesh.org/
+W:	https://www.open-mesh.org/
 S:	Maintained
 F:	net/batman-adv/
 
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c6fc8f7..2dd40e5 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -12,7 +12,7 @@ config BATMAN_ADV
           B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
           a routing protocol for multi-hop ad-hoc mesh networks. The
           networks may be wired or wireless. See
-          http://www.open-mesh.org/ for more information and user space
+          https://www.open-mesh.org/ for more information and user space
           tools.
 
 config BATMAN_ADV_BLA
-- 
2.6.2

