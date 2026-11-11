Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AF606A8BA
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jl3spfgs
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B6A1802E6
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:28:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794392922;
 b=i3S5Ipc9jAXMeI+iWXChoh0BNU9Zum739+FO77PIOQTbNgQ2WfYVsWDieNLBPCXHoCZFE
 v4J6bt02UZyNd6cmTAZaw34if++4QDATUAIg5+I/lQZJsDISG98RZ8ofzf+u95Gx144/hsg
 iYwSbLAc9OO3iVgHxu3VUj35d6JdDZ0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794392922; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HljEgh7Ck6LSl06ejQODxRbfgqi7X5YtOB5itCLKdOU=;
 b=YXhYkZX0IPQ9fF8zpAIze7hhRte8sxANGuWwFUaHTA6GQOCX0TLy4s4/9mhM9GJucCUyB
 IYwiqmTJOsb1oBe5NvdW+FIE/3+O1eEsRoaYHnD3rXPNszFZmR0LU8powzJNDUqX7EVfArn
 UYC/mLZwtXIspkIf0R0DGbLJk5NodiQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 74AD080984
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392863;
	b=V8/0w9sKr30cuoUd6pKp2UR7D8RJztaMG7kHX4x7s8ZGUcf0HSq4mHm0Kg8XXrFyKQMrsz
	A9LGcikRjphrfu02Lp6iBUp3jUZpo8/glB0V9r8LhVFtxIdHaX7IqO5FA6+9tTTJ7Lr8A4
	8wO4mr6VCXQt0uDhDlkdCgIa+14WvdA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HljEgh7Ck6LSl06ejQODxRbfgqi7X5YtOB5itCLKdOU=;
	b=HRLF8bTfbu1F64EBF5im6uj5791z0tifn+tbq9LwCWoNsi9fkRW6VpGSznwH3OKmAunDEY
	XrjV0gLF8ZZ/bj63KRUnOuD+oiTvj/N4HpItcqXVNDzVyy5Gm1neKt4WOFp+TxU+Rx2u/l
	jz9gNNR5NCnmFBmhJFQsVc25v9fGkX4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=jl3spfgs;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id B6600FA112;
	Wed, 11 Nov 2026 11:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HljEgh7Ck6LSl06ejQODxRbfgqi7X5YtOB5itCLKdOU=;
	b=jl3spfgsr0g3OoqjUiEqZON+IaYXqi/1A5JlwfKjvZDPXI+BNEeJG82Sx4F+WtnIQXcuU7
	ppsNSfR/JGcfjBOw6gZ17wkKsdZwpHyqkWSkbrZGKls2VxySIrgdlzaqK5I7Pckbg63eNj
	7P/K6+AVFNaanfRCNjnq7lvIP44nGsvOdXjYgcDs+Uyu3+HXkxKbkBr4qYtme4WqD5Y4FJ
	xA6menFhbMdYppWR660rLak13EX8MuG6Agu6PLBPC1vDwMatBahDgTY4CxBp0FFx7I03rB
	qMJqv9MB3PE7R500R20932WvFE+fSC5o2ALGn6p4eVXlYDxYK8AJtrciy+vQpg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: mcast: explicitly initialize
 mcast.want_all_rtr{4,6}_list
Date: Wed, 11 Nov 2026 11:27:16 +0100
Message-ID: <20261111102729.2096241-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EAZY7W4SGGYSLUFHMG77HJI43HPMQXSQ
X-Message-ID-Hash: EAZY7W4SGGYSLUFHMG77HJI43HPMQXSQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EAZY7W4SGGYSLUFHMG77HJI43HPMQXSQ/>
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

From: Sven Eckelmann <sven@narfation.org>

All mcast.want_*_list are initialized in batadv_mesh_init() - with the
exception of mcast.want_all_rtr4_list + mcast.want_all_rtr6_list. At the
moment, it works because INIT_HLIST_HEAD just initializes it to NULL and
the netdev private data is already set to 0 before being passed to
.ndo_init.

For consistency purposes, also initialize mcast.want_all_rtr4_list +
mcast.want_all_rtr6_list explicitly.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3b9fa861be7be..cae2a48fa0ad9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -216,6 +216,8 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_unsnoopables_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv4_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr4_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr6_list);
 #endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_HLIST_HEAD(&bat_priv->tt.req_list);
-- 
2.47.3

