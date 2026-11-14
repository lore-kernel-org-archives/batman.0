Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD7606A32E
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=SBFTKvKJ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 46B0A85D6C
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:24:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648280;
 b=XzCkdHPpfipJWoxThEOvlevZ8AT/8qP22egwGNxFIYsMAAgoOwmUu7lAWg38GJY/ta5qn
 X0K2ra8taTjUwOVZs/XvYGXhF0cvplh1nJYz5aZiZ4SCZxon5KG20TYK78i0tw1Uj8kM42j
 /0r/vHZTuMpLAhySXX0Ee/Cneu3MKHY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648280; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U5fF9MUWlYEidvMrUipn+m0KX6+5jNKy7QbVVTr97kU=;
 b=oOOtR6j/sBfsWeRf6HzoFXQ3n/L0Uh4Mli1pKQ0kSfxwZCGUR84SdNagLXIT66zDVA5GQ
 bY2wluddala33o6fcAAvxImjSLoFI3IqZ70ZayHyoLQyvJeW3E1EnfRoRl/TYQkPpQBvEz+
 bOXLYnemOa+UO8fWp9GCSjG72xZc9YY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 287718479B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647783;
	b=UjhAABxal0dXZmVvDsvIr8uaUAhCWpRC0ok7/20q3xnG7VeQVj1R3cCvwBABLmfKKTg4Ve
	QPJ0jBmrrz20aSz57jNXs1SjXCDiUsxEVk85Qfdc8YsT3jrhzQZtFO9dRIsTM32YXsad19
	hYIG5pb7N2lk52GfazoyU4sadndedi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=U5fF9MUWlYEidvMrUipn+m0KX6+5jNKy7QbVVTr97kU=;
	b=sLgz5D07w0a7GUuQRfbvzQ4NuenfgrsOFgcBB2AhjEw8XDSmYazhQWsMTXfRvIw4cl6r1L
	HgLsZbk29ykf9EnTbJa6HuE7AvHMl6630mVaNsctk6U4uKBxJkMgxKN89bUC3HIdKQ5s/n
	V9uQSD9ZksJqJpK48IPJAKrW/Wm8ms4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=SBFTKvKJ;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 40C39FA264;
	Sat, 14 Nov 2026 10:16:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5fF9MUWlYEidvMrUipn+m0KX6+5jNKy7QbVVTr97kU=;
	b=SBFTKvKJEJ9sAY6KwlNMwsCIF8eAVQxAspWqwA7jcyo6x+MqCtmP83bD9Tmu6xy4I77l05
	LJeZINU8ZN6aNv0lBZodSw1xEgrj0QhOuFl+GV/lRyiy/ynOgrtpztM/lWZNSWaQDM/5eF
	Y7hGYHjucxKVsVBtTnY80Yqxn78bmRSWnRErhSvw80hVa6im+sUd1bzvmpi/vKv+DHPDyY
	nc1UZF5bsKZbkuKTHU+rGadSTZq7SauOboOczUealn+AxPf9XQWzYxdT7Z+JJs0giQ8TkW
	K+014a8fzuCySs9eJZ+B+JtvkcNurOEoYxsuDt0fSa4weHQF8HxaI45Le8GX4w==
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
Subject: [PATCH net-next 13/15] batman-adv: bla: increase hash generation when
 purging entries
Date: Sat, 14 Nov 2026 10:15:54 +0100
Message-ID: <20261114091556.3336038-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FS4NDL7FKWRJKVFBRA7WCENZ4W3UCGXX
X-Message-ID-Hash: FS4NDL7FKWRJKVFBRA7WCENZ4W3UCGXX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FS4NDL7FKWRJKVFBRA7WCENZ4W3UCGXX/>
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

If batadv_bla_claim_dump() or batadv_bla_backbone_dump() is preempted
during a netlink dump and resumes in the middle of a hash bucket while
batadv_bla_del_backbone_claims() or batadv_bla_purge_backbone_gw()
concurrently removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 9be452f667250..ba410dca1c89c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -319,6 +319,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 				continue;
 
 			hlist_del_rcu(&claim->hash_entry);
+			atomic_inc(&hash->generation);
 			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
@@ -1286,6 +1287,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				batadv_bla_del_backbone_claims(backbone_gw);
 
 				hlist_del_rcu(&backbone_gw->hash_entry);
+				atomic_inc(&hash->generation);
 				break;
 			}
 			spin_unlock_bh(list_lock);
-- 
2.47.3

