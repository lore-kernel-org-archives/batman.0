Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B22C02194
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 14:10:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 306BD83EF2
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 15:10:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738851049;
 b=0mTaMtade1b2edsMVZschJ8wZNryxvHadBev0juH+zOwOwbxKo+GvE6Qkts+HsmxtB4xe
 iHWfTMHrc2a1zYSOilkcWPquIfBOEOmx13LNKGs5Dw/SttoVRQQ7+jd78S+pVEU3Skku02P
 KyDmt5I7d0hdjBjCNrVoU4oHgKAtFSs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738851049; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
 b=nHc1RRcXfn4zXjgwqfWVAIR7NZ+DHi0mdtmyeehqZSbkjOA4zK9iD5X6G6L7aB9nE5dHp
 6n+gl9t96Y1gfKStKpNM/UJx1TEIbdeBtUY73H5y5NgOV+qbpgDieFUd19QUpYpvykbTLFs
 OzDWoV8Na1FoG2vXxLNiAmXj66DjyQE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=google.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=google.com
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=google.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=google.com policy.dmarc=reject
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 21B2881611
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  6 Feb 2025 15:04:26 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738850666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
	b=pITu8dTYQ9nmA6gn1dLGtjiHWuWIpUu9S9zN4OCFud+WORTZkD/qBsi3HbdMuL6TUlSEXk
	hgZTYrDuoURlHdXrvsLKAzcQd1jzYl09U6422bDTqXmfhqjtHDtLrH/jtMrK7YH3hjCBZM
	v2XQyb1FkeeE62AWvJ4aanhjgUIY6i4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=google.com header.s=20230601 header.b=l18oHnSd;
	spf=pass (diktynna.open-mesh.org: domain of
 3aMGkZwgKC8Elk1th6l0nvvnsl.jvti.h.0.t.h.uspz0z.vwlu-tlzo.vyn@flex--edumazet.bounces.google.com
 designates 2607:f8b0:4864:20::84a as permitted sender)
 smtp.mailfrom=3aMGkZwgKC8Elk1th6l0nvvnsl.jvti.h.0.t.h.uspz0z.vwlu-tlzo.vyn@flex--edumazet.bounces.google.com;
	dmarc=pass (policy=reject) header.from=google.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738850666; a=rsa-sha256;
	cv=none;
	b=OshYXS5NE6Fwkj74LJy8y5+/P6hyRlgw+esCV0b2oNrTsgaRA1R9tGlwNGzuzYYl8JrmML
	u2qvn2nCfA4BXh9fKvNeabR0acgsDweb9ShnaIlX/6w9AzrSYJLV4UipG6EM949bnuRY8g
	Ux6m9MfIcEl/v1hFvwtT7ZODG0SQDCM=
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-46dd301a429so20976611cf.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 06 Feb 2025 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738850665; x=1739455465;
 darn=lists.open-mesh.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
        b=l18oHnSdX6QBWTx0Z3TDzlgSOAl8I/PTwicctT+HXpPHwK/Gao5eDbCU7dKOnJVz59
         oAzFoKlMnp9UuUJh4+ZDKJS9bESUo7wtjRbYppbOi2T5xGcbTebRP3hCszNPxA0al0gc
         H+1qphSP1ibsG1iUNahqG4amvquMfvSpZykC0ookfWvhiVmwShT8EzoErKyKEMiDnIMR
         QL7Mi7I7tJud2nixrZv7zbfPYo+YwGQEx/CBzBZwpxgmXOAb215hKgAbkLvuAgeoESEi
         Lu108OouVG+/gPFkmUC2Ts0+N4B9MxQhyMAXh08/iiKf7PaemaSSCbMSmHFw/YjCvTEW
         JVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850665; x=1739455465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
        b=nvEoUMQ8wHxAt3Fz/OfNBO3pxQFzZNQIZdI1AzM5qYD5lmoF/O/cPmArGDw99QwJZ2
         bgLyuzhV2RcLn2xw4bXFOuLS5TuzJayryMcniFmUKPRfZuHU+5uHsEt6Tesg01aXn5qo
         /1JR+pHDovMgkUiqPFrYutFdLMzXH1OsCQTKJrtpKaeTrhly5bqj9hhH9+N2evmOOmhB
         uvzd7RTKnxJFxxnk/NUqkDVOMPZrVdNzOPZ8xpxdFe8rjrGM32+IdNTQeN1EA/kUpxcr
         tzi8b98SdvSff4FlZwGzVpVW9IEvi4EwcunLG5qgjJ0r4AN7CP7G5rkK0StsBvuHUo70
         O3KQ==
X-Gm-Message-State: AOJu0Yy7VlituQ0JUKvHFOpRFX6WxAEHXxprKr/tVtk+uFcCWcNhycPI
	FpyOhV1k//1KzlZ95bsjxKjMYVSnABMsOPV4fVF5nOvbiLnbzkuhvqs+DqJt7CMu4ddM02+8Jyz
	Z5WWBgL+y5A==
X-Google-Smtp-Source: 
 AGHT+IGmSvWzxT0JJEjR2UGpgY6nrETDcW9JU2BjWy3ffm6raX1CzjZuAApA5SzGLq9qKqB6TprTN843Sw8wFg==
X-Received: from qtbbv26.prod.google.com ([2002:a05:622a:a1a:b0:46e:4a3:1078])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6083:b0:466:9d0e:1920 with SMTP id
 d75a77b69052e-470281ce121mr80192321cf.24.1738850664781;
 Thu, 06 Feb 2025 06:04:24 -0800 (PST)
Date: Thu,  6 Feb 2025 14:04:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206140422.3134815-1-edumazet@google.com>
Subject: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
From: Eric Dumazet <edumazet@google.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3aMGkZwgKC8Elk1th6l0nvvnsl.jvti.h.0.t.h.uspz0z.vwlu-tlzo.vyn@flex--edumazet.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 4UTBEG7JN6WU6WKSK72QXQPCGARPL3AO
X-Message-ID-Hash: 4UTBEG7JN6WU6WKSK72QXQPCGARPL3AO
X-Mailman-Approved-At: Thu, 06 Feb 2025 15:10:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4UTBEG7JN6WU6WKSK72QXQPCGARPL3AO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Add a device tracker to struct batadv_hard_iface to help
debugging of network device refcount imbalances.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/batman-adv/hard-interface.c | 14 +++++---------
 net/batman-adv/types.h          |  3 +++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292d020462b6ad60b699 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
-	dev_put(hard_iface->net_dev);
+	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
 }
@@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	ASSERT_RTNL();
 
 	if (!batadv_is_valid_iface(net_dev))
-		goto out;
+		return NULL;
 
-	dev_hold(net_dev);
 
 	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
 	if (!hard_iface)
-		goto release_dev;
+		return NULL;
 
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
+
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
@@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_hardif_generation++;
 
 	return hard_iface;
-
-release_dev:
-	dev_put(net_dev);
-out:
-	return NULL;
 }
 
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0d198a15437d49ea73 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,6 +186,9 @@ struct batadv_hard_iface {
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 
+	/** @dev_tracker device tracker for @net_dev */
+	netdevice_tracker  dev_tracker;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 
-- 
2.48.1.362.g079036d154-goog

