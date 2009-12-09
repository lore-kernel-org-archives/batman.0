Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:29 +0100
Message-Id: <1260389373-1071-7-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-6-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
	<1260389373-1071-6-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 06/10] staging:batman-adv:if discarding a
	packet, we need to read it under any condition.
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
git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1489 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 routing.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index e7eb766..f4be6be 100644
--- a/routing.c
+++ b/routing.c
@@ -968,8 +968,7 @@ static int discard_one_packet(struct batman_if *batman_if,
 {
 	int result = -EAGAIN;
 
-	if ((batman_if->if_active == IF_TO_BE_ACTIVATED) 
-		&& (batman_if->raw_sock)) {
+	if (batman_if->raw_sock) {
 			result = receive_raw_packet(batman_if->raw_sock,
 						    packet_buff,
 						    PACKBUFF_SIZE);
-- 
1.6.5.4

