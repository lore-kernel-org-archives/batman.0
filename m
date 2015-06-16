Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 17:10:23 +0200
Message-Id: <1434467426-4281-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 maint 2/5] batman-adv: Make NC capability
	changes atomic
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
OGM handler might undo the set/clear of a specific bit from another
handler run in between.

Fix this by using the atomic set_bit()/clear_bit() functions.

Fixes: 7dd9d8992b0c ("batman-adv: tvlv - add network coding container")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 network-coding.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 89e1d47..3ce493e 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -105,9 +105,9 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  uint16_t tvlv_value_len)
 {
 	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_NC;
+		clear_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
 	else
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_NC;
+		set_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
 }
 
 /**
-- 
1.7.10.4

