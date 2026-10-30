Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E460A2628
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=USkFtrcy
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4371183C3D
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:06 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368326;
 b=tyd8E1lW0QPdDpGIXrJTj6UOqXrxHsOQrWbPzt2NRhwCYe38Q8rPIuAMaCFo6cN41AnrO
 o42IhwhX/1El6/1AAEi5Xbd1R+MrPRw+DLSizw+Qj6bPQFnS44l9Ui25z6VxUlGCy6ihCD6
 ZX7DTRnI8nsROoXY5oW07bUc6j2pZPs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368326; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
 b=yedQCw/z2o+S0YZ69NVeqtIbArTlYdp0ZukcIZfsPA57wJr9Is9BPUFPpoj4pX/KYpjSM
 aYrlpT7wDRsOLq2lzI/nECuWgsQSaCXAHUHPTxgnJeVCd6eWSyjrab6b0RRcHHMkzdw9D9p
 MwNaeWnSy6qp1x+lXGtlY3oRQfpho/0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3A37A83C4D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368281;
	b=gBJifJ5xCw/3aiMuAySsF2Po8zDkxSyX4qKc8UREB9vlZLA9JP6M+bgucqksarZ5D9Q+gf
	AcryXtOIquIYKSBeFGVKuHUDs+VZoWefHbQLM0vOsl7lKC9lffnSebFVmQbp03RDxi7wIk
	PX03hiqRta6sy4lHoA25eB3vozUBnAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=s78s6Eew/CGBGwlYJJmi+KJic+UenLSLsVs49B6TrmQy6LtO3+RQCOn+KF9ZDu5QjAzANj
	wSPmm/0t7lZkkRB02JZGgxeXuzuuL74pmXWgA2jeRy1cLEZOOLGnTsIXOd9FPovAn7nsNh
	9pcYrTzzaO4OyBglv0H0NCtsGJMucNg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=USkFtrcy;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C597124FD839580c360d3Ed6f6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 77E09FA010;
	Fri, 30 Oct 2026 14:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=USkFtrcyMOqYC1d/dtt3DHlLDTIxeSO9r+PHyPIFuRt4VSeTwwnOzOqW+LOFD8aNxh+fON
	SKOj+NTTvt68WSA1/DzSo9wOGqcYZyTxHyWIlNGUNBSgoH5CfApd49uIcqf18ti1wDyOLg
	JhPco0wJVu/DyVlG8gaqzjyQoUKdUxG9Av3aZTFsMkBa2ckeNML0o8KJlzVilomWEj+JKv
	mV0LTX6NexMp5wFZMSU7U4GwKKMYQJzedxrvG23TOygefHpzBi7yseRt7y551bpiuUr3bG
	rv47sWEQ6CZF+J2XFedhnBNOUv1JsVL+uuLKKxIw29GpyPdWLOsFPQiHQmgQxw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Fri, 30 Oct 2026 14:50:52 +0100
Message-ID: <20261030135105.2555887-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PG6T5US7B4G4UBH6HHMFMWCSF6QJ7E5U
X-Message-ID-Hash: PG6T5US7B4G4UBH6HHMFMWCSF6QJ7E5U
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PG6T5US7B4G4UBH6HHMFMWCSF6QJ7E5U/>
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

From: Deepanshu Kartikey <kartikey406@gmail.com>

batadv_orig_ifinfo_new() returns NULL only when its GFP_ATOMIC
allocation fails, which is a normal runtime condition and not a bug.
batadv_v_ogm_forward() already handles this the same way, simply
checking for NULL without a WARN_ON.

Do the same in batadv_iv_ogm_update_seqnos() to avoid a spurious
WARN_ON splat when the allocation fails (e.g. under fault injection).

Fixes: 7351a4822d42 ("batman-adv: split out router from orig_node")
Reported-by: syzbot+a079f084653164a652d1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a079f084653164a652d1
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 89b499f7a37dd..158d2b8f04036 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1410,7 +1410,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		return BATADV_NO_DUP;
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
-	if (WARN_ON(!orig_ifinfo)) {
+	if (!orig_ifinfo) {
 		batadv_orig_node_put(orig_node);
 		return 0;
 	}
-- 
2.47.3

