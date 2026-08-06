Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFEC5AC67
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 19:21:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 101C980C4E
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 21:21:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786044078;
 b=1nxcuo/SnK0PuJWIaPy6Hf8teYYAxXHZ2vnlYtHsYgQ+PlvWU788YfXJ+24ts1mPrb/F2
 EgOXQWkWgbluR0GCqJSjO0QaUhmtKGZsur50rUz/t9iAc/PBKpP0qmtMrcQqIlJdWCJzxeW
 ILFIcStZS6J+T7GT+KXwqW1fnarP0Ss=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786044078; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KaMOR/5QzVWGwuPUhS6nzSud2DV8rVQmJZl+SI9vXzM=;
 b=3jBmiw3iCTI8Ba2ZJcAdKY2LnJunX18K9wMqWioYPlMvQj9y0MxYtg/fhDYR4hrTUNRjB
 RXb5I3cl91LHfolpm58SD/NR2s6/HEa26mZtDPNz2A5P8F18P8n8+JLhLh3zl+j2KZbUtvk
 7vl/uaOmlza8FK8+aJdo38wrM7EFDLg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E57DC83176
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 20:55:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786042538;
	b=A280WFPnTCL+LzhQxLMoZpxHHwWCTxUDxkfjr08bw2cJizWSNoUKbKCeUZZYfo/cO9Kgdn
	Lyzzm99Rl0/X3M17A7NlDtKxZWk3gtQnziuQ3KREFCc6CV2uoUWRJGySK/ptdr4cWAE232
	bou1fHDfKizOLE6zAO3idwxsdXymE3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786042538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KaMOR/5QzVWGwuPUhS6nzSud2DV8rVQmJZl+SI9vXzM=;
	b=DjrRK+UGoJPrqX2cwUzXaD6iyuc6H/A5YkpYsBgLi6be9Ljd5/Os5TYD/cDNuBOU76w0su
	rgP49M9TrkKzm3on01S2IfJNVj04YMNfYN+LWv6uZUbZZWmHTut/SJplF9c9gjWoxIaG1J
	t4hfZ/D3nLM1sbeJXz0htvHy/rt/XkY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xs8NheUw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1E03721B82;
	Thu, 06 Aug 2026 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786042534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaMOR/5QzVWGwuPUhS6nzSud2DV8rVQmJZl+SI9vXzM=;
	b=xs8NheUw9xmPZBb7ve+EvXfT+4A/7pdwNt/NxdXQh2rRz64vGAp6j1kNuNUtG8whG59ML8
	31b+fAizxX/q3Shv2fF5ZFgZOOhE2fHQ1UK3uIbh/yQqaDWkh+UzM8clHvN11SzTf665mQ
	dJv3VI6Hp2PakXxKCoqQtphbpX+DvHE=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 20:54:54 +0200
Subject: [PATCH batadv 2/3] batman-adv: clarify cut-off in
 batadv_v_neigh_is_sob kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-bat_v-sob-kdoc-v1-2-ba4d763de0da@narfation.org>
References: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
In-Reply-To: <20260806-bat_v-sob-kdoc-v1-0-ba4d763de0da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=sven@narfation.org;
 h=from:subject:message-id; bh=wolrYAGv7rUfsEhCwbiLA0UPvQ+is6h3G7/Cl/l7Tyk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklN1o3vi1dvVD/5IrPRQevtjod3Cz00eVK42L+Uyu+s
 SxVvXbEqKOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkfCvjAxtBc4T6mZ852pl
 F38y//M5zrk/1Opv/ZTTSTgc2dfX8J2B4b875xHLujXsX4snxfbUS6yc6XM/cZfTzDcZd1OubOd
 6xcECAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: E2YMK3V7DKEIJZTDJQJTVPII3JZJCJX4
X-Message-ID-Hash: E2YMK3V7DKEIJZTDJQJTVPII3JZJCJX4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E2YMK3V7DKEIJZTDJQJTVPII3JZJCJX4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The neigh1 throughput must be more than 3/4 of the neigh2 throughput. Just
3/4 is not enough to return true.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2d304573..0d0a226c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,7 +519,7 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ * Return: true if the throughput of @neigh1 is more than 3/4 of the
  *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,

-- 
2.47.3

