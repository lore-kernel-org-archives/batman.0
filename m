Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Mar 2015 23:41:17 +0100
Message-Id: <1425768078-15380-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Update version when adding data
	to dataset
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
Cc: Sven Eckelmann <sven@narfation.org>

The dataset stores the source and the alfred_tlv of the send data next to the
actual data buffer. The source and alfred_tlv::type was used to find an entry
in the dataset hashtable when reading/updating the buffer. The
alfred_tlv::length is always updated when the size of the associated buffer
gets modified.

But the alfred_tlv::version is only written when receiving the first data for a
dataset. But this initial (maybe outdated) version is always propagated when a
client asks over the unix socket or the dataset is exchanged between alfred
servers. This has to also be updated when new data is added to the dataset to
avoid clients to interpret the data using the wrong data format version.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c      | 1 +
 unix_sock.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recv.c b/recv.c
index 34a16fc..e0252eb 100644
--- a/recv.c
+++ b/recv.c
@@ -91,6 +91,7 @@ static int finish_alfred_push_data(struct globals *globals,
 			goto err;
 
 		dataset->data.header.length = data_len;
+		dataset->data.header.version = data->header.version;
 		memcpy(dataset->buf, data->data, data_len);
 
 		/* if the sender is also the the source of the dataset, we
diff --git a/unix_sock.c b/unix_sock.c
index ae86956..0707252 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -151,6 +151,7 @@ static int unix_sock_add_data(struct globals *globals,
 		goto err;
 
 	dataset->data.header.length = data_len;
+	dataset->data.header.version = data->header.version;
 	memcpy(dataset->buf, data->data, data_len);
 
 	ret = 0;
-- 
2.1.4

