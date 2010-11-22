Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Mon, 22 Nov 2010 22:45:53 +0100
Message-Id: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix bisecting of OGMs with 32bit
	seqno
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This patch increases the size of the seqno variable for bisect and now
uses UINT32_MAX for format checking. To be consistent, also "255"s got
substituted by UINT8_MAX

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bisect.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index b7d8969..ee9e2f1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -385,7 +385,7 @@ err:
 	return 0;
 }
 
-static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char *neigh, int seqno, int tq, int ttl)
+static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char *neigh, int64_t seqno, int tq, int ttl)
 {
 	struct bat_node *orig_node, *neigh_node, *prev_sender_node;
 	struct orig_event *orig_event;
@@ -406,17 +406,17 @@ static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char
 		goto err;
 	}
 
-	if ((seqno < 0) || (seqno > 65535)) {
-		fprintf(stderr, "Invalid sequence number found (%i) - skipping", seqno);
+	if ((seqno < 0) || (seqno > UINT32_MAX)) {
+		fprintf(stderr, "Invalid sequence number found (%lli) - skipping", seqno);
 		goto err;
 	}
 
-	if ((tq < 0) || (tq > 255)) {
+	if ((tq < 0) || (tq > UINT8_MAX)) {
 		fprintf(stderr, "Invalid tq value found (%i) - skipping", tq);
 		goto err;
 	}
 
-	if ((ttl < 0) || (ttl > 255)) {
+	if ((ttl < 0) || (ttl > UINT8_MAX)) {
 		fprintf(stderr, "Invalid ttl value found (%i) - skipping", ttl);
 		goto err;
 	}
-- 
1.7.1

