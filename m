Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02475606A31B
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DUS83EQp
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 634CF849AC
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 09:54:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793004880;
 b=ETXQnmvdAlSDUKcExmq5Rac5nwt3Qdr3E/82DAPnJbwKkDdLeEQhz/ZlOxSid2yTbw+Gf
 H+nhG9BwXMRLXztTGDzx8QKU4Ul3vQrrD3YulLDS4klw+S4sT/HnkNwYT6yvf1f9D1AhaXf
 2TVelEbQdSRPdZ62eudQpzGWz0TbNEA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793004880; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
 b=mdqAX7Vd06fFjtWv5nLOhm4eNLAu6Rn1AcH9L1tYj5lQR2KQO0TEtTbcz0ybrU3o7c7z5
 HLl3l9T0lZmiO2WurMg1ZOsgjxTpODhp4w/8KEo56FCAYulf1pGSBapkIE+eQNZG7xblO8o
 vgNN6mOpk9SD/wFdbm7REpXVtA9dNtY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9E29883EC8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 26 Oct 2026 09:53:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793004803;
	b=KKlcoQbHI66eK0p8NyQkL6Wdn1LXZPdpvwUCfDGbp6ge8JexGBWs8KX5T9HLsTUY4sToPL
	Xfw4MlaiCAObp2qV6qF3OhncqDoWePaRWgzeKs+a1a3OOEDqjKTCEmr2cI+ILpqfg2n3NZ
	DM8nsR2jMRL3V+JzPjbcjiWs+ZS0eic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793004803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=zmL2ravwOgOojGnb1O9FLYmRLY87SJXgWFKC6rH29olgtGuQsxcYXbDNF75PtPqgQo3TQW
	Hco75uccxj7nxdEe2eeLixHqfeyfNJIWw3MCj4oen8OzVRM5pXJx3WcnYJpJNbsNfC+brA
	QgM82CdXaA06nysKRjWjIaGu0MrHffo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=DUS83EQp;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5973ce5d80Fc8DfE94A24022D.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 60C96FA010;
	Mon, 26 Oct 2026 09:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=DUS83EQpn3JUfEDeMQFkHHPjnfm6S6qogcn05D220PmqBZ7CcqP8a3/jGWfQGB5cXejj6b
	Ut/M0ORE91NFAi+0L6PVWLi1AHXSIb66wAE7qTfi1UNfIXsSmFbOGEf+JcklEACBt8WpbT
	GpVKr6p5k2W7BHH0dYX/R8ASiqoxw+vrU3wRy9ZwQqZrlggvdBfUkOF7NS55/dBZxXWP2R
	ESiQRfb/TPPU3rruFkwxeI3D3b3tEVGuxEaxadX096AFAqQwTUKVAZQO/bHcpCRfSpzUlM
	/ktLMOAgtdBSAVoWMryX+EsIfAyC7IlDfJ1HvVVm2cnerWhldkc24qdwJJ9e2w==
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
Subject: [PATCH net 01/10] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Mon, 26 Oct 2026 09:53:00 +0100
Message-ID: <20261026085309.1074911-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7I2SZIQVP7RJKYKEP6HI4SZCS4C6HXTW
X-Message-ID-Hash: 7I2SZIQVP7RJKYKEP6HI4SZCS4C6HXTW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7I2SZIQVP7RJKYKEP6HI4SZCS4C6HXTW/>
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

