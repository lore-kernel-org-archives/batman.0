Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D24CD6E69
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:27:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 73C03853C4
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:27:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780471668;
 b=E9SYzI2qFVf6L18G2oeXHhbHeRlFCMYbHOQfj7L8FW7VhJRZqSFEvT79R1FgW26NXfBBr
 A+2PzQjyAzhz3/DXmryjeV02+4dRZUa7sGvA18AdIFHiTqoB3gtlWz7ljChMpC8gHsKfecR
 wG6awA87DT66sAsh7z/Ku3iOXx4v2yQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780471668; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=crkPToTT2/tyCNKB7IkrniNyb4nRyBInopT4AELZDmI=;
 b=M8WpjA/VbJg6ecWsNQZx6zFNNavKpDpzuZpA/YPG1YYlbxuk+yaRw846xo2u98fcSYfsy
 eEMOgfNSYVzX73b8hPokFPcBeFbIFxuDFXdU+2Mo1NxTs0dSsCtlvFUieSyt7g4QtA+bmAm
 nRRT5bfNUJwFEGVtti59NB4GpHlH7JM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6C145842AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471532;
	b=s1MgR/2KZJYBTl5Lif4sRtaZubX36waIhXW6Chremu/EjRn055gqK4rSkChqwa6sq6R+Fi
	nBQoTNTVhx53rVa+nJZV4PdZ3146I4RuG3GzalHZwwM66c8ytln/gzSsoq+ZiYGh3Rzfi3
	/OtHbuNHGCLz0BTD1YRnyP3M009QN90=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="wH69Iv/E";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=crkPToTT2/tyCNKB7IkrniNyb4nRyBInopT4AELZDmI=;
	b=Ru4wHn35D0P8c3wxVgC9AbU33B59Y+nCNZV5l2a2GfxBXDRC7QrbHnzvc2TylA+UyO3jlZ
	MARO0hKstmz1qYcSYIkFtDFZwrSArauVUmZo4FtOewTvZ3DgYx70YHqE1vPaSTSn3XdBZD
	NWGkMFOHpmPdrd4WaxVyLz+Um1huMeE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crkPToTT2/tyCNKB7IkrniNyb4nRyBInopT4AELZDmI=;
	b=wH69Iv/EF4PG8KZJn9vTQQ4AlLS+6ZRquw1W5QFr5kGQm6YNK3WJf2PM7MJZNB7va7CQec
	V82fhB0dz8YmBaZKa3MFT4C8wEgFILwNbGEF7bCul1IN1tvB9MY/Jz3j70VQp0kxzmrZg/
	OfVLISP2GFZL4ZVt1yPEMTYZo017svVdFkh9lPtUNNLjrncdD1OtSyVx4JGSMic/yuSY6c
	wyU3UsjvFEB6z+Ba/xXOseRvpEkTMNr2ITHKzAUlzZSl0tT3Sk18A5vkRRLmaNJRNFwYtj
	69S8e9CW7YhmjdsiD1b84BgxVGvQPTyKgP2tZe6zlKn3I+NWsN4dw6tHToj4Cw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: tp_meter: initialize dup_acks
 explicitly
Date: Wed,  3 Jun 2026 09:25:13 +0200
Message-ID: <20260603072527.174487-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4EIIYEKZ4RRI6BZVG4STX4RL6ZIQ4EZQ
X-Message-ID-Hash: 4EIIYEKZ4RRI6BZVG4STX4RL6ZIQ4EZQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4EIIYEKZ4RRI6BZVG4STX4RL6ZIQ4EZQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0e39ea33e5f27..8d7308327a9bf 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
-- 
2.47.3

