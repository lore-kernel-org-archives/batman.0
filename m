Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBEC43458
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jul 2026 19:48:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 19CBC84940
	for <batman-adv@archiver.kernel.org>; Thu, 09 Jul 2026 21:48:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783626498;
 b=iQNnCLFqrF7o/rspcnmgVJY4r2/IODCYNUbuz87OgVbxY/kysby1FdkvRZA6iX6yO2dU6
 IIpf6OhXIbvOSfKMiPPYBXLY11S+mj2XrROXuvDxl+9L31rsQ93rswamGlfclSg23r3dUUK
 UcvQ5KuuqLGk2hUg2OxRLgqDTINgIh8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783626498; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tgiiIc1fhcNyjC1WNVhrPfJ8RlfLZ5lpAjVRma8jkS0=;
 b=kRsu9uObSFfjiP3mVG+qpz4cYxTP5F1+YfrbOdbPRXrhSReBwWBz7vP1nwL26RHpz5Tq4
 P4CkCyWPZwVLkpCkRevz4dRiYOEte4+m5QALNbmM/q9cUBo2B5zsSq29pda2eBk818p/kwh
 s12TOyfuBePP+7VzvgVntoWsAuEJ++Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 863B383E95
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 09 Jul 2026 21:46:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783626385;
	b=VOsTO470aDN0JCa5Oj3rp65DMVDowzhgfo6igpkJucTrYWeiyURCDiNDMp71h9DthlDnFT
	yBE37PdknGyz3WxiWKZwk+fhDFPER/PAzy1/XmvG1d5ALVGd9Q32Ih39lgRHjscxGEo1v7
	BM8WvfiRN0ppJp4GsB7sUbtito1FSqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783626385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=tgiiIc1fhcNyjC1WNVhrPfJ8RlfLZ5lpAjVRma8jkS0=;
	b=YYHaBYb5B4G2+pcLKTImTlx80wqbUpL1NDOkMxJwaWkr7qq8b6qW5DdJksiozoHe1rTjUv
	8NmWRGMIKmYk2ryNknfeN1vLgTvta6RZx9fmAgvyB1lkf9NT3aVDLjbwJUsGDRVQ4DJZR6
	umuRJAT37gAyHk/Fg5J80o7JjaIWDRA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=B0RnuuSk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 60B542041E;
	Thu, 09 Jul 2026 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783626374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgiiIc1fhcNyjC1WNVhrPfJ8RlfLZ5lpAjVRma8jkS0=;
	b=B0RnuuSkw3ibALY0QxE4iNDfwDbDX8TQPQBHg3eixQZ2Q4sYLSnDIsnqo5aaE4M4iB2DPM
	7WGGmFYscSc7UNpccxrP+fG8epcQR9qYCndY10ThaxZlehxy8PcECMCDglc4vmcVHl6OtH
	FOgPMBX2e38ht4NEPhEBCKYgmfv3L6Y=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/3] batman-adv: mcast header creation bugs
Date: Thu, 09 Jul 2026 21:45:54 +0200
Message-Id: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHL6T2oC/yXMUQrCMBCE4auUfXYhLdharyI+bJIxTcEo2bQUS
 u9u1Md/YL6dFDlC6drslLFGja9Uoz015CZJARx9bepM15vBjPx0ooUniEfmgIQspX7YLkHZwre
 Du5ylt0KVeGc84vbjb2SliF/p/t91sTNc+dp0HB/jf7vPiAAAAA==
X-Change-ID: 20260709-mcast-header-generation-bugs-bed17c85a6ba
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=sven@narfation.org;
 h=from:subject:message-id; bh=WAwAEQa0Q9b9A482oFy9dGqWqa7rGVkBB6n5owHuQWQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn+v0pdbaWO25o9rfFKC7zZVCPdPb/wTZfSty3Z8xcWN
 5jarlHtKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzEtZWRYb9r968t2/7vPPj/
 A/uTF3rKK23CnX6mFMYabq6+Uf52IifDb/YcwfBfC6fqSJgqpe9mjv9r/8/9SpPwXuHPT5wnRnX
 MYQMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MTTLO4X2VO2PK3UHJ6PYVU5ZV2NOANU7
X-Message-ID-Hash: MTTLO4X2VO2PK3UHJ6PYVU5ZV2NOANU7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MTTLO4X2VO2PK3UHJ6PYVU5ZV2NOANU7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code which introduced the mcast packet format was expanding the skbuff
header in various places. But this broke the priority extraction and was
requiring various skb properties (linearized, unshared) but only in some
paths (forwarding of TVLV) ensured that this is actually the case while
forgetting in others (initial creation of an mcast packet).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation

 net/batman-adv/mesh-interface.c | 7 +++++--
 net/batman-adv/multicast_forw.c | 9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)
---
base-commit: 6628ab4bc899bff39637008ebb5ef89372efd9d3
change-id: 20260709-mcast-header-generation-bugs-bed17c85a6ba

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

