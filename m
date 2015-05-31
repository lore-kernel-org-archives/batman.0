Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:35:56 +0200
Message-Id: <1433072160-3260-2-git-send-email-sven@narfation.org>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] alfred: Make buffer size check before
	sending explicit
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

It is checked when data is send by checking if the data would fit inside
the outgoing UDP packet. But it is not checked if the data would fit after
the sending was done. This doesn't have to be true just from the
restrictions which can be seen in this function. So just check if the data
and its headers would now fit in outgoing buffer before copying the data to
the output buffer.

This is not a problem by itself because the data + header in the dataset
cannot be larger than (MAX_PAYLOAD - sizeof(struct alfred_push_data_v0)).

Reported-by: Hans-Werner Hilse <hwhilse@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 send.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/send.c b/send.c
index 8853970..5a92132 100644
--- a/send.c
+++ b/send.c
@@ -92,4 +92,9 @@ int push_data(struct globals *globals, struct interface *interface,
 		}
 
+		/* still too large? - should never happen */
+		if (total_length + dataset->data.header.length + sizeof(*data) >
+		    MAX_PAYLOAD - sizeof(*push))
+			continue;
+
 		data = (struct alfred_data *)
 		       (buf + sizeof(*push) + total_length);
-- 
2.1.4

