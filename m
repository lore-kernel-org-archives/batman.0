Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106E606A31A
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=OtAXISVz
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5AA4185A2B
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 10:00:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793005244;
 b=wlRMXkY0X0dWFUxUD03U9EUtbf+eTnjxbAnog0Ayn42fTu40bcsrE5X0kISnqXIV1hC9T
 YeykHtvGk/LojCWZvyL4BHhob1iCHd/5l5R8LxK2Peh4veE2Ts9rrGA9NE2WBlcNFeaia0P
 gmrThTE8nz7DVuGmE0pKXvJu8hahA2w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793005244; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Evk3sUQ7uuIJybpzKewVPlKXeloIYVZQPgkkBsr6TKw=;
 b=VEdLanIJhfjXaHSk2C15qAXHijYV1RFd9vVDQt5v0Y88uK/Cq/sRmavbdMMcFA4TjeyKy
 MawALX1DDlIH7dJ5X1valoXvwlbAT2XNEANPuNr/zmIaarOkN7ISSniO5RH/MWyUF/yYHdJ
 DEm5GWosz7RWokJPYK2G/aarCgeETHg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7CB1685434
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 26 Oct 2026 10:00:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793005231;
	b=xhrTiUKmsbgiP8N4lQ/LqZwysBqLdvV2/MxRo5vGOYiEV/qve9LJNogiG4gNfEeHNDIlfZ
	xLWYKFBEFYs5dGJDGKYv2equB+lhTnsIF5dXJArYHK2GWZrXesOQr08tKaHghjpWWuPNUA
	RLDbRHr8Mv0FRTuHDAU7egN5lKjfjRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793005231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Evk3sUQ7uuIJybpzKewVPlKXeloIYVZQPgkkBsr6TKw=;
	b=c9SXhnfum0dfJ77527oDyiww0ms6tSzYir3xXQiAmxEhIqCKV8xNMw5rKpa8xxLxjb5xhg
	twCHq3h1mL7qkZm4t8EQ28v9IF5Zs02pOeohiJKrlZwQkJElbXgv+1TCPrgBUpabfhwYEu
	d86CE+JQIQs5xnndyCZC+i5zmzCGPL0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OtAXISVz;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5973CE5d80fc8dFE94a24022d.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 44C80FA0E4;
	Mon, 26 Oct 2026 09:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evk3sUQ7uuIJybpzKewVPlKXeloIYVZQPgkkBsr6TKw=;
	b=OtAXISVzzPbMT2SniOfbSxTeRpfNBErpT3ifOkk/vWq90IzaqVJTDq9oOfM4GMWxwQa03F
	5QIIWhUJlwPtpAAyHpobMCEWRvfNMRzzS6E6K/FdNrgMIkUKE/CvID+LSfYLlRs/2yweOf
	0LDUZMX4rBAmFSwGb6iFS/HA+QsQGRyYrkX01tJhu+vAP0qNk9CKxjhXM5jyDkovNkJAcp
	BoIKzLwEgMjD9RxPO0ra9DK6kNuV5u11YI0Ab1zIhl3vkKAoqjJFOCcKbYBEZsjU8mYfXl
	OBxRvhRCFVwFbnGX7c9H8i592m4AjkQF9ILKh5C5NwV9N7Flm0a7I8uh8fY6wA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 02/10] batman-adv: Close OGM aggregation before
 transmission
Date: Mon, 26 Oct 2026 09:53:01 +0100
Message-ID: <20261026085309.1074911-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: D5EP2PVQTBFHO2OBWHHVJVQ3MROQ5J37
X-Message-ID-Hash: D5EP2PVQTBFHO2OBWHHVJVQ3MROQ5J37
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D5EP2PVQTBFHO2OBWHHVJVQ3MROQ5J37/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengfeng Ye <nicoyip.dev@gmail.com>

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Mark the aggregate as full under forw_bat_list_lock before emission. This
waits for any ongoing append and prevents further aggregation. Emission
uses packet_len to walk the OGMs, so all queued packets are still sent.
Keep the packet on the list so interface purging can find the worker,
wait for it to finish and free the packet.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org # 4.10.x: 434becf57bdc ("batman-adv: Limit number of aggregated packets directly")
Cc: stable@vger.kernel.org # 4.10.x
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 158d2b8f04036..85e99506a53f5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	/* Mark aggregate as full before forcing emit. */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the
-- 
2.47.3

