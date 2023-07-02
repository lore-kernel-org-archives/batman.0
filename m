Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B6EB64D9
	for <batman-adv@archiver.kernel.org>; Sun,  2 Jul 2023 16:34:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 102A0819B3
	for <batman-adv@archiver.kernel.org>; Sun,  2 Jul 2023 18:34:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688315650;
 b=2nv19aHuM7u78ds/ZjxAUCCzEsZ0qY3JFo5GR+0Th6E6uMTIjMAPkfbVlBXQ28eZsC2Ui
 PNRYzCXLiBgPZR3HkBQ9qHSDguPhLSYsnczehdjSFM5xmv3vWRvHiIqoohvhOJtx/0yVBxY
 rwJtj6nGFWBYsr54LoMCyGNkm4eN6/I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688315650; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CHfrOud50PuSWi44ugxakVoEmxQE2wT+2XXpsqWr4iU=;
 b=bVEuHTn0TQidnU5ORTNonYkW1D8LBXQnexg7uGQbs8Mi8ZiRMSFKiCqX3W0P+AOUrHst1
 LJiN6vkTvyEeiXxUVYx+A/Xr19UITu6oeIZbqbEts6GLpgUd2I/aWGTfEJW68jyATpNUMMm
 XYzEcww9t3rCiu5oSkOOWCMgSLCb4XI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=posteo.net;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=posteo.net
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=posteo.net;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=posteo.net policy.dmarc=none
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6064F80402
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Jul 2023 18:33:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688315636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CHfrOud50PuSWi44ugxakVoEmxQE2wT+2XXpsqWr4iU=;
	b=eEsmg4mRGVd1c5nAHJE8Gc0F1U+U54wPDjWvJzyrI5Rfm4vdnYXxwiYsoIdHCRzB/C0Tx+
	MzR6izexkMUUD6Lu0ZpBc+v3dkXHkYE7ohmGsG8uOU3jYfh87w+sXT3xlWQ/1ovODZluTc
	t4cEOMCcxI8Cn8Ervc6o92fO6MrFVdc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688315636; a=rsa-sha256;
	cv=none;
	b=ruZP7ivBo301ZgBCjVRjAKFpO3J1EvfOzBigAUuDXLKaHJSUYII7lzgRIrVy0eWYDLfIv+
	E3zxUM47FmpMDCV2tsGoMh1texp/bBJVJd7uiubGkWnI55E7XOP85nTrjlrc6Uii3UyZP0
	nYb2y9atwhs1I7fE3V7VM0TTayzx3OQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=posteo.net header.s=2017 header.b=X6Diksoy;
	spf=pass (diktynna.open-mesh.org: domain of pny@posteo.net designates
 185.67.36.65 as permitted sender) smtp.mailfrom=pny@posteo.net;
	dmarc=pass (policy=none) header.from=posteo.net
Received: from submission (posteo.de [185.67.36.169])
	by mout01.posteo.de (Postfix) with ESMTPS id 01037240027
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Jul 2023 18:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1688315636; bh=CHfrOud50PuSWi44ugxakVoEmxQE2wT+2XXpsqWr4iU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=X6DiksoyUidNdgFCfTJj+bqE8y6mERCh4vUKfzscv4H75hqPeRG0AmYmrOs40YUDI
	 A1lkceQ8AbdpdOjK4ohWC1GkMbVFcxmmDuFBx7y5t0SJ0WS9AVnUuBebyUGBwMajCm
	 ux5w9MZaaiIVsNvM+x2BB2DRt8wYXC2dY7gTuI6TNhQFFH3/FswARGjS3obX4Ch48z
	 p7UxBsxGQPpuKXuVuT+fMIWuApnuB9EQxpli6etsTGdeW22TEkVMulvWClL3d7/mMe
	 RD+PBAGCD5YUjo2so3w5rRAZ1dT95gH/pOILXGios4tjr8nHBhCULiVLWbYsHVBEbN
	 J2dLwBa92oVuw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QvF4M4lLLz9rxS
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Jul 2023 18:33:55 +0200 (CEST)
From: pony <pny@posteo.net>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: forwarding works fine with 802.1ad vlans
Date: Sun, 02 Jul 2023 16:33:55 +0000
Message-ID: <2905628.e9J7NaK4W3@katze>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: HSQUJI6DNBQF5AEOXCDXJBG4XVOJY7GY
X-Message-ID-Hash: HSQUJI6DNBQF5AEOXCDXJBG4XVOJY7GY
X-MailFrom: pny@posteo.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HSQUJI6DNBQF5AEOXCDXJBG4XVOJY7GY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

In https://www.open-mesh.org/projects/batman-adv/wiki/Faq#VLAN-forwarding-doesnt-work it is stated that batman advanced will only forward vlan frames when it knows about the vlan. However this seems only to be true for 802.1q vlans. I was able to send 802.1ad tagged frames over the mesh without configuring any vlans on top of the soft interface. I am using batman-adv 2022.0-openwrt-6. When I try the same with 802.1q it behaves as described in the wiki page.
This may be be problematic when people rely on batman advanced not forwarding vlan tagged frames.

Kind regards,
pony


