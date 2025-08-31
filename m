Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C1DCA0FF2
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 14:58:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DF11483EA0
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 16:58:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756652283;
 b=xHDRnJrX0oZ6Iw07aA0HtvGTnRDVjatyOL/4uv16tOuGZWd1Isrj5xAf5rpPd2D1Z9Neo
 JSTbknoEkuIx67SGqTHcEJF7VKwuwbs01A+cdGFlXu2cJzA7l35wMYspPgHq+q2oXnNd3Ls
 IE10ILsTIc5FqyxDCwPV+YlbCkwPKwQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756652283; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
 b=UEbx7DUU93xjPnNYKMvMr2dDEcsKSnayWOWWOw+tW+YtBSTKYvw9PoQAmQtzaLelWhaU1
 JkTxVnDk6U8RAi1uYAIOAgF1kx4voUUT1F+Nh7tsuzZkqd0vQ9oPhLIyr+EH2PeiJoL1gSE
 wtCSjOEfYtVcZRgh35uUNcpj3EJ5wGU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=aisle.com;
 arc=pass;
 dmarc=pass header.from=aisle.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=aisle.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=aisle.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 74C4B8195D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 Aug 2025 16:56:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756652197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
	b=rqB+Ul78p7UoAqDyCh4oi29+IcGTX5ZWcMdsqSkkEj42Wb1Fhy/t0Ien7QNeirnYnAYN4K
	tAjwLoJaBwUCczkuI2505h8oNjRxfNF0P+0CEE0m1m+aP7VQZobPC6+/pZUGdpj0IIT1tS
	nL2j4+h4k2jb3JxpEMBhTV3Xniw7v/U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=aisle.com header.s=google header.b="p31DX/nN";
	dmarc=pass (policy=quarantine) header.from=aisle.com;
	spf=pass (diktynna.open-mesh.org: domain of stanislav.fort@aisle.com
 designates 2a00:1450:4864:20::32c as permitted sender)
 smtp.mailfrom=stanislav.fort@aisle.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756652197; a=rsa-sha256;
	cv=none;
	b=pSgSxxbRtY6iOGqZucTIOkfD+aLyDNu+b3iFYotYgDZAmiSCs4fNIeV+9ti+PbYGV+8TZZ
	YbgOlIry0WRASHl8SldxFrTrItl7vD968dIhwkY+7dfkknagAjdvNaxW+p6THX+E8KVrtw
	c3OV6IuN4mpw6bwg82ECX3HU2z2y9G4=
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso15260275e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 31 Aug 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756652185; x=1757256985;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=p31DX/nNaV+JUExZY4Mwx3PAWqesNXllkA8PCtUMp1znJWGfG6JVEky92YTzQKYxQ1
         jw6J6jU8s1yz2S92hWx5WiOcLn4r31Ob1p7AWLhWUDxJ1QHUJak60SSAajwIa4ocWZrS
         YbwZtNN0g815HGeR9D0qtVD3VyVfeQlxXTPoVbiZ9v0yPGawDsByzKv/jp1HMw4Q8P9C
         RxIToBvpgYhAI/VrI7ZDVNhvCWagJanzrhYQbLCruPsNAlwiqd4mIvGRVDrjkWi4aD1J
         RjHRuUscUkUPlWstRY4vyp8ZCB/QxDZ6wEeDUS0PmnmquYXLl1ZpW+34NbUGTNUWipWW
         LSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756652185; x=1757256985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=qF+AN4Pp1m06YLGU+pxHdvi/4P2tHp1rsGCmNtgDKHi81jy1k2HE/21qyLZTZDa2m0
         Y9HhpukfMyjN0QXP0BszoFH/bIESgYGx4lATsZ2opLQHXnfp8cFndxngCiYRPC3udIim
         X374EHIxKDtZeYVesoyJrlvFcRDwaQL94BUtReeML3aIEqL8fluxwPsqLIWEIJvCvUme
         315PXMjwc2nYIjPnRAbdKKhdp3mllEDUQH49NJ+WClJVnco56Xdqr/ThDfxIyNut8PLs
         anyPU0SV7KaY2R4NB8hUZQ1JLn7lJKxZyvDa8n4qagq72fwwYIhMVtqKBKBp1pgOlMlg
         /Wtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEdHPKx52GLhawMaj6BhtJSJNWLFY4Ipb41nR8gCe6hzS2cRAoS6MRyEY0hGxtPEHf7dDmrrPxrcuARA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxEe1gvv7zYs9zGFJf5SKlDIzlsEtemvyh7e6NaLkO0JFHna/6L
	PBoqtmRodbwJWhLddZ0oWTDJ7HBpKZrOcfS6oBccBI8/sULDbQb6HQAdBZ6lFfUz4jo=
X-Gm-Gg: ASbGncsi5tn+vx/y51/BvdU4QXtePAXSnQl2mqZvD3Jm2p+spDQZcV/FYxS68L9A5w8
	s3IyRrd6/S0TNr2DN9R5oEaU/vy5Qm4fXzwcafIYeAshJTKzT0dR0aLXM8haPjyFTQ48g4rcQo6
	qtzQe6x/Tzub1yIl2jpW8POoBhdjVctIw+Oo2Kb0tCAl59+1z4TXmK+T323BLemOTKoyVa6F3ba
	dLLZlUXiE/+exx8cf2bLYFT/oEfJi1KJ93I4gWMYQAiIj87xqenJ8S8OkNfHV/JrUu9oVodgRsp
	guAZeFEuEX/xO79tDhHEqYkW0VWfnNhAZLJ+5YSS4EqLmKhwM6fwqvicSAZsRDBkLUw6sQJYbaJ
	vUZWD5UM1aLQsojUa/ttTRJKca95w1pcQhD+T12fSvrbtxxcYFf/LjSg28jNTwd+D6jVywlLWuj
	WjeSyqzaaGZ1rd1HvGZw==
X-Google-Smtp-Source: 
 AGHT+IFECZm94cv0ABA94deFhM69SwEYykQaQ3t0S0Jj1eMYv2dW7N7j1CEH45wVfmQ9gpzQYScDYQ==
X-Received: by 2002:a05:600c:4715:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45b8558ad00mr38526875e9.35.1756652185412;
        Sun, 31 Aug 2025 07:56:25 -0700 (PDT)
Received: from localhost ([193.138.7.149])
        by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3cf33fbb3ccsm11425183f8f.51.2025.08.31.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:56:24 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v2] batman-adv: fix OOB read/write in network-coding
 decode
Date: Sun, 31 Aug 2025 16:56:23 +0200
Message-Id: <20250831145623.63778-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: stanislav.fort@aisle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: 5SYKXOKX6XYJOCMI7CK7MXPIUWAXBKWL
X-Message-ID-Hash: 5SYKXOKX6XYJOCMI7CK7MXPIUWAXBKWL
X-Mailman-Approved-At: Sun, 31 Aug 2025 16:57:45 +0200
CC: Marek Lindner <marek.lindner@mailbox.org>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 "moderated list:BATMAN ADVANCED" <b.a.t.m.a.n@lists.open-mesh.org>,
 open list <linux-kernel@vger.kernel.org>, disclosure@aisle.com,
 stable@vger.kernel.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5SYKXOKX6XYJOCMI7CK7MXPIUWAXBKWL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc..af97d077369f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
-- 
2.39.3 (Apple Git-146)

