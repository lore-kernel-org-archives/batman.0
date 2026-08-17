Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5A4C5DF70
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 08:51:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 581938275C
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 10:51:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786956666;
 b=pvsEvWEUBSJ38bvw45+YflGFFGMBtaO6yEhoVodnDLXzNrubC/nZAGBQydCw5AwlJ6tqT
 ZXSiaC65mIxp0m1Kac2E2eu0IHEC022g6snagfpt16rwkzN2IZcJ5IquE5h71FZbe2uBrur
 Gn7l3IfFhTVkH7/hWz+3QswvP3VUxVA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786956666; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
 b=V57AeLZ5bng0Ik93SFV/vsYEAUi6NHh4YtYKDaPmDF8atHCyjPY86OfAWp2kZUFVri4lC
 B/WZbn0Ook3W7k8SrzCcxaflMX8zDhBhuiiC6mKeh2xqL/pg5fYbbgoNIlZyn/3tsEW063o
 Ecxq/R3SSBe/ysg3EsNaAUMIzY3j9p0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass header.from=trailofbits.com policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=trailofbits.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=trailofbits.com policy.dmarc=reject
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 50BDA80498
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Aug 2026 10:49:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786956600;
	b=Q6BZP2aGeJhkhy4YEjN58TXuXcYsORvSWLL89rHLeNXB6sitrkn/J+SAXo3aID6zwKPSTd
	nTsjzOPNZwKgD61/gKkPmgWcjAFF5Lbl4CXScR4nDyp0WBoWL281JEAhQ2n5cZQrSxC4FJ
	6XdLtzJdQdUmz92+nLEtTS+PabYHUEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786956600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
	b=tJwJtwrvvDNnIb2NrBtLxsTbZbMks3LN6KyUo6gTt4ioLugUgHzSgJX2Zwm/m/vgJaGzwQ
	phfYTmM1KqtfJZiRWzMUnd+k4/jfEVDIOHsF/Q1fI6/QJKUFzJZH52RaeObg9lLnNz9k/M
	SIbU06LWIGFuY6SRR+BSG5LPc5P5yn8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=trailofbits.com header.s=google header.b="kIuCY/HO";
	spf=pass (diktynna.open-mesh.org: domain of david.lee@trailofbits.com
 designates 2607:f8b0:4864:20::831 as permitted sender)
 smtp.mailfrom=david.lee@trailofbits.com;
	dmarc=pass (policy=reject) header.from=trailofbits.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-51c0006ea8eso22269141cf.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 17 Aug 2026 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786956597; x=1787561397;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=kIuCY/HOREcW6FjWdkGUVaXzs8tyb3NRvZ0RQUxnNwJNUCepFQ4Qavw0Z9l6xATRao
         f8EJLNgEXRO5wLgc4D14zurgwjMyNqpFzNaN4MCRtpill0kG2oiVG1ABIEyNxQP71vn8
         LOjWGCVJ+QSZ/bJSZbzAVt9T5WG1uA+qS4Sz5GOrUtn/52MFhNg94H/004+kk9GxG17f
         Fy5BodJmvzwBrzy2Vipxf9Tt9B3eq5TlH7YQcyFuVtOx64Xy92XLm8vMOrWVww9nzqvy
         C7ZjdXQWRazNkWcmBkM99y2MrtumNMEMUM2T+RmWgzVkcWzyq7HdPyz0Dy2mzY0zzA80
         /n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786956597; x=1787561397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=VFua/P3hGSzi52ViciYzB1ALpTXBoU48T0tcTzQITpWj5OVF4KNxeF8t8B5OD+JTQH
         RCaqHoDZXUhRxVVzaetyY2B5O1SlKuQ9FSgNXmtLjQGpxdbt8V8B0Qlx5Dkp24B9esi4
         AYEsj2gbo8tKPGiRitRx5nCZaJBKBbqbggSxSG3X7y/TMEIea+jWmjGeSZYY4knVMYyA
         /71ICUM4NZfHe0yt1gWudd0e9mFKsKLYs1fvmnnHoZa+gnq5JH9bmfxDAki/8NUTJHsY
         kAmrlwy+U+Z3DBOt0JU/3w0q+9DOyM3cXbQKtPqtk8dKl5BYgaFjP3kOTozj9IOZoNDU
         JmBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh60YaEtEexM5bgBZvpvBI5o1+1hnWf8RKC+Q9JAW8PgY0/3A1q/Unguzb0nnX4LBENGN1IztPH6yYmw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyLh+/HWJjBJzISxSb1IWhIqgGKPU25rAbSPPbHUluACPr/h/Of
	69J7c00dJMt9w0t/k5Yr6Xu2QUfIhRU/XJELZrl1RDc+drpTbKxsYFeGlRNymOvhJ6M=
X-Gm-Gg: AR+sD12KwPhpF05BVk/dpzg1rufmBCn6UgqOqKmS7TzgFumPi/NitTSS05tE7zy+vaK
	tAl70aMM2JlFdSSsvxLR2puX/fuk9VDKaV6qoOI0UAfuWPAobNkWbjKaFhSFTFuVzKU1sKyS0kl
	01+n5cKtwFYDVrA1rxjp7601pE8Juyks9BBgBKrhjD+yrfDfrKUeUYlYl7siHW0/7tegevfL1bi
	0qddZI9tRTwUs97ufeK+XnrY6QFnzqbFS4N0W1D1n76v9Dg6n+l3nZnEDtZGB6gD0yaMXV51HOf
	Xibs+XgltSFEbaxEyAnO9PKnwIdh8+uHnxEcpo7+Wu6YiZXxayeTYC9HtNGzZnQffE2dM2pPTw+
	5gYFcej8n7wGYKgKlXB+KMX4LL9HDbkayFT9IAg/sUdmscw+Umvvzad2DtwHjlEY0AjB6al+rwP
	ycWsKI2OVZ6rUshgb5xVCUa43Vo6NdYPDdj0odJB9pewQpXfzr+rii4stPluKhqIM32mM=
X-Received: by 2002:a05:622a:3d4:b0:51b:fb82:67d1 with SMTP id
 d75a77b69052e-52d8542c8e8mr204942221cf.20.1786956597000;
        Mon, 17 Aug 2026 01:49:57 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-52db60eb85csm9405991cf.4.2026.08.17.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:49:56 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
	linus.luessing@c0d3.blue,
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
Subject: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV
 offsets
Date: Mon, 17 Aug 2026 08:49:54 +0000
Message-ID: <20260817084955.944189-1-david.lee@trailofbits.com>
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
Message-ID-Hash: BBZUM5M6DTNCBPGEJTC7V3VDPOVGB2LT
X-Message-ID-Hash: BBZUM5M6DTNCBPGEJTC7V3VDPOVGB2LT
X-Mailman-Approved-At: Mon, 17 Aug 2026 10:50:58 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BBZUM5M6DTNCBPGEJTC7V3VDPOVGB2LT/>
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
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v3:
- Rename transport_offset to thoff so the comparisons fit on one line.

v2: https://lore.kernel.org/netdev/20260810145754.828936-1-david.lee@trailofbits.com/

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

 include/linux/skbuff.h | 24 ++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..ed6a2bc23db5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,30 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
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
+	long thoff = skb->data - skb->head + offset;
+
+	if (unlikely(thoff != (typeof(skb->transport_header))thoff))
+		return false;
+
+	if (unlikely(thoff == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = thoff;
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
