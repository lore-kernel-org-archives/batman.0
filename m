Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 11 Mar 2010 22:19:06 +0100
Message-Id: <1268342346-13713-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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

When the seqno for a vis packet had a wrap around from i.e. 255 to 0,
add_packet() would falsely claim the older packet with the seqno 255 as
newer as the one with the seqno of 0 and would therefore ignore the new
packet. This happens with all following vis packets until the old vis
packet expires after 180 seconds timeout. This patch fixes this issue
and gets rid of these highly undesired 3min. breaks for the vis-server.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batman-adv-kernelland/vis.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index fa8a487..5735a6a 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -213,7 +213,8 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 	old_info = hash_find(vis_hash, &search_elem);
 
 	if (old_info != NULL) {
-		if (vis_packet->seqno - old_info->packet.seqno <= 0) {
+		if (vis_packet->seqno - old_info->packet.seqno
+		    <= 1 << 7 * sizeof(vis_packet->seqno)) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
 					      vis_packet->sender_orig);
-- 
1.7.0

