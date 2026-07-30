Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01864C55164
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 17:28:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 52E3983E78
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:28:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785432515;
 b=b9oDQ16CO1cYxPJXW+eVxZ2w+nydjMacEz/gS4FIlfENM/smpzzYPY69ld+adDus1Wb1s
 mFludYjyJRWjOkNH5bWTGeHitVzq56Hu7kKq1r5IyJxwFVcR8YQfdynCygt0TDhaEBOWcic
 CfPtuhoHEoCCgC/JETl8QPejNiOPGzQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785432515; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eR4zybrkaN0hJC9+c9bclzpKm6dXAC0fp/9KVBhow6g=;
 b=ungu5DkuRWex2oso8A5LmNlNQ9bzwhZ5+Eepn6/BHe0wVPNMMtiLmvW1QTFgwXwOjUODt
 cJEPN21SkYeelg68mMtak6TP1FauJr5TYR5NQfy+9NN2Xh2RDTxaOG/VoO2GmLVfV3ciZcn
 moz1UEJ0D5fOpjd3XRJxKj0v0f+d9d8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass header.from=nebusec.ai policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=nebusec.ai policy.dmarc=quarantine
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7784E804EC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 19:23:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785432191;
	b=KCIifVWT5uHTa6u79K3z6ZcAuxbFaAHkLCxmw30fppVOhGYN1WYhGXHx4Y9pAiQwKXyLm8
	eQ4ScDOSEszUcZkUjEtfVphUKhvcVD00kjHb9J3eDCicxO0EGkkZ4shFriZyhtzJHY2AMM
	depkMhq8EJPPg6srMjdM9mCBugAHXUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785432191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eR4zybrkaN0hJC9+c9bclzpKm6dXAC0fp/9KVBhow6g=;
	b=NyfLe699z7qOBNbsMQXj+avdHCdQohoUi/KQKn/Q840gAORDZj1AXPxulYX5W8gVY05cZn
	pinCL/m89smsGZ4/OME3c6EIvCScqf5exqghoRd0aEl9/3ADpPmz73dsZuz+RHd54OT4Xz
	tEgFfKMFyUu2pQ9epjzLVrKZw5T/W98=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=nebusec.ai header.s=google header.b=Y9uAiWX2;
	spf=pass (diktynna.open-mesh.org: domain of zhilinz@nebusec.ai designates
 2607:f8b0:4864:20::52e as permitted sender) smtp.mailfrom=zhilinz@nebusec.ai;
	dmarc=pass (policy=quarantine) header.from=nebusec.ai
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so31597a12.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 30 Jul 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785432189; x=1786036989;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR4zybrkaN0hJC9+c9bclzpKm6dXAC0fp/9KVBhow6g=;
        b=Y9uAiWX2bo9JL8qm/Zg26Ezh7a9yywn3QYE24k4MpPbu5lVM2tcdyT3mMD1LeWjGIo
         XHJnuog/nFuQmGFV1HwxI5Msg5As374wA2CdD1ahaVyZSYfRGPGfQUSTL8NNsxUhIrpl
         uRzxdmiMZMMkFnPGiEQ8GP6OD9sIIk5kD3nLT9vv7+j9HC3gkaUUS8W+4u+o5Vd7Dsga
         j1/l/ZjPH1BCSN1iWg0Q7Ci/6Np0vYwhUXU0mXqrHQaiv+2BtFevrk7+e9/3hkvaee6b
         MISVs/KahPFH1l/HPl2Dc6wRWZFuEkihKOZT3d4SI5pkmQ/R+kp1ZUyWm9NmF6RNtHjE
         4Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432189; x=1786036989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR4zybrkaN0hJC9+c9bclzpKm6dXAC0fp/9KVBhow6g=;
        b=VMSEiR7JwS5jQXbjpmr1C/4ou9DJ+jCEyjfFm8rIIJOXgAiEL8gOxMCoiwJ/eGsjwU
         7kcphkCwQ5lndeyeZxOTs7JCAjfvhhFrxGTgKSDOZArYxz06w3VY046XnqMlyuTrfUjX
         48WX2poKpVTAOmod0x3+cVbPa8A4NwOX9c8X4bSRIcdGMKgfK7Iueh3NyHLFwXQ9tuHf
         VjId1NxmKgk+sWtTJQrmSVBX5EUrQnsyrvBOJmTdxRwi6rSRjx3qpM09hHHgRKqdQbAt
         9seEZjijA5KaKQjmBmJ4ISO+SzryPfOhXwNHTugLVCuGVkaGO564KAruYmKyDI0gesR7
         rULA==
X-Gm-Message-State: AOJu0YzLO1POLwv05iDZy5MQQMwShtblyugwt7nxggo+SDoZPZs2rLGv
	Xo44KmokncGcRTwbtXPwGQ2pvrZdhyYk71+2dRXJLuGiuanE3YdGwsBW6FfUlIAGKwXheoTsbYS
	/0gYHgusqlfw=
X-Gm-Gg: AR+sD126zrJDXE8PUuOE0zg/IX455Tr3lU5/PpKo/QPc0Lw7inSnr3AGAEttGB51oHR
	0yQB3mVR8tNECTZS1WSrd5KSV74GjSHYOoMFxMTSlM/4GmBYNTrIaYu+VxAtFUygFxPFhWdINI9
	Q8pqqVdZrziDiJsVLE0utq90CmPq7lI/xxO2wN1+7TXylaoHKng9XjExmnbIKc/9FYmH0UERcwk
	lvXbkUR8bQLWzt3WgXRouZNSRVhkXKT5QDsoIVU3P+4s3ggdnwL+eyXpkggS5wlWLNzgR9KA/Kt
	usP+bSNbSiBQQuYZLWFIgjiaBsPwuf/FKvMxEDuLbi2zVQfKx8Y/hL7vF+XgimueqFOZYpp2Vqe
	TA48Fa6D3KsKyxlWYbi4hr8XnpY2TCemDqLlVz5sa3gzC0YEyJcq78xON+GewqdQLNEwq1E6A/j
	jUgV9kkRODb9WtjKnXrgClZDKOEX437Q6Gi03Uv5V1kajGpwI9fhHFWD7A/ZxERZOJvba92Yzab
	vqR
X-Received: by 2002:a05:6a20:cf8f:b0:3c4:1708:9cd8 with SMTP id
 adf61e73a8af0-3c9007935cemr3690116637.76.1785432188931;
        Thu, 30 Jul 2026 10:23:08 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba92937csm2453659a12.31.2026.07.30.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:23:07 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	martin@hundeboll.net,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] batman-adv: fix stale receive device on merged
 fragments
Date: Fri, 31 Jul 2026 01:22:48 +0800
Message-ID: 
 <abdace3ea80a8ca052619d612ffc8d0963b57513.1785431207.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785431207.git.zhilinz@nebusec.ai>
References: <cover.1785431207.git.zhilinz@nebusec.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhilinz@nebusec.ai
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: WFPVOZVWRZJCB5KFH5JZO7WGHZAUUJHE
X-Message-ID-Hash: WFPVOZVWRZJCB5KFH5JZO7WGHZAUUJHE
X-Mailman-Approved-At: Thu, 30 Jul 2026 19:27:42 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WFPVOZVWRZJCB5KFH5JZO7WGHZAUUJHE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Fragment reassembly reuses the skb from the highest-numbered buffered
fragment as the merged packet. When that fragment was received on a hard
interface which is deleted before the chain completes, the merged skb can
re-enter the receive path with a stale skb->dev and skb_iif.

batadv_batman_skb_recv() passes such merged packets through the normal
receive handlers again. DAT and bridge loop avoidance both derive the ARP
header length from skb->dev, so they can dereference the freed net_device
before the packet reaches the local mesh interface.

Refresh the receive device metadata from the current receive device before
running the packet handlers. This keeps internally reinjected merged
fragments consistent with the normal receive path after hard interface
teardown.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 67bed3ee7..7918886e6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -450,6 +450,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_put;
 
+	/* Merged fragments re-enter here with reused skb metadata. */
+	skb->dev = dev;
+	skb->skb_iif = dev->ifindex;
+
 	/* packet should hold at least type and version */
 	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
-- 
2.43.0

