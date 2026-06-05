Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FF0CD6E74
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:27:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3491E83F91
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:27:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644476;
 b=12AmF2/yIDHm2C9XYAeSksmpwhJHQx8WlbBA+ftPoMeNK4emBIF9vNfvHqBQlQs5B3Yqg
 27qXUY4BdMwm2eW7hylwtQ0RrwH14lTrnwPYZwE1h1t0BNm9o84wh4mZIoaWnQuu8ylhyFO
 plENSaD9Uzc+K8akvoh5npoRbllxm94=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644476; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Min51foF2kElplOUTaOkcqj5GJmfwEQQHqIG5in0FV0=;
 b=RVoPyYbWXFpKc9D7eU5CJC6w6963hatbhd4/lTgIlthxnXqiEGLOjWFWvmJsSibTeK1Qn
 seb+TahyAr/GdlC++ub6ffLO62zSe1Qyb02NVKQ6qJvFouIIzOp3CXTOIHnbt3DIy1mWf49
 kbdXIWRnVfum4cVn6/fi5KVemtmMG7w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9232E81122
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644019;
	b=DaZZt8cQnyo3s7+aDEr9i+PsSsW1YOHytK6uDcbqwz0cZqmCb6NoBfH6fOCmuouMsLSqw5
	oD8UmLcLiAnAhTVqej3xX5vyzbnllqcTwQhEwYaTWdFKl9dewqZFa9aDaX+NN9BhL3CQFp
	v+aHKR34Mam1CrL8lmI2Zf53tRmC20U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bWwsArv3;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Min51foF2kElplOUTaOkcqj5GJmfwEQQHqIG5in0FV0=;
	b=WsWBuG9fMRNU3Ocz5T12f2f47oryyxqg055rtU1X4CNFMKZUQdkToeeGAlvfW+6bd3hxcM
	iYVKUqlagPn+LmDCPLZl9nPSZsUY57wzQkRtZb7qLCIQ2Iz/IA83YQKbyA9RD1l87T9Rv6
	S/8mrmr12Mn+88HSzxuEg0jhJef9kcs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Min51foF2kElplOUTaOkcqj5GJmfwEQQHqIG5in0FV0=;
	b=bWwsArv3bgYIz8xIy1AK/pUEVTmitbggph35VEwNo/2dnvjiYQPn84R6HMrFAMgjUszKlE
	lZyztpRKDerEKmMTKKQZtDC3WuEb9JTMdwEu0KDLD2vMlYSYkW8vuAarFPBdjXzlLRsfGC
	nwGYWvMsqZ9oK1ej+bs0YvAdOKf4dF0Qpiqj4Dm5c+4NUCgf5UA5vLYdlaiTAHeeSmPoCj
	+QfwLLtAYFEZPFtfmoJ11bEE5s88Yhfs+Mp/BdRy6d9ovP2k/PjiOKV8cezVQRbi5uKx4i
	XuN4i8EjPAoG9s+QWuOxKFKrW5Ch00GdL/TQGsHD7m+2DtJIEOnizUDSQLOc5A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/11] batman-adv: fix batadv_v_ogm_packet_recv error
 handling kernel-doc
Date: Fri,  5 Jun 2026 09:20:04 +0200
Message-ID: <20260605072005.490368-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XQZXYRHNR7O3GFHM627BDH3GDRXG72WW
X-Message-ID-Hash: XQZXYRHNR7O3GFHM627BDH3GDRXG72WW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XQZXYRHNR7O3GFHM627BDH3GDRXG72WW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

All receive handlers in batman-adv are consuming the skbuff independent of
the result of the handler. The "(without freeing the skb) on failure" is
therefore not corrrect anymore for the current implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 72ae8ffc9db65..14920f4bb315b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -984,7 +984,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
  * @if_incoming: the interface where this OGM has been received
  *
  * Return: NET_RX_SUCCESS and consume the skb on success or returns NET_RX_DROP
- * (without freeing the skb) on failure
+ * (freeing the skb) on failure
  */
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)
-- 
2.47.3

