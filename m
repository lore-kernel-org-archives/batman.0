Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868DCC001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:33:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AE0F283375
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:33:53 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692203633;
 b=jz8V1wEVuH+P3qxe+ikFZhlGN+yIpPY+K83/yuwxHRregcF+m9/QeWIRCdDOCCp5Js5XG
 610QrU5qnBVrbxAWcqQ5MXxULdubHcqPctNcdI1IV6SU8p0CB48NPhVp9lSsQwVAjVdjJS0
 fZ6XDh391ZHrlB4JsH5SD2Wi1qBnG/Y=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692203633; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
 b=oUtlzAdDtEd/cnA/UDQuML1SpUgxLQMKEWPkKmevdehrWoj1LDBc3Z9XCrpKnGO+2tCov
 WHlaDVH45c4fSWre46WRoRx63qGsEp4dR3P3GOnTCRge+7ONSlkTYgM0cuNNJE4BHHeR9DF
 /jwjqwslvxAdTyb5mrG9IOZZjUXF23c=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B4C4D814CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:33:20 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692203600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
	b=i9Kpvp3UgBbXXMGT24bOQVUgdDTNGicCPqfU6V8cvGr6dMvdeObfIKKNvGuWgSC28i+dIq
	KqadmRCgh8ZC+kq22Pyc1XaMLdObI8V69GsPfVnX53nh8n31J1HPLkurfBvrSe8YpI8WE5
	VxId9b7gvHFsxrEiG5/NdPAuwUy4yGs=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F3hUDqEb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692203600; a=rsa-sha256;
	cv=pass;
	b=bcjK2cn5F2TGyywJ0iT7di1xRKZMSSKCkjI50fpcVug0/zIxLql7+5Rnj9mwipY0IK8T2c
	JzYUuXxHuJD7gIlR5TWy+ZtWtX6fFnVO6+r4Iem1S/E50DklJjPjlt2Oi6t4HpPdDqZXWe
	fFV4LOUMEJK3irJmquesMWbR3xQmXC8=
Received: from kero.packetmixer.de
 (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 64368FB5B0;
	Wed, 16 Aug 2023 18:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203600;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
	b=F3hUDqEbmJekyGRawjrUDrekktiIIGEiZO6ZqsP4F/8/5U4J5dyFVnlioGi3/wGXPzjzgF
	OR2SUHwjZcGvyWslqMh78BrrJUwRZMrCIRJCJ/A8dSU8cdLkWdNTC5Qo9yuadLRGKgEnth
	b1K+qzmZYSN6JYTdckO0eSgcn5yy023JSAz+aNqD+a/CFfNRYYNYXgrOKaOe5QFwvJak7H
	DEpE3Jh6fQo3gPS7ZT9MnpeNCumRCc7QQIc7ak/3hBrF9w151B/bMOYH7bJZjF7YoEToSV
	EVLt8GFuaOXMkFbbHrA9btUS4NOC3r9vo8J8BC0tRP3tIbdFQvZcw14An+xkMg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 0/5] pull request for net: batman-adv 2023-08-16
Date: Wed, 16 Aug 2023 18:33:13 +0200
Message-Id: <20230816163318.189996-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203600;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
	b=w5zzxd2iYrgIPHMMWMgNsHPeyKEvPUrotjdrBAta2yBKE6sSzjtLbrjYlDLDs/BAl40U8I
	orVg+3+SL2m2/rpRqQkdEx3u9wEm+Mmk09Z92g6SIcQfSAOZsFfByMv8tGqoMfKJsNZ0ZY
	Iz2F0NltGKXXy0KED36TUEbn3R3gkeEBUvJvCPukc1KOpQjARrovFykxk757udt0nVr8qB
	9bWiLyCBXznHQMYUi0nXeZJWFfZHBAgzDmFrGWblH6O8C3MNBD5gvrJvqulSy3ATCP0+tq
	BiUFxxZc2nyT7iPziZNqnPdmPLDpdHIh66UDRSEWARwNU+IZa+WCwkUI0Mba2A==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203600; a=rsa-sha256;
	cv=none;
	b=hi9As+oKAsM71PgOCV5+aZUmKgvQPNgiAe34JsFGZQ1zGoxISTlDI8Yn/CZAsVOMGSja8JQsPEMwFU6AZ3TdgagsoC485sq/0/dp87RH7mp0gze1JcNe0AdtXVTMJwaWNC3XGXUqXJGM7xM5EiyQpmekwsJixO6pPW8L1BysXvHjZuM3I6Or5Dno+V7460CSBK3riYxAyzs5k9PMUkbsKCSRxUHDzdLQ9sOMEX+Lxib4Vy6k359X7nAp+wfx2tSFuh9BJP7EJFD2Z18hJ9i7t2Pkh8bKHhqFoAOQ0RA1VWABfTcLrQczgXUdyKKB9Z4C7igbm3LWRoDTIA08w5HsSA==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: EKR3Y4WRJSBT5SMAB22GBWOXCWLE5BLW
X-Message-ID-Hash: EKR3Y4WRJSBT5SMAB22GBWOXCWLE5BLW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EKR3Y4WRJSBT5SMAB22GBWOXCWLE5BLW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are a few bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20230816

for you to fetch changes up to 421d467dc2d483175bad4fb76a31b9e5a3d744cf:

  batman-adv: Fix batadv_v_ogm_aggr_send memory leak (2023-08-09 17:33:03 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix issues with adjusted MTUs (2 patches), by Sven Eckelmann

 - Fix header access for memory reallocation case, by Remi Pommarel

 - Fix two memory leaks (2 patches), by Remi Pommarel

----------------------------------------------------------------
Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Sven Eckelmann (2):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user

 net/batman-adv/bat_v_elp.c         |  3 ++-
 net/batman-adv/bat_v_ogm.c         |  7 +++++--
 net/batman-adv/hard-interface.c    | 14 +++++++++++++-
 net/batman-adv/soft-interface.c    |  3 +++
 net/batman-adv/translation-table.c |  1 -
 net/batman-adv/types.h             |  6 ++++++
 6 files changed, 29 insertions(+), 5 deletions(-)
