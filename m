Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9276BC77B7A
	for <batman@archiver.kernel.org>; Wed,  7 Jun 2023 15:55:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8683D815C8
	for <batman@archiver.kernel.org>; Wed,  7 Jun 2023 17:55:24 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686153324;
 b=FnfkSyCOupuTqup2XLhZOtAG0YWEXDJW1EUk1opQMRQ28qcjjDltLrZf6o6uuRlZ6VIXM
 v4QymX7NQY1AN0h/NLJVCb5WtG59xkbe9LyqkoWA7iEbcZ4xa7Gv6lQbTlrobuw9To06cES
 SMSK8fxhgQ73oP1hc82gXVEao0ua0kA=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686153324; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3bhEhu0OiNNDzF9hlUr2mVxR3tx7ZYsrXal5Roza8mg=;
 b=IBDeTT1UO5uBNq1KB6axNctrYT/BxBeg/yry5D6LzQZz9AOFfZWhMNfl/Ukh8VcJfufn0
 D7OJZMan9IB2WktY/YhDCexB7ysjI26BVr06rbHmKXUTmxcM4drXLxfxbzLMpDw45cQ95Oz
 Ud0fFpxbxTz8IAd9lY2rHIh2AthhvPM=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2AEA280519
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  7 Jun 2023 17:55:21 +0200 (CEST)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1686153321; a=rsa-sha256;
	cv=pass;
	b=2dLTvJWeKYIvL7RXRpHndiAw2gpfzP561kLiuvZMp/Zu953lFwKcN6DhjeqolLH20bp9ep
	NRL9llBxScbQ4OKJHS5Zbk2wSWb1xe79OA5JquIMh2CfrUe1auucMhTFBNz8rzQY8PKj9Q
	IkBW9HWllwamcEWwkIOfoP4xnq5/Kgo=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=vYL141pj;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686153321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=3bhEhu0OiNNDzF9hlUr2mVxR3tx7ZYsrXal5Roza8mg=;
	b=QvFyQs5cmbvBHCNvcW2O9T0KJwnS3KQ/TYn0UMFCjLlsbYevaeKy9EvpGahtubgIAzUmzo
	ylP6epTE9z/YlP7+BvI0qSx5kfmCByyFxeK9vuKjsAM0oKZk+Xq5IZrxyd3rmuIgsBRAzS
	leKpfbVcwCwu4e4/go3VJy2Tm3wAuhQ=
Received: from kero.packetmixer.de
 (p200300C5970e9fD858c5a4eeF27C1696.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:9fd8:58c5:a4ee:f27c:1696])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9D6A6FA14B;
	Wed,  7 Jun 2023 17:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1686153320;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=3bhEhu0OiNNDzF9hlUr2mVxR3tx7ZYsrXal5Roza8mg=;
	b=vYL141pjQ56Ybg/Hl8o3UsFCPAUZlQKv+5S+oXk5CYfgCpjfFeOFituGUh7F2xdCvNKWUL
	RlHg8uhZqUDPt74eI8TqB3sMRBECe4l7HhVdV07Rr6jDxHYdC6SMLrWTGz1/uWv47VkQk3
	yrPGZtjq8u82SU77pHEk+IpcnhxIrIyEl4rhWaehlxYnMngTfMtdjKj01LW+Sehd57cZfM
	PcODbTeJ9xJbumwxfulPUYbKtcO0mzMehucBEwLk8DEyYC55ieqeksEtN3iMHEcumJK5uB
	Dqyujb4vPqMtPN/REKdGTLWZEK++X8Q+s6URCWX8phQ7UgsS7i9jU0VBgY1Grg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 0/1] pull request for net: batman-adv 2023-06-07
Date: Wed,  7 Jun 2023 17:55:14 +0200
Message-Id: <20230607155515.548120-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1686153320;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=3bhEhu0OiNNDzF9hlUr2mVxR3tx7ZYsrXal5Roza8mg=;
	b=Ofhec/EtB3wobPBexMwcU+5vUwzFzTSttQDzNsE+uRZnrYtbZsBgf3/8sWFAKkmbPz3BPE
	kx3aQ6ShwmaDy9NPbYhCJtrKH5oj6TOEPbKp0YqQst7oHFc5ZGtMOF/MbWI8vjCvyYqKS0
	eIySPpDCnxUsgf+ciMZ5WE65NYRtOQ240RTpseoV2Y8gzZNibOZmwNFyaqoKq22RyX5xF5
	fawgTuzMjNjOYnY6jFgoljdIBNhf1g+p6a71QD3ddJMq7uAViuVJg3qOLoWLVUYcBkMFov
	ybPaOkf9NTTmhMzlJtcHJift3KvhjWwQ9jDtG1wMCIRFo8qagC07d95vwqpINg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1686153320; a=rsa-sha256;
	cv=none;
	b=JvoZYcMWVjHQ+HuZg/hlPQqP/G8Edh2VzqJNUq2e+mbj+bdZ1rz6SM/h027wGo3zPMoS6m+tkvXTiy5ZHcWseoPgFiMszRgXSXpmdpX7VpXq2WawKTrskwIoK5AIqr6lSDCskUs01eILGDh6gu0wWA7NZW1e7/EP4uPJ331kTobNipfrd5WZK5DdNpxmW/Lx6F6++uTkYF7aA/Npoet/7rKjaVr5vwFVAMZOEbErHBTFGRM1hHrxaIwQa7L4C1xPpPpeL7E49dd65GWsi3Xl3ftRR+vhKI8ZFTKKnpQrjsRwisQgm8pAIpyuvrBCUNkTtpEFQ29xu2fIIRCqBr73JQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: UNLHLJIPTKX6NJQESDLGTO77I4WHM72U
X-Message-ID-Hash: UNLHLJIPTKX6NJQESDLGTO77I4WHM72U
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UNLHLJIPTKX6NJQESDLGTO77I4WHM72U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20230607

for you to fetch changes up to abac3ac97fe8734b620e7322a116450d7f90aa43:

  batman-adv: Broken sync while rescheduling delayed work (2023-05-26 23:14:49 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix a broken sync while rescheduling delayed work, by
   Vladislav Efanov

----------------------------------------------------------------
Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
