Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAE3C5AD7B
	for <batman@archiver.kernel.org>; Mon, 10 Aug 2026 15:15:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D34383C27
	for <batman@archiver.kernel.org>; Mon, 10 Aug 2026 17:15:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786374919;
 b=aoO6IrYYLXQOmG4hgmHYkFseyx+Bo4i41tYKo2Ls+QRsgMK9X//bIFP7oFNhvVcFkidlU
 DHyMXNo71FliXdazuDFbknQW7g1uNKPpgBjiIZAZA+dLrceUMJkjvQlnuqhdJtydoXUuBhO
 Dg4i7E43VYi+C3uSOnmMCXYlyMXQMs8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786374919; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
 b=WkZ1JX3ezzPpQvxT2p6dzGjqjPOMY0aJVM1aZSzXi4n+srkr2a1OyoQCC8vUg7xOQM1/S
 rra7eThvSWN3wZZU4SjRRcxfpZtS5BlXgiytwLAxQPP4DgwTuCBYZZCIlcVBHJEZErfdLeW
 IqmNBgA0jcs1/uk2CBrLRGa45CH0QhY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass header.from=trailofbits.com policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=trailofbits.com policy.dmarc=reject
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4ADF980DD8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Aug 2026 16:57:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786373878;
	b=zDgjvCwyElhAOZHaqSuMK9LvjgOXX8PGFpw8I0PcUTjtdkwIY47C72UMrSgcoUQ/02+WtI
	N75ynkkMxvJ3AxAjc7Y4ULsEDQtZmlucwlJKn7xt3alzbg/gI7i2j1FB7HndXzqzkpwE5e
	zcvSGtjwZXgXD1VJxDuamLzXmxrxuLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786373878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
	b=i7Xm4rw5shaBrw/29H6LRSxcZuT9KIQArcHupRs/Qex/vbTHOnG2HDBTihZjj84JEkH3r3
	tmtROIpUJUIy7KMR+7AT4BWCOxXTp/5kwVSVHs5V0SM7I1p8ce5hFaaVLfLFpsh274P75p
	dY6GFmwVEePwj1MY+obwSIRS4kSme0U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=trailofbits.com header.s=google header.b="iAY1/aYO";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	spf=pass (diktynna.open-mesh.org: domain of david.lee@trailofbits.com
 designates 2607:f8b0:4864:20::732 as permitted sender)
 smtp.mailfrom=david.lee@trailofbits.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-92edb12cdf2so116666885a.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Aug 2026 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786373876; x=1786978676;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=iAY1/aYOXHAPt74cBEF0qZruV0RRbE/d5fZZZJ2p3ukA+YMPxNGQtkvcq4ukWelvae
         UpVWHiHy/CjBS1zFjGwtLOBTnl4Bcw8QUBTlALhCM3D0w5lrTP7ksMBqU5c7bGR5ycNw
         YMyS4r9ICtE6eAL+fM62FvwYp96/grgISUWyU3cgTofW6aoNtZ3P0yAmAatdPFYb+DSD
         sc8RGU5JG0unm8nuz8AIx+xLC4sLh8muughjOIBAwrRPeFOnXzFtBWY/LGw84Pcr12Ui
         9A7bbT/2SWj4PrfqVYbsacbO41DhxeE2Qx2gYmHDqff8hR4rgiJr00wGUFfWo+4s9qRp
         0ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373876; x=1786978676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=ED2kZgTWVLAEjU16Rsrh0NOvNASo+s8KEC6qO00YV1OAN3XKP5yWKXf7eavU8nhI6p
         J772MojGXRbqj5UKWykv5Jrc/qnrjksfpEx2/GU3kMxN1BTCd2LrrCiv9KcPvMla2oUT
         mt9dPgv1+LJAsnUp4V0f2vKDTBt5mervEs6SJGsJagkGNUV6OH4BHklsi8+XPbpChQff
         QE5QzszV/cDva8p+981jUPvo+ilyglUdEVfzaYTTbJfYYr3o5sq28pHJAKyP88mLM+dn
         9bKvgsfdQtRZnM4x7CDdMOFqkcACcbTEu3GZS9BJPidH3Z8jGfCKRUThKD2YJRjvpGt2
         dIPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6p/ImD44WAMsxI0OzxUaQQ3oN60MRkHbYUm5E0z1sM8S7RGlCLYi8FTLKoTAvYKzhYZyauAE2zhoogw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz63SiX8eImCiDW2FrMToiof6bbLHP5Y8tqCi9IdqHG6hOgkyin
	F5MdaDZ2IJdXqVIDMPlMKHiKIclSmFIH9eQae6G53jnqtbOvDU4SsHs/hZAYer1zAQo=
X-Gm-Gg: AR+sD105ZusPK6t1yWsz/OHl3otv1j3J3vhKSzoxLeANSQhSKto8CWEg9rfTRKWEN5Y
	O/1rPurfAj1wDG4vL8EeRbo1e6uxbeOChO5n0JMtoQlwmNG6GgwstAS43iWqzk2m39IxYXWetwm
	+qFUApsMKukiq5GFtRBS6nc2N8/aLnY1hhbrBoAjIqSrrcz+za1Y33el0Mmo825hhDWJtyp5mxA
	WvOHMR7wWQiZKWtexGjLAgMmfa8mOXSfjLPdiRqKB4in4UmdS4CFGHZky+MteNfjVf4C6p6HWzX
	ga4cDMtPw6uKX2MYckW5ykTp1i8Ioth/0+aIlX6TNMkS8K3fVzM5FTSrMWj0qtqD60aUepgWRET
	ypGQmaR4bQAtGpU3Fqta6IXWCRCW1TC8pD3s7DTZPDbqBt1VjrimbJB7MJ6E8jjZjqxTZQwby6E
	sXE/DBX9JWZ2NI1J1SuFzytrQvPJoL4KrWQaTWvr0KScEAocJZnlp+BQF4vvMv1dz7qg==
X-Received: by 2002:a05:620a:40ca:b0:936:4955:e5ef with SMTP id
 af79cd13be357-93671eae246mr2247821285a.22.1786373876052;
        Mon, 10 Aug 2026 07:57:56 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-9366e2294a0sm809249685a.27.2026.08.10.07.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:57:55 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] batman-adv: reject unrepresentable multicast TVLV
 offsets
Date: Mon, 10 Aug 2026 14:57:51 +0000
Message-ID: <20260810145754.828936-1-david.lee@trailofbits.com>
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
Message-ID-Hash: RTMEPLG3LDJ6EZWJKWYQY5RI56XTJM4E
X-Message-ID-Hash: RTMEPLG3LDJ6EZWJKWYQY5RI56XTJM4E
X-Mailman-Approved-At: Mon, 10 Aug 2026 17:14:58 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RTMEPLG3LDJ6EZWJKWYQY5RI56XTJM4E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Kyle Zeng <kylebot@openai.com>

The network and transport header fields in struct sk_buff are 16-bit
offsets from skb->head, and U16_MAX is reserved as the unset transport
header value. batadv_tvlv_call_handler() sets both fields from a received
multicast TVLV without checking whether the TVLV end is representable.

If the end offset exceeds the field's range, skb_set_transport_header()
truncates it so that the transport header precedes the network header.
The negative difference is then returned by skb_network_header_len() as
a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
multicast tracker and accesses memory beyond the skb data.

Add skb_set_transport_header_careful(), an offset-aware counterpart to
skb_reset_transport_header_careful(), which validates the final
head-relative offset before assigning it. Use the new helper in
batadv_tvlv_call_handler() and reject unrepresentable TVLVs before
setting the network header.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Cc: stable@vger.kernel.org
Suggested-by: Sven Eckelmann <sven@narfation.org>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add an offset-aware careful transport-header setter and make batman-adv
  handle its failure, as suggested by Sven Eckelmann.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731135222.566367-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/linux/skbuff.h | 26 ++++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..dbeceaf5c3b3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,32 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+/**
+ * skb_set_transport_header_careful - conditionally set transport header
+ * @skb: buffer to alter
+ * @offset: offset to add to skb->data
+ *
+ * Hardened version of skb_set_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	long transport_offset = skb->data - skb->head + offset;
+
+	if (unlikely(transport_offset !=
+		     (typeof(skb->transport_header))transport_offset))
+		return false;
+
+	if (unlikely(transport_offset ==
+		     (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = transport_offset;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6..c384db16bcac 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,8 +433,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (!skb_set_transport_header_careful(skb,
+						      tvlv_offset + tvlv_value_len))
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
-		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
 		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
-- 
2.53.0
