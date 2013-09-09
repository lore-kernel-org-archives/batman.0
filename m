Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:04 +0200
Message-Id: <1378741567-25152-4-git-send-email-sven@open-mesh.com>
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] alfred: Stop client when data header
	could not be read
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client.c b/client.c
index 3c1916c..2187ff2 100644
--- a/client.c
+++ b/client.c
@@ -81,6 +81,9 @@ int alfred_client_request_data(struct globals *globals)
 		ret = read(globals->unix_sock, buf + sizeof(*push),
 			   sizeof(*data));
 
+		if (ret < (ssize_t)sizeof(*data))
+			break;
+
 		data = push->data;
 		data_len = ntohs(data->header.length);
 
-- 
1.8.4.rc3

