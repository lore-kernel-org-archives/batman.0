Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A196AC79F85
	for <batman-adv@archiver.kernel.org>; Sun,  6 Sep 2026 15:05:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF765833D0
	for <batman-adv@archiver.kernel.org>; Sun, 06 Sep 2026 17:05:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788707134;
 b=NnXKGqJqZJwXy2t9GimiF65FQUtI+txzqpZFZrepzGwlreN1on5a01yjt5hV7oVqa06ek
 Xs3gIL3wESmhaU2BmvpMD/JdqUN+nWBobcICVcKueYVOyTEpJqp/HCGqDB1kkBO7Y9J5iSW
 GZ3lRYcJJX4Wx4kqbEAcj6ePh19Y13U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788707134; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m1EF3XwW1vv/8GdKL/MlJ9QBbK3My2jjkW/+9pO74eY=;
 b=FITpZd8ulSAbjFLrLeHkBMSbuoTgsfJhFMMkPUgr2qYG6QwW2EQnMha60/Ivs78DYMHTR
 GXLpA8tSa2/W0H5yqiWjUuOVrQ0v26yCrgJ1BHjEHTp6fRQD/0/YBGxTjL7fK9CWuIHWy4U
 aozPcNQnQjhEj0RytOFy8kcIUcFTDdQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 31D39807E5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 06 Sep 2026 17:05:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788707127;
	b=VhiMZmY5DYMbWv8axGp8uDEWOdOGdEjHtQKJyJwYlUUVZ59dPncfhpzuUVGEAw3FO/Unnu
	x4KQ/omfUkoHj45JZiK8bxaxRjTxljxFVoXjjYQxZo965F33wJLulnreLpo9c+DKj1Cv1z
	x5EXLgqHd1HpEXXMGr4QSlpARA+qYPg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788707127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=m1EF3XwW1vv/8GdKL/MlJ9QBbK3My2jjkW/+9pO74eY=;
	b=gS1hLKfQ3T3dkIC3daaY4TPFAWNmAnQPJoOS5wmnuugKnKL8B62IkAIQefec4x8UqUMytR
	uBat3hgOQ3EiXCC6z9XOn5KCKuisDiFU51nZHFtoH1G9fynsOKnr1ULsFXeI7DPl0Ii5Z5
	/q0eQpHN2T+zJpkvwN4gmK00Mn/KFjo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="bRb0lld/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 435CA202E1;
	Sun, 06 Sep 2026 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788707112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m1EF3XwW1vv/8GdKL/MlJ9QBbK3My2jjkW/+9pO74eY=;
	b=bRb0lld/amPfV9uvlT2GL44pb9kb7ehXWlOGaxV5t1y5BAVPkSJtIYYuOKs4TOJVgyKGY5
	X0Wz3gvWdW/Sy5fmtZoONJLIqhoabZaSqR6fvOJIDWPMT0y1t9mW81ALSOVEg5w5GOQIQH
	0cbD6b+cRYAm5iF+eOUBz5bCfo2tJ94=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Sep 2026 17:05:01 +0200
Subject: [PATCH] alfred: avoid leak of dataset on buffer allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-error-leak-v1-1-d10c21d3ab9e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAByBnWoC/yXMQQqDMBBG4avIrA1EaQPxKsWFjr86KlomthQkd
 zfW5bd476AAFQSqsoMUXwmyrQlFnhGPzTrASJdMpS2d9dYZqG5qFjSz4cL3zA+P9glKwVvRy+8
 /e9W3w6edwPt1oBhPNplB5W4AAAA=
X-Change-ID: 20260906-error-leak-c19fcc49eb5e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=sven@narfation.org;
 h=from:subject:message-id; bh=fLhGYqDSCy7psI4VgiKMkt9tJ+dX+XMc+PFTbdBURRk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlzG+Xim9Zzaj19/umA8sf5D7dlPFvhdCJ3S5ryGc+Dl
 V+8LvM2dpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0tXA8D/ul4v9vImW8eLv
 b0hILw78s37jng1XMsR6DBxu/TtcqpfOyNCa9+JJaNpGnrQczi+Mh7yS7P6GV5Qlh++buzlS7FC
 EOR8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: M4BIJNUR7BUAKXM33Y4JSHPU3VA3L3LZ
X-Message-ID-Hash: M4BIJNUR7BUAKXM33Y4JSHPU3VA3L3LZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M4BIJNUR7BUAKXM33Y4JSHPU3VA3L3LZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When the buffer of a new dataset cannot be allocated, then the dataset is
not yet attached to the hash (and doesn't have a buffer associated). In
this, case the data handler functions would just jump out of the function
and leak the heap allocated dataset.

The newly allocated dataset must therefore be freed before exiting
functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c      | 6 +++++-
 unix_sock.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/recv.c b/recv.c
index 237254f..3b849b6 100644
--- a/recv.c
+++ b/recv.c
@@ -79,8 +79,12 @@ static int finish_alfred_push_data(struct globals *globals,
 			  memcmp(dataset->buf, data->data, data_len) != 0;
 
 		buf = malloc(data_len);
-		if (!buf)
+		if (!buf) {
+			if (new_entry_created)
+				free(dataset);
+
 			goto err;
+		}
 
 		/* free old buffer */
 		if (dataset->buf) {
diff --git a/unix_sock.c b/unix_sock.c
index 5ad2667..b02eb0c 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -195,8 +195,12 @@ static int unix_sock_add_data(struct globals *globals,
 		  memcmp(dataset->buf, data->data, data_len) != 0;
 
 	buf = malloc(data_len);
-	if (!buf)
+	if (!buf) {
+		if (new_entry_created)
+			free(dataset);
+
 		goto err;
+	}
 
 	/* free old buffer */
 	if (dataset->buf) {

---
base-commit: de0e9bae7b5bf68406d26224d56268901ebb0480
change-id: 20260906-error-leak-c19fcc49eb5e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

