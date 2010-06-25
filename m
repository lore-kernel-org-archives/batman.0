Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 00:28:21 +0200
Message-Id: <1277504905-27672-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] Staging: batman-adv: replace manual
	calculation by msecs_to_jiffies() for better readability
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/send.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 8059adb..d4b92ef 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -42,15 +42,15 @@ static uint8_t hop_penalty(const uint8_t tq)
 /* when do we schedule our own packet to be sent */
 static unsigned long own_send_time(struct bat_priv *bat_priv)
 {
-	return jiffies +
-		(((atomic_read(&bat_priv->orig_interval) - JITTER +
-		   (random32() % 2*JITTER)) * HZ) / 1000);
+	return jiffies + msecs_to_jiffies(
+		   atomic_read(&bat_priv->orig_interval) -
+		   JITTER + (random32() % 2*JITTER));
 }
 
 /* when do we schedule a forwarded packet to be sent */
 static unsigned long forward_send_time(struct bat_priv *bat_priv)
 {
-	return jiffies + (((random32() % (JITTER/2)) * HZ) / 1000);
+	return jiffies + msecs_to_jiffies(random32() % (JITTER/2));
 }
 
 /* send out an already prepared packet to the given address via the
-- 
1.7.1

