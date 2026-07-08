Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896A3C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:20:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36BAE84B63
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:20:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502438;
 b=lmpBvh4WRulx0Afi+uBf0jZTNNAKVjN8ukZd3shCJVoZJ5EvZ0YRB56k5yQWxpObve6Ln
 2sWyL06DPsw61RjvRWmI9rBS6ZLb8r6bM0o4rWNu2JbsGNzfyySen023AhMtQo9DhXOLEOV
 AWl9z7kDX9vuLsqh68Zai1XjI4gTZ5Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502438; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZFpl7pK3uTWz21nbIM7Bm6WBFUQXvhGQVbOYY5GDip8=;
 b=10cWtOFkYHeRlGRp8zUffif/ZZPHSZUdH1V6Bra0PNNiByd2wRQ1MEpycQbNT04symnIM
 oxZFL95hbmExxH7SuOFIfuoDht7O1IQfwE6K/7eu/cBWmdu9EuejN//9e70o8PM9429j5yl
 riKH0ftclKWgFbfalt6ceGg8z9Nbp0Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 64BB7802A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502324;
	b=lv8JXTB5wUWaHy2Wu4K8HxV6RfwWxQnAvb3THmv5HUUKGRrVemNxEs6CuuQxjmKf2HaRlH
	QNvipIMjoKq15XNaD08BDPULsv94vhb+Y7zHezO4HGENpkKTQasnTCYt4NzzTM16udzTL2
	8pNIaOEJo0w8Y/sJ60vF1kntjcYdu5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZFpl7pK3uTWz21nbIM7Bm6WBFUQXvhGQVbOYY5GDip8=;
	b=kE6aGEuXyAgeMwGA25LGDw2/wde1aBC/P+OLSV5y0UgPUS3cI17/Ki0oJuTmEoXqJ6QTKv
	us5TEUEMkbn9ZwvpPTitjHzPaOFyby8/AfRjKk/2o6zRBC2Ba+UngbExZpX6ypxcXkZnrX
	/m5aR7hWtOM/NfTMCPsYsbomQMpkwac=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=nqnZQX4z;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFpl7pK3uTWz21nbIM7Bm6WBFUQXvhGQVbOYY5GDip8=;
	b=nqnZQX4z5ROHJ+k22LirLdDuCstF4g31h8fMI0/Nbgter3bg7D6mJ3zwo92wWyivEtJfWP
	FiA8o8zt5b/A5SRdTOCKDPiTa3k+h5vGMtb9X31J9a2PnY+/fEUmYnfGGIvnYN5JuDyfuz
	SiwcZLdw39gKp3Kxzed/isMmWEnCiig0a78U6GKeNk+tzVjTBOUb1d7H03laG2ZESaudNp
	4PEjOv/ubsMckI5Me+UMvU6NTSVRQ0kNhxEcW117t/cKlGy2ASCBuF5xloEI6NFbR+JZ+F
	M4O/zWLem6VFyk7YV+wZYdDtvGItGSSiFzKU6U3KRMJrczVs/UXfd8g3xUzr3g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 5/9] batman-adv: tt: prevent TVLV OOB check overflow
Date: Wed,  8 Jul 2026 11:18:17 +0200
Message-ID: <20260708091821.314516-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5M3TTRW2JQTVQXCPN5HDJR4YSCLNYGLF
X-Message-ID-Hash: 5M3TTRW2JQTVQXCPN5HDJR4YSCLNYGLF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5M3TTRW2JQTVQXCPN5HDJR4YSCLNYGLF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

A TT unicast TVLV contains the number of VLANs stored in it. This number is
an u16 and gets multiplied by the size of the struct
batadv_tvlv_tt_vlan_data (8 bytes). The size can therefore overflow the u16
used to store the tt_vlan_len. All additional safety checks to prevent
out-of-bounds access of the TVLV buffer are invalid due to this overflow.

Using size_t prevents this overflow and ensures that the safety checks
compare against the actual buffer requirements.

Cc: stable@vger.kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index aae72015645a4..dae5e1d8c0385 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4033,7 +4033,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					     u16 tvlv_value_len)
 {
 	struct batadv_tvlv_tt_data *tt_data;
-	u16 tt_vlan_len, tt_num_entries;
+	u16 tt_num_entries;
+	size_t tt_vlan_len;
 	char tt_flag;
 	bool ret;
 
-- 
2.47.3

