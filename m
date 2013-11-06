Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed,  6 Nov 2013 14:15:11 +0100
Message-Id: <1383743711-10143-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add missing multicast.h include
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
To: b.a.t.m.a.n@lists.open-mesh.org

Not having it doesn't seem to break anything, but looks like it's
recommended C practice.

Introduced by: a3f58139efedb96222dffdda89896c243fdff49e
("batman-adv: Multicast Listener Announcements via Translation Table")

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Added "Introduced by" clause

 multicast.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/multicast.c b/multicast.c
index 4a978a6..cb1984d 100644
--- a/multicast.c
+++ b/multicast.c
@@ -13,6 +13,7 @@
  */
 
 #include "main.h"
+#include "multicast.h"
 #include "originator.h"
 #include "hard-interface.h"
 #include "translation-table.h"
-- 
1.7.10.4

