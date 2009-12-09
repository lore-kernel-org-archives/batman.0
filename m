Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:27 +0100
Message-Id: <1260389373-1071-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-4-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] staging:batman-adv:stop permanent
	warnings if a device is added but deactivated.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

From: simon <simon@45894c77-fb22-0410-b583-ff6e7d5dbf6c>

Signed-off-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1487 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 routing.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/routing.c b/routing.c
index 1ff2a7a..26320d5 100644
--- a/routing.c
+++ b/routing.c
@@ -1177,12 +1177,8 @@ static int discard_one_packet(struct batman_if *batman_if,
 {
 	int result = -EAGAIN;
 
-	if (batman_if->if_active != IF_TO_BE_ACTIVATED) {
-		printk(KERN_WARNING
-		       "batman-adv:Could not read from deactivated interface %s!\n",
-		       batman_if->dev);
-	} else {
-		if (batman_if->raw_sock)
+	if ((batman_if->if_active == IF_TO_BE_ACTIVATED) 
+		&& (batman_if->raw_sock)) {
 			result = receive_raw_packet(batman_if->raw_sock,
 						    packet_buff,
 						    PACKBUFF_SIZE);
-- 
1.6.5.4

