Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2649FCA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:12:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9959484668
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:12:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108747;
 b=ok1RE6vfsBcaOoXoNmHFPYnCRM6CDtUKDdklFS2TCUDo3EZnDk8qVggJFZ1Kb06w27Ps+
 lFPkAjE92q9eQPEwC1lUWnyy94EKhN+Ses7wkTDajWBNwpzXpv6pk1rzFow/7IVdnvAKe2V
 QGdHAKsezRT5I1jI9BBnd1icYsJ3O+0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108747; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
 b=l0FO9hLRVucHZ2a1XDtpA9ILcRBQMPAvxUXG0k6WS8gNq4x4ApCEBHaR21qRidHsGX5dL
 EXsENwpNzPN91U+i+iFN/kLF14iLhAl2L8moObMp17PaulH/ypDaNIscoau9REmJa1MztfC
 n5AxsgO58EBtniSb3S3YYkVkKg7jlq0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 79DA983E9A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108557;
	b=S3PzzWV7QG0Xzdz14k9b/EY9xcwempVfrARAcmP/UToq+v1/I0I0x3eIYRWaF+WZfN8tM2
	1Ta1v2T7wI915qMfQd2eomGd0AYJQAeGRGZNWylM+6rdsK/hjvk9hFeDcxy/a6jRTESTeM
	++ad9mT9GDEAUw2hlyfsa6ENGuLo2K0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
	b=PNe7QDE8Ofx9V20e22s6MZZXyupauRP4YyzMZFmM0DFNbWSabNwGrAAf+7etAlwE/Loo1I
	OKi/UsMiczkT0WvyrEgdyQRpxUC9MixYT9WuFyBsaJSSHG7qEvYFANVvyhY2GYHTAgoE/R
	rseU6clEKmc5w1YWmqAc8iM2CcyZEeU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xJcjLZLL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1787820558;
	Sun, 04 Oct 2026 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAVnKyJdpcFsMvidBaUe0DvETJX2RzAktU7qX9Er7ks=;
	b=xJcjLZLLOuwE5Dg8Nv1ovJ3FDO3q5zF0QkbAzrU6H+CfIgDchfckKJczPFjymcK7efU6wW
	jk4NUOnfHoS4H/nh4V28Pq08RlJax3z2+F2/qZXccMjWiz6+rhVRM5KlVw4N41ra+nKKWU
	jTR0mhX61Y4SD1Xhr+lfakbtWJoDnfM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:38 +0200
Subject: [PATCH batadv v2 3/9] batman-adv: bla: annotate lasttime with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-3-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=sven@narfation.org;
 h=from:subject:message-id; bh=yVKoxy5R2+cuPDV2BjmrfJJKlWtum/4kTqOgnxqY3dI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLcctj/LtuB5r33n0lJnFl29PRW8L1bK/FCyrrR1y
 Szp/sneUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjISRdGhlP5wrdf6AU/iPe5
 vNHJIdhEnO1R4ubHZdfrL38PirdyXc3wV7yCL3rf2S/tjqLLfi5j9Yn6yNaV4q3wy/Ht+Rdf3nD
 +YwAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YN7JDS3IA7NSA6LWTAKPMRC37SFJGK6O
X-Message-ID-Hash: YN7JDS3IA7NSA6LWTAKPMRC37SFJGK6O
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YN7JDS3IA7NSA6LWTAKPMRC37SFJGK6O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The lasttime field for batadv_bla_backbone_gw tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
lasttime, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..0833f9f9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2363,6 +2363,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	unsigned long lasttime;
 	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
@@ -2385,7 +2386,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
+	lasttime = READ_ONCE(backbone_gw->lasttime);
+	msecs = jiffies_delta_to_msecs(jiffies - lasttime);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {

-- 
2.47.3

