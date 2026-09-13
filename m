Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3E7C88E56
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 07:53:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 16CC184402
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 09:53:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789286038;
 b=Nj3/+QwBCztK6N0tQLitNG5k/fi64YJlF2VoCub6Vcjdpq7+7Xzc6VjL92yk5po5QmdoQ
 lpDEved5HqKpy9+LhQNKAQaHChGlEB0bGzgWQjo3BTL5hT2sv1jZJl/IsySyV+5Awb4ADaw
 u6IJgqasWqmJWmnvJSZp6BtVCnfQFPU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789286038; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=31FzDkx84zLx4JWuY3RdG63Yzc3M+o6dxG34K7Ch39E=;
 b=FgHXk3HJ5z88Z64LnXwfzpCQfalUQnn5bEN0j+BZRC1jwhN0YCmwrGFJYnahANmK4s+Ag
 ykeUMJnTGzJ5DB2tJ/HqOYb7kKFQarreLD1Y1c+TU5GhmLUSJOX5bCv+Wk0swcqAWWyJb2Q
 Pu/fzoydQo2ovYr/ckEC5J1gqDbxe2k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C6A13809F5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Sep 2026 05:19:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789269567;
	b=To9HwNifmjVn0+klSC/2NSspq70BvBO89bzLJMrz5K+wUm4qyTT1LdnxrZFqdhGyBuqKXz
	+t0aIq6itOXjtzM2yNeV9dcbZGhuCkubrqm9d0ok+rhOOP05Jmy1/gi9FkWWtVA81Ww2nr
	fEqbTtbFNwZlibRWnohn9uqCR28umr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789269567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=31FzDkx84zLx4JWuY3RdG63Yzc3M+o6dxG34K7Ch39E=;
	b=tRsdSWXgQJxtvOageN22gj6qc6OZVqvPIgqi0mL+19kVyH/CTEjFnbHZ0DuEidQx48ouEo
	WqbFO57yBYvhzHwaC54Kqr5mYdK9/+QESFPfFMD8xNfqgjw/YQspLJqbLp3DnLN/PcpOVL
	UcJb8QzasVYKf7tW0nXXfg9rRwJE5OY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QMDlLcj+;
	spf=pass (diktynna.open-mesh.org: domain of kartikey406@gmail.com designates
 2607:f8b0:4864:3b::10 as permitted sender)
 smtp.mailfrom=kartikey406@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8692a856865so1330348b3a.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 12 Sep 2026 20:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789269556; x=1789874356;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=31FzDkx84zLx4JWuY3RdG63Yzc3M+o6dxG34K7Ch39E=;
        b=QMDlLcj+mZo5JMQ83IsuXB2Q2aavUrJdtx6IPb38PSB0e0IiZPUnan1EcGOEr7Aw3J
         sDGq8DfCvlpEIstbo6z7oIg+GbqfqMN2KkjM5y5a8r42TyaMG3Sx9GDT0p384llJuHBG
         HFYrthnywzpZ9+vbW/qipj8XgRDejQy6F8Du+Gw1z6JZsKwJvdH4jyUUpEFzLCaH6khC
         T/WMtEGHKBqHcZpe3V0r5X3eN/k3/Jbzxy2w9Qx/roxjMMvxSFkKZO8lHbTNZZE4ndfU
         gjE6lNga3shc3lLu8n9Nhu8316VHWcqrQC1sdMy/sKqlsr62ATsIRWfKVLQZS0MrNbIZ
         LHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789269556; x=1789874356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31FzDkx84zLx4JWuY3RdG63Yzc3M+o6dxG34K7Ch39E=;
        b=muqvI8w6pMdN3uEmsBYHaaVLcayVswPkFZBdzEey6WmBefmmGNPxoFWzNMXInzt11L
         5sGvzdTGq4JD4gZiXsQKLIVDeEHDg1cggxWqGyALeLutLtAbXJYE6/8taH+vlkp8wA8J
         +AOtIhBquaFoSJ44xkM/meUJdwb+UsbKwrRsRsSDm547/YxdaVMeOHUIjK7uIUa65tHo
         yO6cjtc1ULFqh+h6JSbE7NXDyAhcx6FdruxuUN4ULX62sWlmzMI/ud1hQltFVxb4pD80
         u/1Vm2rXLXG9v6UoOHqrlgScKsuRJWQxGXYDHICoQVvrQhiSywYkbdHiEFvljit75ktE
         JQlg==
X-Gm-Message-State: AFuF++kNMATKkBCh/HriSJwTiEl8/PqS5Bfj1ZayRWNu5VC+eY02rfZ2
	V/UXg6xgwmXSjyyLhfjLUAGf6HhBHvzOQ5t4ExR0Q9vvC5/8LMau8P+7
X-Gm-Gg: AYBFou1TmT/AHRxkIDmwuPWeLt0ZZzBh9CcOdKTbFsxIw7211su92+7i6zYRKQstmCl
	0i/Eo1pFSaACoy13CMYlyhHynVVWb57UIHI0epwsm49zuWOObEwwU267jUBfkVIZEYWCaDnlm3j
	fhfj4hFN3lPy4rPI2jaOzNd6bquk/Wb9W24/uOPtnfAboJjJ/5Y00FstLdfWHbbjtf+ALTCvI2O
	LkpnFuxCsk07GI3qBHS6koQu6BF0IxXapfYKWop3Zz39uLOOW5eCr7dFVgPWKkFDtLkYluDIEmV
	y2+O4Zpg5jpk/CBabPwo3ITyivCB2HmKkzfTlf142EZCN6ysNBi+QyTGQ6/Nnhht/q9cmdFrMoe
	IwBJA4HR2r/hHgwuu1oUeRByC+4/EnjxdzMWz8cdtKAxcTUolfLScEeE0A2sJG/wUb0TiLpraCs
	KvbSlb3lDA0FUCQF3ma44dE1gw55CQRPyLiCTxPoaT+CASEHjDfeIUE4zaS4CXRlppxM8cnsjMV
	3+GBdIjcrv9DdMCkeyo/r74mSKMXMU0sqgzlOxnOVwX6dg7eekBg/FFJkDYVlWd
X-Received: by 2002:a05:6a00:8016:b0:86c:79f5:281 with SMTP id
 d2e1a72fcca58-86c79f5090emr11028681b3a.13.1789269555532;
        Sat, 12 Sep 2026 20:19:15 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10..
 ([2405:201:682f:383f:c7cf:e002:582a:f076])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm2884171b3a.10.2026.09.12.20.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:19:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+a079f084653164a652d1@syzkaller.appspotmail.com
Subject: [PATCH] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
Date: Sun, 13 Sep 2026 08:49:06 +0530
Message-ID: <20260913031906.14809-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: kartikey406@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: BQCL7NCQEIMUTIYVRNJFVJKX32CFAPV7
X-Message-ID-Hash: BQCL7NCQEIMUTIYVRNJFVJKX32CFAPV7
X-Mailman-Approved-At: Sun, 13 Sep 2026 09:53:19 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQCL7NCQEIMUTIYVRNJFVJKX32CFAPV7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe8f4f..d8a6a0f64ce2 100644
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
2.43.0

