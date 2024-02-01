Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A57C47DDB
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 11:01:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B151C83C02
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 12:01:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706785279;
 b=dMlyQ1HDUswezkjDRZiCg8E7773plbbL9//pgyidkTO6TZ85rCU9Yx3HsamhlVlqZq+XF
 atRaP2KwOpqb/Sg/gI5hL+qZ9/UhVbfv8/5UsKOw46l8OeJQ0upp/yiiCVihy3oeMUWCVft
 cfDZCMZ+N2wBrMi6cy/BGpFybQEJPw0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706785279; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PIu4b4ENaMqMljhtfG0Sexwhlq7vWijCXLA/jb9Tu6o=;
 b=js7v0gqnP7VKiM3m3Jnu4SoHQHQtfoXBl9gUFESJ1OCCbKP4zyfomUJ9Q6tx/NOPpuGvO
 cj1dpo3ohyswDliM8BL820FJiqLFp9tZqd1vkFJRkQemocxkdt/ZQj84OKknXmdFG5L9CsJ
 huuNL87Lcz9lKPBHSuNDpVH032pLcEI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6CD4981A3E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 12:01:15 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706785275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIu4b4ENaMqMljhtfG0Sexwhlq7vWijCXLA/jb9Tu6o=;
	b=ZmerPuRvN/1aTtoMWZaVTmItsUja7UeWmgRAZmgLQyPSN4cwOqa9WnllnGgRufYEoBbWcS
	RqKlNCnk3rof4FBkTq6pN1yXUL1vqtnfWxUihOCkcqLuuyWeVcjlZ8S+I8EnnNUbXbHnuq
	xykkapYYB3tXsKMtBbwCLw2rOVckzTE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706785275; a=rsa-sha256;
	cv=none;
	b=dGcQs5FxpIyGE68mZooyG+KvvB9L9jIKpJpW0AF14sqpr0Z7MW7sVgBY0VRhKGozZm96rc
	JitUrrghSEvAxDAA5S6OXHlUoRNR8awPqcgFOOZ6e0XEuGJ6rNXl9JVEYuBOZDQ+IqK1qU
	O5W3NlhYME+sjOPuUVZhJURnRX4oo5k=
Received: from kero.packetmixer.de
 (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1B9D7FA2D7;
	Thu,  1 Feb 2024 12:01:15 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2024-02-01
Date: Thu,  1 Feb 2024 12:01:08 +0100
Message-Id: <20240201110110.29129-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XEQQBH4XG6ECDUA3ZV46KP2FV5SKIGWU
X-Message-ID-Hash: XEQQBH4XG6ECDUA3ZV46KP2FV5SKIGWU
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XEQQBH4XG6ECDUA3ZV46KP2FV5SKIGWU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are two bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20240201

for you to fetch changes up to 0a186b49bba596b81de5a686ce5bfc9cd48ab3ef:

  batman-adv: mcast: fix memory leak on deleting a batman-adv interface (2024-01-27 09:13:39 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix a timeout issue and a memory leak in batman-adv multicast,
   by Linus Lüssing (2 patches)

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: mcast: fix mcast packet type counter on timeouted nodes
      batman-adv: mcast: fix memory leak on deleting a batman-adv interface

 net/batman-adv/multicast.c | 3 +++
 1 file changed, 3 insertions(+)
