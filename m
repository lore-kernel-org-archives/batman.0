Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Avoid WARN_ON timing related checks
Date: Tue, 18 May 2021 21:00:27 +0200
Message-Id: <20210518190027.547508-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

The soft/batadv interface for a queued OGM can be changed during the time
the OGM was queued for transmission and when the OGM is actually
transmitted by the worker.

But WARN_ON must be used to denote kernel bugs and not to print simple
warnings. A warning can simply be printed using pr_warn.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com
Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in OGM send=
ing")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 680def80..12022378 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -409,8 +409,10 @@ static void batadv_iv_ogm_emit(struct batadv_forw_pa=
cket *forw_packet)
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
=20
-	if (WARN_ON(forw_packet->if_outgoing->soft_iface !=3D soft_iface))
+	if (forw_packet->if_outgoing->soft_iface !=3D soft_iface) {
+		pr_warn("%s: soft interface switch for queued OGM\n", __func__);
 		return;
+	}
=20
 	if (forw_packet->if_incoming->if_status !=3D BATADV_IF_ACTIVE)
 		return;
--=20
2.30.2
