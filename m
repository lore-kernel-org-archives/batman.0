Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C41CD4F25
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 16:39:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 62E2785BBB
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 18:39:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778776792;
 b=tegvvJHqTzcTwVOaunLxgIM8nKVKJjRo1FDFPTdzgc9wuYHrikqyOIxiiwJGMp8Y8tPCt
 3t1DhncYILnVFUkobLoUoP3PVGaeyfSruK2DVO9QcaUaEIIX1NKjSLwypng74tEVQIYOQY5
 LRpU7IbPIRtLo02m+ENEb4tP1465Yaw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778776792; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4pdG/tVsoMvlsgtwb0/xDU7sQiC2Pmpw+evsxsdmAiM=;
 b=h15W5x3Z9KC/sChK47oUC1GFlc1kUG2T1Puzdkpw1Jkni9wKxzre4enXiL2jSxeQgGuQ0
 ELEJ8K4Lnj8k/CpTrdb8AHdPcHkDQEbcVsmrl5nbjLwFBq5TKx57ZA/7mCcXqO7WH5bwWIJ
 HdU5pTQw8tV0T7YTBSAAJWgFOTv/ssE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CDACE80FE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 18:39:17 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778776767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4pdG/tVsoMvlsgtwb0/xDU7sQiC2Pmpw+evsxsdmAiM=;
	b=fI4KeOdm31C6QaHr+edAZ5bCQXgQCAFbwi62KldeTPaPjCJGU/XsYJWt0jhbiaAbG1ma27
	o2b8DXClgp/tLN09K+fFa2nSDglX9KVgoupsfOH3CeOcDP2zNCrMvbB+S5kYj8fBnvaTpA
	Gth5PL1rvkS17lq+QoVQ3TCwIZK5gH4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xz3VxA12;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778776767;
	b=s5Uy8/h319NbPbt9CLcYgtPrzOcAKYjrTj+WbkIVZIYn7WVq4zj4GyIK9j0TUEX/GBjW3f
	dSt8gEA2TrEA67LS65wE53R9C7prKjCQVEnAGTv/NWdt8pwaJg21/kiCGRX5YN8F1GQUV+
	8o1VmZZs/4TXeF6eluZiwaOK+YZQClY=
Received: by dvalin.narfation.org (Postfix) id EB907202A2;
	Thu, 14 May 2026 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778776757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pdG/tVsoMvlsgtwb0/xDU7sQiC2Pmpw+evsxsdmAiM=;
	b=Xz3VxA12tuoe3Xq9E0ATLR6GLeonMmLnQHLkt5cYp/qqCTp3P9keUPQbV3gqLm2z8QPDUS
	MOx0w/DSobjfOwGYjTKu8vYgAM00OiVKrr5dgIOtK0W34i91S1Dk4afg9sGIAooYaAEH32
	ghKCBYJikvmV65Lwrptc1cnDuDsZK7A=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Ren Wei <n05ec@lzu.edu.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 martin@hundeboll.net, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com,
 enjou1224z@gmail.com
In-Reply-To: 
 <35e86b835d6bd26fe4a3d96936f3cdbef2bb44fa.1778530692.git.caoruide123@gmail.com>
References: 
 <35e86b835d6bd26fe4a3d96936f3cdbef2bb44fa.1778530692.git.caoruide123@gmail.com>
Subject: Re: [PATCH batadv v2 1/1] batman-adv: fix fragment reassembly
 length accounting
Message-Id: <177877672920.69270.12363735448461779818.b4-ty@b4>
Date: Thu, 14 May 2026 18:38:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=306; i=sven@narfation.org;
 h=from:subject:message-id; bh=GeNAAzmfX4VSd+J0qXwufmImzGHHve/zTxsvemk38yI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsv5bm/QuqedJ0T2t5nL/D1bZ/LwLfhM98cbLySJezg
 0DJHd2AjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBENH8y/NP9/vr/nWU5M7ee
 4jq0/huviqREpKKwgPvaorbLyhzvp8Qz/FMIPGonNeP/hekH9lh+mjBT5/iJ4DfTj3mun/Sn218
 s7ysXAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CX5XHSMUDSBJRDTTT7OVPYTHOU53NAMQ
X-Message-ID-Hash: CX5XHSMUDSBJRDTTT7OVPYTHOU53NAMQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CX5XHSMUDSBJRDTTT7OVPYTHOU53NAMQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Wed, 13 May 2026 11:58:15 +0800, Ren Wei wrote:
> batman-adv: fix fragment reassembly length accounting

Applied, thanks!

[1/1] batman-adv: fix fragment reassembly length accounting
      https://git.open-mesh.org/batadv/c/9cd3f16c320b

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

