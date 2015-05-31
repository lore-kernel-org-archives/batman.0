Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:35:57 +0200
Message-Id: <1433072160-3260-3-git-send-email-sven@narfation.org>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] alfred: Don't push data when nothing is
	available
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

The push data code currently sends packets with MAX_PAYLOAD. This allows
some checks to be dropped. For example, the check if data must be send out
is just a check if the current data still can be copied to the output
buffer. But this would also mean that data with a size larger than
(MAX_PAYLOAD - sizeof(struct alfred_push_data_v0)) may trigger an empty
packet.

This is not a problem by itself because currently the data + header in
the dataset cannot be larger than
(MAX_PAYLOAD - sizeof(struct alfred_push_data_v0)).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 send.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/send.c b/send.c
index 5a92132..43c10f4 100644
--- a/send.c
+++ b/send.c
@@ -83,4 +83,8 @@ int push_data(struct globals *globals, struct interface *interface,
 		if (total_length + dataset->data.header.length + sizeof(*data) >
 		    MAX_PAYLOAD - sizeof(*push)) {
+			/* is there any data to send? */
+			if (total_length == 0)
+				continue;
+
 			tlv_length = total_length;
 			tlv_length += sizeof(*push) - sizeof(push->header);
-- 
2.1.4

