Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 1/3] alfred: add missing alfred_event_notify_v0 struct
 documentation
Date: Thu,  4 Aug 2022 20:52:10 +0200
Message-Id: <20220804185212.3074514-1-mareklindner@neomailbox.ch>
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
 packet.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/packet.h b/packet.h
index b8d528e..c0723b8 100644
--- a/packet.h
+++ b/packet.h
@@ -247,6 +247,7 @@ struct alfred_event_register_v0 {
  * struct alfred_event_notify_v0 - event notification message
  * @header: TLV header describing the complete packet
  * @type: Type of the data triggering the event
+ * @source: Mac address of the original source of the data
  *
  * Sent by the daemon to client on data record update
  */
--=20
2.36.1
