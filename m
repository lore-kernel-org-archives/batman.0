Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2ECC5516D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:55:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DD4084016
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 15:55:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785506131;
 b=rpYWYf+N0V8M5lPAyVVmdbYZa2CNUMuX2GYQFPmrbaFgRHKhHi0IF/6/UG6gDLNYLIOsl
 nDl9GXqcRqDT7k7VyusomxfzQVt0SK+T+HDQk8iD5R44WWNCoUJcNGqyJM5gAZDu9LaJSrg
 HhTfQvYtuMlG6y7bbZGg/q9vhX9WFhw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785506131; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TEXe4kmCb7pLmHb4F7zY2/M7kyesau+t7W0UeieXcXE=;
 b=z1zvde3BrkeJY+6QNlcb/Mo418YOu3Krdoahblb1d9ICqHbGDnEHuKMjyYUtDImIcK2RY
 Mo+4plr4LPzekJ4GhRVmgDAZnctctBCYxPpgct8+f4EKPDXQGshrQsCiGxxOvTk/MgRvswl
 WKatp6cTgl+AO+IzVXAQWHSAz3oAh+4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass header.from=trailofbits.com policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=trailofbits.com policy.dmarc=reject
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6453180C7B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 15:52:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785505956;
	b=Dni+1Dg1UnciTWVSgJZcZofFZh7NYWwnogzRiFOGz1soTICqgK2D0m74O9DKB0XI3CwhRC
	fCUqT3gI3NX13+fBOlQzjmuVARr5DniVZ5hqpwNAndTFbCkUO4zfZl0f7ekae0xqaw8jFm
	TUNfnC7rLC+LVDBIQ6oKsSKKpZBy20w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785505956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TEXe4kmCb7pLmHb4F7zY2/M7kyesau+t7W0UeieXcXE=;
	b=BZSLwYfBN+TsC/xmCq0BbwkRXvSSmc7Rt4iOcw8zku0JNZkWwMVFumHfWpU9lCprpb8us3
	g+WBNXWfPjPDisGwEGkqI13KNfqFODJchIRrHcEGEQzd8JyisGW8qlh8EQC5TSQ/uAQ9wi
	XR0Zg4LwLSwzmi2JcAeqrdz0JtOWZq0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=trailofbits.com header.s=google header.b=ZnU1TklX;
	spf=pass (diktynna.open-mesh.org: domain of david.lee@trailofbits.com
 designates 2607:f8b0:4864:20::72c as permitted sender)
 smtp.mailfrom=david.lee@trailofbits.com;
	dmarc=pass (policy=reject) header.from=trailofbits.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-93108a3c326so119177585a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 31 Jul 2026 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785505944; x=1786110744;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEXe4kmCb7pLmHb4F7zY2/M7kyesau+t7W0UeieXcXE=;
        b=ZnU1TklXK2h22ND15w6QmgWl3wI3xTZKl+F4DTG8L9MgFoXgAXK1qgxP1Ys0w3SR79
         w07z1CO8xgvCuQHSLda60QNTV+/65GwGxJlS7ibetKe9olSDUvGaOJU1/HolzMFnQ1NG
         VYHHzEYHkQJcVqc95LxswlVXIoumxkY9IKHUWmLfJ86jf4t8hBPBc85QuzOuUDO+Qyyt
         3fHbNcSdghjjYZogP7rZMpA5G/dfy7SxsCntfaflJa2RTUslXxRob9U/sK3gbLS1hm8v
         j2YWzBuEOslK3f4lS5Bmxw0decYK3N9VeEl4OeQ1Ts4A/5Dp1cPTQT8/KHhg99McmE2l
         qrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505944; x=1786110744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEXe4kmCb7pLmHb4F7zY2/M7kyesau+t7W0UeieXcXE=;
        b=YgA6nQxBVE8rXQFzE13Adz4FYOfbWC/yTj4q4CG4GrfNawQq7t+LjwUE5ihjPn1oRX
         uox7fxki30j6+3escZjY5xvcCyVWRPOukUrD9aYbitHcxs9XoKdJMsl2jIexniRd+CME
         iltooRZWQZ7tCVmFjGnrZMYYWogV0n22lDxbd0CE+4GUkATSx09IoTqc9pAFHXWgLxhA
         OgfBJkICz7GMTpVlCXBVs/5jsm8BjiajZ70Byoj7HaUZvFTVes85SVtYJcaKj8Bxafur
         X47J7I3/4OHj/BTFdQeOC7armn6/Pqpq5e+yjeT3bd+x/x9qbmG9vdyzhkb0euWMPTs6
         d6ew==
X-Forwarded-Encrypted: i=1;
 AHgh+RruUvst7IWf4jajWKtuGFeSG3PN8+d30Zpe9H7uhc9QTpDtgwnQLzWzz0yGveJRtGWB7HSK7thRlZbqqQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyBde++JAZHb/+qGqHEszREr+M/5/aR/d6xFkS9SPlUgF2X10VL
	tkcVazXHyeyTCF6iVOKC14RirxuKIT3LeYHqSHqtgNB98/1IJ4Aw3P/EZ7dg0WWiTGA=
X-Gm-Gg: AR+sD13Zl2qaTh5tsTjzvT4r5PJU2bEKABrpQjfZITmCYTqj4cP5AQbMC2+kYCJPQcJ
	EdEcg2JPCEA9F5itws9FCW50urYwp2KeuYOW7Y9bLQPpN3XODWDD+ZpeiNSudcSWjcSbjBmag5h
	f/4tyJS0WlBJdqTQldpjaA13NpQjGAw088Twx8SOj20NTxMHU4UMCMxNxj9kiKHiA5aOyyoNKRl
	Q69HwIc1nqoVIQtVrW7Osw2xhPZvPRYNckpjGtC6iN9ybx74EYWRcDfAvh8bPf8m7ZWGI96dipA
	vK7gBbYAkTMevB8jo19vDpAmLXlmWw+b0fGRVbK3GDIkIkmUiA6tc/8JXBKgeq/3TxfH6priroL
	39tpW3d02kb3nG2XfMEFBLC7h2JXd9nqOwGBAgP6ARY/PilfvSidSnZEAclaosreYZlXG0Ptutw
	8lMs9LgrlFUqfIIqi2c/ec/rRZm7wZJKX8P0OVRN8ebaLgih2i9gPCSrLx2ulYwWSttg==
X-Received: by 2002:a05:620a:a109:b0:92e:eed7:91a9 with SMTP id
 af79cd13be357-93497b92eb8mr219009685a.7.1785505943898;
        Fri, 31 Jul 2026 06:52:23 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-9349c199c2asm58681685a.28.2026.07.31.06.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:52:23 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Fri, 31 Jul 2026 13:52:22 +0000
Message-ID: <20260731135222.566367-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: david.lee@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: TPWFIAZ5MHYPJOWC25B6B4TQA3MMJW3B
X-Message-ID-Hash: TPWFIAZ5MHYPJOWC25B6B4TQA3MMJW3B
X-Mailman-Approved-At: Fri, 31 Jul 2026 15:55:12 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TPWFIAZ5MHYPJOWC25B6B4TQA3MMJW3B/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The network and transport header fields in struct sk_buff are 16-bit
offsets from skb->head, and U16_MAX is reserved as the unset transport
header value. batadv_tvlv_call_handler() sets both fields without checking
that the end of a received multicast TVLV is representable.

A sufficiently large TVLV therefore wraps the transport header offset.
skb_network_header_len() then returns a bogus large length, allowing
batadv_mcast_forw_packet() to access memory beyond the skb data.

Reject multicast TVLVs whose absolute end offset cannot be represented
before changing either header field.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/batman-adv/tvlv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb2198..5e9d0e2dd 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,6 +433,9 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (skb_headroom(skb) + tvlv_offset + tvlv_value_len >= U16_MAX)
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
 		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
-- 
2.53.0
