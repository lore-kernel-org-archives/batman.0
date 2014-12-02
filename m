Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:30 +0100
Message-Id: <1417519009-20699-13-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/31] batman-adv: hash,
	add used linux headers
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Explicit list of linux headers necessary for this file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 hash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hash.c b/hash.c
index 1d3e5ebaa7ad..783ea8103a80 100644
--- a/hash.c
+++ b/hash.c
@@ -15,6 +15,10 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
 #include "main.h"
 #include "hash.h"
 
-- 
2.1.3

