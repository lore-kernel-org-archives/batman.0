Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 1/2] alfred: remove unnecessary backslash
Date: Wed, 14 Sep 2022 20:40:34 +0200
Message-Id: <20220914184035.1437928-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 alfred.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 97f0093..a4a3d37 100644
--- a/alfred.h
+++ b/alfred.h
@@ -210,7 +210,7 @@ int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
 void unix_sock_events_close_all(struct globals *globals);
-void unix_sock_event_notify(struct globals *globals, uint8_t type,\
+void unix_sock_event_notify(struct globals *globals, uint8_t type,
 			    const uint8_t source[ETH_ALEN]);
 /* vis.c */
 int vis_update_data(struct globals *globals);
--=20
2.37.2
