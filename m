Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3B3C55167
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:43:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C5658363A
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 09:43:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785483796;
 b=V0bvm/DfzMlmhV+zKn1+VM0tQqz8wfIhgpZvzwaG+Mq6Ypj58PnVsHnlWFX+Av9rHc681
 DsCmPWrvLkSo3jqfJkK6T64WjhvfuVcL9FqOYl/K4lHhDVLGi7t5eXojr6gS1h9kx+h49xE
 TFbDX6VMcG67RTHYsK5n4E82xyU+U24=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785483796; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4wQOX0ys8EE3Fz1uKMKBazFtcIJtnhu3lXwAM65fR/c=;
 b=e9POq9/Uu3HX2GUrKRHT2g2x6hg1MiBhmeDuuQHF34tGGAmVeyIG7Z2XxD41Bl8U/BG9m
 1eSQGTuSSi8a0Jq/ltlKEsj/Zqwh4OocV52BBXH6+aXICblOjh81fBeIbM6X/P1ob5Ywuge
 NL4vpN8vSpVBk5lHSf8XasPTdkU64K0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CE68E8403E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 09:41:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785483703;
	b=ovX1HT8W10mbafBjdSLGiY1BZ7dzu1oojl41jhtIg9hmoZ1eE0rlwFL5s7qImKX7zMZ5ky
	N4FKBiylEArj4Lbzvz6pA4pXQMXsBREz1UihKJ2pqSxaREXFOCtvEY5M0wYRBFfeavJqGc
	2GriluoaAHlz0+EqPaoWulGLSm6KQ8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785483703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4wQOX0ys8EE3Fz1uKMKBazFtcIJtnhu3lXwAM65fR/c=;
	b=1DObmcy10CuUEsr5htel24FgNXFmTZP7DakKpYf1mLil5zgOzyWB/qzSW5zimjbh8kykKC
	ipSN0AztDeWL7HyXb5hERhl7zRCWynZUTInxXKDZAL1tnYnUV6S7f9YSfgQm36Z9xw0Rzh
	12OD3sYRQXRImNDR1YLE4VQEPJqfdy8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OMJ32Gp1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 734181FE2D;
	Fri, 31 Jul 2026 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785483699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wQOX0ys8EE3Fz1uKMKBazFtcIJtnhu3lXwAM65fR/c=;
	b=OMJ32Gp1jz4J66w4jIyLmdXPEkLvlXQjEL8wZdw3R3b+ZD6TzFh1xPCo6HN9KXKKxa+rQ1
	qanVvJzlmmWe/15JXoAKd/dRxtZ/NcgdM+RSbmSb0FTuzVShmX9G4BEwwft2ehOD86Z/QO
	eetXMOdBEVM1v86qLql5+p6t33ORMIs=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 09:40:16 +0200
Subject: [PATCH 4/4] alfred: handle short reads when waiting for daemon
 answer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-client-v1-4-83d8c7a26421@narfation.org>
References: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
In-Reply-To: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7835; i=sven@narfation.org;
 h=from:subject:message-id; bh=qehAvUGS5JjdCsex7qOHY/ofbpuKqQkI8E2fArEY7u8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5gXEax4RecigqvDhnfff3F/PIww3sL0Uv/+LzuXVp7
 lJltTWzO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATka1h+Cu1Yc/BXQ+iT0r0
 Lz0mu9xyoW7m41e+Z44LsyvbT9fUsJvIyPDH5OFuIYUpcsIrFp189NHH7/S83dFTZ639qbrt2aF
 jRT3sAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7OGIXEICQVTCMLSVNLFQ27SS5KXLKRUD
X-Message-ID-Hash: 7OGIXEICQVTCMLSVNLFQ27SS5KXLKRUD
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7OGIXEICQVTCMLSVNLFQ27SS5KXLKRUD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The answer of the alfred daemon is received over a SOCK_STREAM unix socket
which doesn't preserve message boundaries. read() can therefore return less
than the requested number of bytes. Such a short read was treated like an
end of stream and the processing was stopped.

Retry the read until the requested amount of data, end of stream or a real
error was received (ignoring temporary interruptions EINTR).

Fixes: 23359bbf72aa ("alfred: initial commit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h    |  1 +
 client.c    | 66 +++++++++++++++++++++++++++++++++++--------------------------
 unix_sock.c | 26 ++++++++++++------------
 util.c      | 25 +++++++++++++++++++++++
 4 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/alfred.h b/alfred.h
index df47d54..1d915a8 100644
--- a/alfred.h
+++ b/alfred.h
@@ -224,6 +224,7 @@ void netsock_reopen(struct globals *globals);
 int netsock_own_address(const struct globals *globals,
 			const alfred_addr *address);
 /* util.c */
+ssize_t read_full(int fd, void *buf, size_t count);
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff);
 void time_random_seed(void);
diff --git a/client.c b/client.c
index 1967f69..1e1f1ef 100644
--- a/client.c
+++ b/client.c
@@ -53,7 +53,7 @@ int alfred_client_request_data(struct globals *globals)
 
 	push = (struct alfred_push_data_v0 *)buf;
 	tlv = (struct alfred_tlv *)buf;
-	while ((ret = read(globals->unix_sock, buf, sizeof(*tlv))) > 0) {
+	while ((ret = read_full(globals->unix_sock, buf, sizeof(*tlv))) > 0) {
 		if (ret < (int)sizeof(*tlv))
 			break;
 
@@ -64,16 +64,16 @@ int alfred_client_request_data(struct globals *globals)
 			break;
 
 		/* read the rest of the header */
-		ret = read(globals->unix_sock, buf + sizeof(*tlv),
-			   sizeof(*push) - sizeof(*tlv));
+		ret = read_full(globals->unix_sock, buf + sizeof(*tlv),
+				sizeof(*push) - sizeof(*tlv));
 
 		/* too short */
 		if (ret < (int)(sizeof(*push) - (int)sizeof(*tlv)))
 			break;
 
 		/* read the rest of the header */
-		ret = read(globals->unix_sock, buf + sizeof(*push),
-			   sizeof(*data));
+		ret = read_full(globals->unix_sock, buf + sizeof(*push),
+				sizeof(*data));
 
 		if (ret < (ssize_t)sizeof(*data))
 			break;
@@ -86,8 +86,8 @@ int alfred_client_request_data(struct globals *globals)
 			break;
 
 		/* read the data */
-		ret = read(globals->unix_sock,
-			   buf + sizeof(*push) + sizeof(*data), data_len);
+		ret = read_full(globals->unix_sock,
+				buf + sizeof(*push) + sizeof(*data), data_len);
 
 		/* again too short */
 		if (ret < data_len)
@@ -124,8 +124,8 @@ int alfred_client_request_data(struct globals *globals)
 
 recv_err:
 	/* read the rest of the status message */
-	ret = read(globals->unix_sock, buf + sizeof(*tlv),
-		   sizeof(*status) - sizeof(*tlv));
+	ret = read_full(globals->unix_sock, buf + sizeof(*tlv),
+			sizeof(*status) - sizeof(*tlv));
 
 	/* too short */
 	if (ret < (int)(sizeof(*status) - sizeof(*tlv)))
@@ -377,42 +377,49 @@ int alfred_client_server_status(struct globals *globals)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
 
-	len = read(globals->unix_sock, buf, sizeof(buf));
-	if (len <= 0) {
+	ret = -1;
+	status_rep = (struct alfred_server_status_rep_v0 *)buf;
+	headsize = sizeof(status_rep->header);
+
+	/* drop too small packets */
+	len = read_full(globals->unix_sock, buf, headsize);
+	if (len < 0) {
 		perror("read from unix socket failed");
 		goto err;
 	}
 
-	ret = -1;
-	status_rep = (struct alfred_server_status_rep_v0 *)buf;
-
-	/* drop too small packets */
-	headsize = sizeof(status_rep->header);
 	if (len < headsize) {
-		perror("unexpected header size received from unix socket");
-		goto err;
-	}
-
-	if ((len - headsize) < ((int)ntohs(status_rep->header.length))) {
-		perror("unexpected packet size received from unix socket");
+		fprintf(stderr, "unexpected header size received from unix socket\n");
 		goto err;
 	}
 
 	if (status_rep->header.type != ALFRED_SERVER_STATUS) {
-		perror("alfred server_status type mismatch");
+		fprintf(stderr, "alfred server_status type mismatch\n");
 		goto err;
 	}
 
 	if (status_rep->header.version != ALFRED_VERSION) {
-		perror("alfred version mismatch");
+		fprintf(stderr, "alfred version mismatch\n");
 		goto err;
 	}
 
-	headsize = ntohs(status_rep->header.length);
+	tlvsize = ntohs(status_rep->header.length);
 
-	if (headsize < (int)(sizeof(*status_rep) - sizeof(status_rep->header)))
+	if (tlvsize < (int)(sizeof(*status_rep) - sizeof(status_rep->header)))
 		goto err;
 
+	if (tlvsize > (int)(sizeof(buf) - headsize)) {
+		fprintf(stderr, "unexpected packet size received from unix socket\n");
+		goto err;
+	}
+
+	/* read the announced rest of the reply */
+	if (read_full(globals->unix_sock, buf + headsize, tlvsize) < tlvsize) {
+		fprintf(stderr, "unexpected packet size received from unix socket\n");
+		goto err;
+	}
+
+	len = headsize + tlvsize;
 	consumed = sizeof(*status_rep);
 
 	while (len - consumed > 0) {
@@ -473,9 +480,11 @@ int alfred_client_server_status(struct globals *globals)
 		consumed += tlvsize;
 	}
 
+	ret = 0;
+
 err:
 	unix_sock_close(globals);
-	return 0;
+	return ret;
 }
 
 int alfred_client_event_monitor(struct globals *globals)
@@ -502,7 +511,8 @@ int alfred_client_event_monitor(struct globals *globals)
 	}
 
 	while (true) {
-		len = read(globals->unix_sock, &event_notify, sizeof(event_notify));
+		len = read_full(globals->unix_sock, &event_notify,
+				sizeof(event_notify));
 		if (len == 0) {
 			fprintf(stdout, "Server closed the connection\n");
 			goto err;
diff --git a/unix_sock.c b/unix_sock.c
index d4261ba..e5ccc35 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -542,26 +542,26 @@ static void unix_sock_read(struct globals *globals,
 		return;
 	}
 
-	/* we assume that we can instantly read here. */
-	length = read(client_sock, buf, sizeof(buf));
-	if (length <= 0) {
+	headsize = sizeof(*packet);
+	packet = (struct alfred_tlv *)buf;
+
+	/* drop too small packets */
+	if (read_full(client_sock, buf, headsize) < headsize) {
 		perror("read from unix socket failed");
 		goto err;
 	}
 
-	/* drop too small packets */
-	headsize = sizeof(*packet);
-	if (length < headsize)
-		goto err;
-
-	packet = (struct alfred_tlv *)buf;
-
-	if ((length - headsize) < ((int)ntohs(packet->length)))
-		goto err;
-
 	if (packet->version != ALFRED_VERSION)
 		goto err;
 
+	length = ntohs(packet->length);
+	if (length > (int)(sizeof(buf) - headsize))
+		goto err;
+
+	/* read the announced rest of the request */
+	if (read_full(client_sock, buf + headsize, length) < length)
+		goto err;
+
 	switch (packet->type) {
 	case ALFRED_PUSH_DATA:
 		unix_sock_add_data(globals,
diff --git a/util.c b/util.c
index b00b953..1a552ea 100644
--- a/util.c
+++ b/util.c
@@ -6,6 +6,7 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <netinet/ether.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -19,6 +20,30 @@
 #include <unistd.h>
 #include "alfred.h"
 
+ssize_t read_full(int fd, void *buf, size_t count)
+{
+	size_t read_len = 0;
+	uint8_t *pos = buf;
+	ssize_t ret;
+
+	while (read_len < count) {
+		ret = read(fd, pos + read_len, count - read_len);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+
+			return ret;
+		}
+
+		if (ret == 0)
+			break;
+
+		read_len += ret;
+	}
+
+	return read_len;
+}
+
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff) {
 	tvdiff->tv_sec = tv1->tv_sec - tv2->tv_sec;

-- 
2.47.3

