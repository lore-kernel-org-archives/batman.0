Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 19 Jun 2010 17:24:34 +0200
Message-Id: <1276961074-3223-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid rounding issues for local
	hna timeout
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

With the current default values, this patch is not critical, as
LOCAL_HNA_TIMEOUT is a multiple of 1000 anyway. However, if someone
would like to change this #define, the person could have some
unexpected rounding issues. Therefore doing the multiplication before
the division now.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 translation-table.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 619a9a8..cf37cc4 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -259,7 +259,7 @@ static void hna_local_purge(struct work_struct *work)
 		hna_local_entry = hashit.bucket->data;
 
 		timeout = hna_local_entry->last_seen +
-			((LOCAL_HNA_TIMEOUT / 1000) * HZ);
+			((LOCAL_HNA_TIMEOUT * HZ) / 1000);
 		if ((!hna_local_entry->never_purge) &&
 		    time_after(jiffies, timeout))
 			hna_local_del(hna_local_entry, "address timed out");
-- 
1.7.1

