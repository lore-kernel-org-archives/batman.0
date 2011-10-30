Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 16:22:43 +0100
Message-Id: <1319988163-3249-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <4EAC49D7.2060609@intra2net.com>
References: <4EAC49D7.2060609@intra2net.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix range check for expected
	packets
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
Cc: netdev@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The check for new packets in the future used a wrong binary operator,
which makes the check expression always true and accepting too many
packets.

Reported-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bitarray.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index 0be9ff3..9bc63b2 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -155,7 +155,7 @@ int bit_get_packet(void *priv, unsigned long *seq_bits,
 	/* sequence number is much newer, probably missed a lot of packets */
 
 	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE)
-		|| (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
+		&& (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"We missed a lot of packets (%i) !\n",
 			seq_num_diff - 1);
-- 
1.7.7

