Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE01C5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:20:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C916083E4C
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:20:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785439205;
 b=mZuj2VvbHqM1qJvDCUAcD+FA/Rj3WYrCWBJpD1jpgTJ6MZg2mE6XPle6T/Jb/UHDUznny
 kiuqf+7Hl/hsy4rKXuO1uKZHpWcXk9Dfrp+3OC0Z0I2hbwEUBOn5TFH04Krl5htjxMdjOqU
 t7pqPgf3dF5uzfsTt2LdOfMxHogbTGw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785439205; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wKG0KaIPm+7ebFZ+H3FrhmBmlGLT72h9PJAy/bxlw4k=;
 b=2vCrm7Hwg9s+VkiT5GZWqJvzHbopz+5DpJwAVYSLC7L9V+uQO6yuQCQCREWz1OApkJeyL
 YTjdXT7fNo+jYb1s6IJPWT1kOhYaKDhFpOudBNo4nt6zBy79CkPRjRrTXh2BSmrhYnwCVqF
 fXwm9/YUjBRWBGyM6TXomT8nhINl9PY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2825381037
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:19:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439168;
	b=zaMC2aKYafUUCgu07QYz5Wu0z/Pls4MkuaLWvzeatMeTN+nsp7G8xI5rsdTpIVOjbhZ/6L
	LwmlD0BRsKqqrtbey9RFVzO4GcDdiLwjyGAAs7n+EVHC5/fD8dbO+tpj7ima62fyxo+HGJ
	1mp85qfKzkcjtta9zfCHzJWR+phiIGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wKG0KaIPm+7ebFZ+H3FrhmBmlGLT72h9PJAy/bxlw4k=;
	b=sy3fwHgRfmxUhtwr8g/uk/3YGF62u5HWipA5OPavnswlaF4N/zRm4QAzWZa4P/x4yEexpi
	8CWmaly9IJYiYYArpxpdxM+k1E8N6NhqzdKvtbGP4j+vzo6RfbyyRT4FnYcytZWaZtuUbd
	Mrn/rCHtM1qi873/PDB2afS/HNPRruY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RmzlzWzX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 44D8320CDF;
	Thu, 30 Jul 2026 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKG0KaIPm+7ebFZ+H3FrhmBmlGLT72h9PJAy/bxlw4k=;
	b=RmzlzWzXWLacXUFkGyJFNKR+HVwZewmY1LLz4SBBHuTuHgHafMVBr/n9Ey6OR37qeBGp2/
	r201P/Adk5cOHDg/1xSncbUWRd8emO9wxZCLxveMJfONyKy/OkTly+SvYkglpOZROJoajX
	AeOq8+3KNRbTpWeBWHMu7tyQ9hSel+0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:18:56 +0200
Subject: [PATCH 2/2] alfred: Announce changed data only after it was stored
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-notification-v1-2-d7cf675220e2@narfation.org>
References: <20260730-bugfixes-notification-v1-0-d7cf675220e2@narfation.org>
In-Reply-To: <20260730-bugfixes-notification-v1-0-d7cf675220e2@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5353; i=sven@narfation.org;
 h=from:subject:message-id; bh=cvgJR/Mu6S6VH1ali9QHqGR8dDcoBLTdilJK/9mBlI4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZixeUp694ZuD08tbvsFOzUjm3nntkcG7BT/2tmVvOm
 gc8MzMS7ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJFOBkWHPjIpHLEJ8BxZs
 FTrvbanskhrzlkUla89mzrU1vFlpBgkM/5Tjs5PMlx3c27fhcLLP98YIo7Wxy+cGOX4TSXezNy+
 SYwEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QTMGCDVENXG7XMX63XVSFFUAIY43ALDN
X-Message-ID-Hash: QTMGCDVENXG7XMX63XVSFFUAIY43ALDN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QTMGCDVENXG7XMX63XVSFFUAIY43ALDN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The event listeners were notified and the data type was marked as changed
before the buffer for the new data was allocated. When that allocation
fails then the dataset is left behind with a zero length and without
buffer. But "alfred -E" has already reported the update and the update
command will be started for a data type which was never stored (and which
lost its previous content).

Only notify the listeners and mark the type as changed after the new
data was copied into the dataset. And only free the old buffer when the new
was allocated.

Fixes: b106a7a36f98 ("alfred: notify event listener via unix socket")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c      | 41 +++++++++++++++++++++++++----------------
 unix_sock.c | 43 ++++++++++++++++++++++++++++---------------
 2 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/recv.c b/recv.c
index 76bfb30..929d086 100644
--- a/recv.c
+++ b/recv.c
@@ -32,8 +32,10 @@ static int finish_alfred_push_data(struct globals *globals,
 	struct dataset *dataset;
 	bool new_entry_created;
 	unsigned int data_len;
+	unsigned char *buf;
 	unsigned int len;
 	uint8_t *pos;
+	bool changed;
 
 	/* test already done in process_alfred_push_data */
 	len = ntohs(push->header.length);
@@ -62,10 +64,6 @@ static int finish_alfred_push_data(struct globals *globals,
 			dataset->data_source = SOURCE_SYNCED;
 
 			memcpy(&dataset->data, data, sizeof(*data));
-			if (hash_add(globals->data_hash, dataset)) {
-				free(dataset);
-				goto err;
-			}
 			new_entry_created = true;
 		}
 		/* don't overwrite our own data */
@@ -75,13 +73,14 @@ static int finish_alfred_push_data(struct globals *globals,
 		clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
 
 		/* check that data was changed */
-		if (new_entry_created ||
-		    dataset->data.header.length != data_len ||
-		    memcmp(dataset->buf, data->data, data_len) != 0) {
-			changed_data_type(globals, data->header.type);
-			unix_sock_event_notify(globals, data->header.type,
-					       data->source);
-		}
+		changed = new_entry_created ||
+			  dataset->data.header.length != data_len ||
+			  !dataset->buf ||
+			  memcmp(dataset->buf, data->data, data_len) != 0;
+
+		buf = malloc(data_len);
+		if (!buf)
+			goto err;
 
 		/* free old buffer */
 		if (dataset->buf) {
@@ -89,16 +88,26 @@ static int finish_alfred_push_data(struct globals *globals,
 			dataset->data.header.length = 0;
 		}
 
-		dataset->buf = malloc(data_len);
-
-		/* that's not good */
-		if (!dataset->buf)
-			goto err;
+		if (new_entry_created) {
+			if (hash_add(globals->data_hash, dataset)) {
+				free(buf);
+				free(dataset);
+				goto err;
+			}
+		}
 
+		dataset->buf = buf;
 		dataset->data.header.length = data_len;
 		dataset->data.header.version = data->header.version;
 		memcpy(dataset->buf, data->data, data_len);
 
+		/* only announce the new data once it is actually stored */
+		if (changed) {
+			changed_data_type(globals, data->header.type);
+			unix_sock_event_notify(globals, data->header.type,
+					       data->source);
+		}
+
 		/* if the sender is also the the source of the dataset, we
 		 * got a first hand dataset. */
 		if (memcmp(&mac, data->source, ETH_ALEN) == 0)
diff --git a/unix_sock.c b/unix_sock.c
index e6b44da..28752ec 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -106,8 +106,10 @@ static int unix_sock_add_data(struct globals *globals,
 	struct interface *interface;
 	struct alfred_data *data;
 	struct dataset *dataset;
+	unsigned char *buf;
 	int data_len;
 	int ret = -1;
+	bool changed;
 	int len;
 
 	len = ntohs(push->header.length);
@@ -166,34 +168,45 @@ static int unix_sock_add_data(struct globals *globals,
 		dataset->buf = NULL;
 
 		memcpy(&dataset->data, data, sizeof(*data));
-		if (hash_add(globals->data_hash, dataset)) {
-			free(dataset);
-			goto err;
-		}
 		new_entry_created = true;
 	}
 	dataset->data_source = SOURCE_LOCAL;
 	clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
 
 	/* check that data was changed */
-	if (new_entry_created ||
-	    dataset->data.header.length != data_len ||
-	    memcmp(dataset->buf, data->data, data_len) != 0)
-		unix_sock_event_notify(globals, data->header.type,
-				       data->source);
+	changed = new_entry_created ||
+		  dataset->data.header.length != data_len ||
+		  !dataset->buf ||
+		  memcmp(dataset->buf, data->data, data_len) != 0;
 
-	/* free old buffer */
-	free(dataset->buf);
-
-	dataset->buf = malloc(data_len);
-	/* that's not good */
-	if (!dataset->buf)
+	buf = malloc(data_len);
+	if (!buf)
 		goto err;
 
+	/* free old buffer */
+	if (dataset->buf) {
+		free(dataset->buf);
+		dataset->data.header.length = 0;
+	}
+
+	if (new_entry_created) {
+		if (hash_add(globals->data_hash, dataset)) {
+			free(buf);
+			free(dataset);
+			goto err;
+		}
+	}
+
+	dataset->buf = buf;
 	dataset->data.header.length = data_len;
 	dataset->data.header.version = data->header.version;
 	memcpy(dataset->buf, data->data, data_len);
 
+	/* only announce the new data once it is actually stored */
+	if (changed)
+		unix_sock_event_notify(globals, data->header.type,
+				       data->source);
+
 	ret = 0;
 err:
 	close(client_sock);

-- 
2.47.3

