Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Dec 2010 21:46:58 +0100
Message-Id: <1292186819-26232-1-git-send-email-sven@narfation.org>
In-Reply-To: <201012122143.10618.sven@narfation.org>
References: <201012122143.10618.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: Remove line over 80
	characters
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

"Use kernel facilities for bit operations" increased accidently the
character count on a line to more than 80 characters when counting a tab
as 8 characters.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/bitarray.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/bitarray.c b/batman-adv/bitarray.c
index 14606fc..5dad5e8 100644
--- a/batman-adv/bitarray.c
+++ b/batman-adv/bitarray.c
@@ -61,7 +61,7 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n)
 	/* which position in the selected word */
 	word_offset = n % WORD_BIT_SIZE;
 
-	set_bit(word_offset, &seq_bits[word_num]);	/* turn the position on */
+	set_bit(word_offset, &seq_bits[word_num]); /* turn the position on */
 }
 
 /* shift the packet array by n places. */
-- 
1.7.2.3

