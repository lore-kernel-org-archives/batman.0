Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D1CD8CB2
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 12:57:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4856B8402A
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 14:57:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781096275;
 b=DZKTq4+HZUQfZm7KS7Yz6wa4Jte1k5iHMe+bQ6px/JKiYgSYi3HBLj9CXLII7jrhQQ50K
 QUa47rkhvH1qjpYj43f9/yJ25BtfJ6V8oFf2u5DtN6FmcDx6BztrqmnxHfQ3KN8XCsRK6nV
 cigLCBBfXyPWGfDGUqTP41B2/02qojM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781096275; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sQu+UR0wPdUJqTKMQ3FnFKDsQvN939+GDRdzOwHoxJU=;
 b=xWhPItLMJ9NkjFUZ0/BnPBq/h3PMXvOOa8eGsW7mD/mGRwtCMylSIUmFygkOMGHjtpEzZ
 Rd7XY3RgX1AjljvibB1QMx2VYT0ZwWvULHzdLrDuuOYdwblGj097+4ud+LS5SxMw8KIRoVc
 uvlZcFiTtvO+Zl2677+EU64q/DBAvkQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EC44483C54
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 14:56:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781096179;
	b=znolI+Jwn+oZ4leat/4NtrJu3/yePkVHExC8DG7EbSfoHMS2Jd2rj7Nzalwyuw9C0UWnXy
	qg7FiaI7bVc69/uVeoqJn7+PlFTtF4vDJySUBLP5BSZZ6Fvnih0NkyWqQ7tPaWLXvYFffM
	GXugcX8Mn3Y/99czna9+UtcgPn4n/9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781096179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=sQu+UR0wPdUJqTKMQ3FnFKDsQvN939+GDRdzOwHoxJU=;
	b=0gG7xbludpNjEUHjbBigq87zskTL3JhkkTAKQXi6qO6QWxg10KJkZVz0IuosGJRPTGrjzK
	KIAPu+juT8ZoD98IWR63W7et9inOBtebMHlXozyivgVQ1JdsTTrfN2U8LCAdKI62L8JhXN
	93gWPdKQLXhjfwpb93Uszlcbqm01gqM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xQ8BrS4K;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 3D97E1FD32;
	Wed, 10 Jun 2026 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781096167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sQu+UR0wPdUJqTKMQ3FnFKDsQvN939+GDRdzOwHoxJU=;
	b=xQ8BrS4KmJ0mEqUZXA2XK1dvAEFre04EZANFxZfJ1T5BJTM0NvRSWWhdb9p/Q+5h6woqq6
	uo+E9Cm6Jw/f/WUWGPcCdEtxuxSH3mdpbCxSFf67oawLtc0+UhiddyLcq/J5WrHw5IC6M4
	co6k5j6M60zLmXTs+l7LcwV5dQzPVDk=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: fix broadcast/multicast "hw csum
 failure"
Date: Wed, 10 Jun 2026 14:56:02 +0200
Message-Id: <20260610-ip_checksum-v1-0-0fd7f471dca3@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJeKWoC/yWMXQqDMBAGryLfcwNJagP2KqWU/Ky6llrJqhTEu
 zetjzMws0EoMwmu1YZMKwu/xwLmVCH2fuxIcSoMq63TzmjF0yP2FJ+yvFTduCadja1NuKAUU6a
 WP//bDcHPPq24H16WMFCcfyvs+xefjjtKdwAAAA==
X-Change-ID: 20260610-ip_checksum-4969d31241b5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=sven@narfation.org;
 h=from:subject:message-id; bh=fIJSL6aFNtymk2zTyw6D7XiX6W0MKUa3Wx+TgPLupuI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmacY8Fr/v1pLWqbPe2/9uxYdeU/B1t6v7vfIv698bsa
 eAUVuDsKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwkmI3hD5dyrPH+zOjp3ro/
 ngoEmS7ecSr17aavdZK5qg9/uNq4yjL8d2X/wZBpNMnfPlC/uXYPH+8t72v3OspKd6/eKLhtqfo
 jZgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EWV6RP3KZGKLNZRNGUHLGFFVFEBOUX7N
X-Message-ID-Hash: EWV6RP3KZGKLNZRNGUHLGFFVFEBOUX7N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EWV6RP3KZGKLNZRNGUHLGFFVFEBOUX7N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Yesterday, I wanted to test the pending fixes for the next release on the
Freifunk Vogtland server. It was noticed that there was a

    bat-rc: hw csum failure
    skb len=96 headroom=304 headlen=96 tailroom=1328
    mac=(290,14) mac_len=14 net=(304,40) trans=344
    shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
    csum(0xfffffb8a start=64394 offset=65535 ip_summed=2 complete_sw=0 valid=1 level=0)
    hash(0x0 sw=0 l4=0) proto=0x86dd pkttype=2 iif=32
    priority=0x100 mark=0x0 alloc_cpu=1 vlan_all=0x0
    encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
    dev name=bat-rc feat=0x0000000000004200

during the start of the server. The shown packet (removed here) was just a
simple broadcast packet. A quick check of the logs showed that this problem
was already present before the fixes. The most likely culprit was a
modification of the packets before the local delivery path was received
(see commit 798174b15153 ("batman-adv: fix packet checksum in receive
path") for a better explanation). The steps are

* actually make sure that broadcast packet is unshared before trying to
  write to it
* unchecksum area before modying it and afterwards rechecksum it

This is tested successfully on our servers without any new Oops. And the AI
overlords only complained (until now) about an unrelated [1] TTL
modification.

[1] https://www.open-mesh.org/issues/442

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: ensure bcast is writable before modifying TTL
      batman-adv: fix (m|b)cast csum after decrementing TTL

 net/batman-adv/routing.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)
---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260610-ip_checksum-4969d31241b5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

