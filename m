Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446DC5516D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:46:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8998183FE0
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:46:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498360;
 b=af6kDx0pgGP1uWBVp4ciODJIG8WRTrgGLVFearkLG9s4b1iQLRGmjtISHdNssoAC0quN0
 e9VEdj5V025Unno2Rjr1Q6Ag/ZvqYo1KE9HuCoja8HumiNsJtaLfwAI1kyMoLQAc7z6JI83
 /tDYenHoCQo4JHTRYZl90zhGRFth5jM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498360; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DkXfwfqaQVrTu9qdJcTWKU8kqqP+OgQMbrtkhMyz0+g=;
 b=xfuygttxjKOkFo6jKIm7YcJv2D1LLKRThyWFbHuCNfzJTSwIMvxn7oO3jTaeUiGRPgV+a
 fUtikGFMWcMI2BmD6qbdmnC9XY4OQER//0qVg3WAyIQ3W8TfWp9OCR7sXe4vBcyrFL/+Nu8
 lRfv7rIDhHpeQ9yYhOZDZvYjobT7oSY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F234E8323D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:45:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498317;
	b=FX6Wwq8Q6G3w9I2Cy6dzKUD2jD86Eye99jMMpx3yarFqoBfpnf+lJTByIyDTEJsby9nn+0
	f8GXiljrmy9ItMuXoCOvqjL+iNUMDY1LK1Ycx3ooTFpoyYCduXXZKeUiLxkAynEcs/nOSI
	KG8yLHrlVG5aAj3nrgo/5cpAF+cp9is=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DkXfwfqaQVrTu9qdJcTWKU8kqqP+OgQMbrtkhMyz0+g=;
	b=kxikTMFX3nJNPPf7vn9IPQNb1nEJUk9TzWM8F4o2kQfbkhXevZByvl9dVY2wrtyfxbLAWs
	C8UB6QfOZOVEnlnKge9dvWmJxBTMtfD63sLI54Y5QdxpUMre4n+/rp4fWaIM/oANs/F/O0
	Tx8VlXyQrsOXXDd7F+obqFWi6nSl+gY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="CEh/ZZZF";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7D0F720CEA;
	Fri, 31 Jul 2026 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkXfwfqaQVrTu9qdJcTWKU8kqqP+OgQMbrtkhMyz0+g=;
	b=CEh/ZZZFAajbYqaVGuyjq+I/v1/WHPWvMwP4G+gX2sn1tTxd9WS0q9TSJ6z3zWVVIS0PDG
	o754WMk1Mu6HxRktFxSmzRaSLGYYFPdQj2rrEFcmgRQdyHYL8IPHpnDRabNpU7h84YsEEF
	jnIzv4Xbk+Xdc1k0+nSzyeGDuaw4iqI=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:50 +0200
Subject: [PATCH 1/6] alfred: fix off-by-one in client interface name length
 checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-1-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=sven@narfation.org;
 h=from:subject:message-id; bh=1NbNoiuf/bBKWSSaOHjtQFzFlB4UP++TdRLoYzYW40Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZtePg1UjHzY+etpqujfAycinMRy7ga8+LxS0eUR5
 6nr6060dJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8kOW4X/pLV+lINOlCgu+
 HG2YtOPd0wVy7znr76ts/v2mJ0D4l90LRoaX1289etOz6mV0MVONNceUwtwt39Pumeys4LrhmcY
 aF8wHAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UE2FHT3B636UE53SNLF5F4AX4PFKNOEO
X-Message-ID-Hash: UE2FHT3B636UE53SNLF5F4AX4PFKNOEO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UE2FHT3B636UE53SNLF5F4AX4PFKNOEO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

check_interface(), alfred_client_change_interface() and
alfred_client_change_bat_iface() rejected names only when they were
strictly longer than the destination buffer. A name whose length equals the
buffer size passed the check, but the subsequent strncpy() then filled the
buffer without a terminator and the forced '\0' at the last position
silently dropped the final character.

Reject names which don't fit including their terminating \0 byte.

Fixes: babd772a36e1 ("alfred: support for changing interfaces")
Fixes: b96cc742ef3e ("alfred: introduce 'change batman-adv interface' IPC call")
Fixes: 67ae5f57eedd ("alfred: Add support for multiple interfaces per master")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client.c b/client.c
index 9fa9f00..f56042a 100644
--- a/client.c
+++ b/client.c
@@ -222,7 +222,7 @@ static int check_interface(const char *iface)
 	struct ifreq ifr;
 	int sock = -1;
 
-	if (strlen(iface) > IFNAMSIZ) {
+	if (strlen(iface) >= IFNAMSIZ) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
 		return -1;
@@ -262,7 +262,7 @@ int alfred_client_change_interface(struct globals *globals)
 		return -1;
 
 	interface_len = strlen(globals->net_iface);
-	if (interface_len > sizeof(change_interface.ifaces)) {
+	if (interface_len >= sizeof(change_interface.ifaces)) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
 		return 0;
@@ -311,7 +311,7 @@ int alfred_client_change_bat_iface(struct globals *globals)
 		return -1;
 
 	interface_len = strlen(globals->mesh_iface);
-	if (interface_len > sizeof(change_bat_iface.bat_iface)) {
+	if (interface_len >= sizeof(change_bat_iface.bat_iface)) {
 		fprintf(stderr, "%s: batman-adv interface name list too long, not changing\n",
 			__func__);
 		return 0;

-- 
2.47.3

