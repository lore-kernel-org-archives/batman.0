Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD95FC624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:54:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2619181F97
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:54:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184462;
 b=Z67amcum84nmgH2YZip37FGJ04nYkKAYezJPd/NgCzZIVKvsTRwYpK8GSVTjtiJD+RzXq
 3phdlwPy+5+3n2C5zGF9yYvaI7NYH6AK1iIBix6Y2Mir2l02tqMqoHYm35kgzC/6TJgizbH
 FReRMGtWDYkV6aqyEi3JzesAnr/FdFs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184462; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f4h/XBmpl/DRMN8KGH3elG43Lip1BkfAzHomEY8fyjs=;
 b=qSS+ZpxlP5xPVfr09zxaSgaYpHQuGR6hMhGpBO2Ks16YV+g7IlFeT4HBp3h0ltuYwM0z6
 VXkgkqL8KyZPaBpYhwVW92xTXTdZ3xxBldRoSt3jL4Jo57xJOr3uD4CRWf2aU+xTe3E0DfO
 3cHGMaaA3oHTArZyYW9gO3shEaxvn6o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F111F81958
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184301;
	b=Ctol7s7ArXq7F7z9IrWx2h36qfXqEjmlwuXN8TP0nPkeMsYVjOG5nVesmDR7YSu/7VcuBm
	W9SDF75WKO71pn6o4jKQH6RJu9qAjGrl87NhoyRXcrRJ5Jmu/xrsWtFujCMTamcKp+FngN
	uzEeTa4GH7arsqWqVtdIymnbp0WfuK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f4h/XBmpl/DRMN8KGH3elG43Lip1BkfAzHomEY8fyjs=;
	b=OJmhMvCC+dr5aHtxI2IDms7bi/e3bOz59FoDnOjxXiKDEB6+6CZP2CSPC9wgRa4XTkbVGK
	cLSbbmoH4Zdlj4+3+Fr1R0w8Z26KhDdk7eoMy/4j8L6XwGXdkk/+YzZTDICdDjLPywln4p
	o/9q5Uq7rLU1Fv8wBNDVPGcu7zujF7A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ng19PBSD;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4C879FA154;
	Mon, 31 Aug 2026 15:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4h/XBmpl/DRMN8KGH3elG43Lip1BkfAzHomEY8fyjs=;
	b=ng19PBSDh/kairXFd7AKm2VCPdy7tlFaffRlNlvJuWu9U8JX5MphM6mRwa3XM7c4e03TTi
	/nm/jql227P6HKV1QDlcH2kFCNMnphEW+f2kJeM11kBzRhTPBgecKoNZoVXwWr05dtNmUW
	ZjQi6FNHGzJEkHvLyO1DSvXO8zlpeoMO+Gt1HwZw8TQI+VW+6jHbOiZjxhmWaeFv0t087N
	dftfSbeKNXqcFtYVB5Wg1WDdIxCCcCbQBgtpQwhZfDjrhkhPqvEl0TtNynC4sNQV9HNLcf
	JyGTUbrNc+zJa5DP+w+7v/ABY6Exbd61NZBw7otZtOlm7aT2NJPPPHDYUlfUmA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: bat_v: fix bonding candidate
 selection
Date: Mon, 31 Aug 2026 15:51:05 +0200
Message-ID: <20260831135117.574836-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BA5JAYEWFZDJXAADCCYJ6G37LTST4U5O
X-Message-ID-Hash: BA5JAYEWFZDJXAADCCYJ6G37LTST4U5O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BA5JAYEWFZDJXAADCCYJ6G37LTST4U5O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_v_neigh_is_sob() implements the metric (throughput) similarity check
as:

  neigh2 (the reference) has a better throughput than 3/4 of the neigh1
  (candidate) throughput

But this results in a selection of bonding candidates in
batadv_find_router() which have a really low throughput. But the goal must
be to select candidates which have a good throughput.

The neigh1/neigh2 operands must be swapped in the comparison to use the
reference as such and select only neighbor+interface combinations with good
throughput.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0c27447cf6889..2d3045733db1d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,8 +519,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh2 is at least 3/4 of the
- *  @neigh1 throughput
+ * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 				  struct batadv_hard_iface *if_outgoing1,
@@ -540,10 +540,10 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	if (!ifinfo2)
 		goto err_ifinfo2;
 
-	threshold = ifinfo1->bat_v.throughput / 4;
-	threshold = ifinfo1->bat_v.throughput - threshold;
+	threshold = ifinfo2->bat_v.throughput / 4;
+	threshold = ifinfo2->bat_v.throughput - threshold;
 
-	ret = ifinfo2->bat_v.throughput > threshold;
+	ret = ifinfo1->bat_v.throughput > threshold;
 
 	batadv_neigh_ifinfo_put(ifinfo2);
 err_ifinfo2:
-- 
2.47.3

