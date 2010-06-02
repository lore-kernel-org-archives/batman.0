Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  3 Jun 2010 00:58:36 +0200
Message-Id: <1275519516-21394-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275519516-21394-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-experimental: Correct gw_speed
	down bit mask
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
Cc: Axel Neumann <neumann@cgws.de>
---
 batman-experimental/posix/tunnel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-experimental/posix/tunnel.c b/batman-experimental/posix/tunnel.c
index 8911dcc..c1aba5c 100644
--- a/batman-experimental/posix/tunnel.c
+++ b/batman-experimental/posix/tunnel.c
@@ -466,7 +466,7 @@ static int8_t set_tun_addr( int32_t fd, uint32_t tun_addr, char *tun_dev ) {
 static void get_gw_speeds( unsigned char class, int *down, int *up ) {
 
 	char sbit    = (class&0x80)>>7;
-	char dpart   = (class&0x7C)>>3;
+	char dpart   = (class&0x78)>>3;
 	char upart   = (class&0x07);
 
 	*down= 32*(sbit+2)*(1<<dpart);
-- 
1.7.1

