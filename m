Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  3 Jun 2010 00:58:34 +0200
Message-Id: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman: Correct gw_speed down bit mask
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
To: b.a.t.m.a.n@open-mesh.net

We want to get bits .OOOO... and not as the mask would suggest .OOOOO..
when we decode the encoded bits for the download part of the gateway
speed.

Reported-By: Bill Meier <wmeier@newsguy.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index 4374af5..ab689b2 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -482,7 +482,7 @@ void update_gw_list(struct orig_node *orig_node, uint8_t new_gwflags, uint16_t g
 void get_gw_speeds(unsigned char gw_class, int *down, int *up)
 {
 	char sbit = (gw_class & 0x80) >> 7;
-	char dpart = (gw_class & 0x7C) >> 3;
+	char dpart = (gw_class & 0x78) >> 3;
 	char upart = (gw_class & 0x07);
 
 	*down = 32 * (sbit + 2) * (1 << dpart);
-- 
1.7.1

