Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6485CFC273
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 07:39:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A4ED083298
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728977990;
 b=15EFvGsLw2KB8jCC2VC2pPEgvz4i0ySHocc21XGJbsCWup1hqjlcNW2/9IxfH5Z93OMYZ
 ia/bEJaYzGBS9vPiANYKZXJ7xby5bd6tQCADR1hpnO8nTosCFzhZwCYy+ItzE7vBsFuGrzG
 E7IsLVP7pf+74ukAZ9wrIjVylg7j5uw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728977990; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WGMBb7Tt7oNniS72ABECspdtA+OJLA6ghovR+VKhU50=;
 b=2wt/NBJDAlu21NtF26gxOV152Mtt+nj5pbVSPrGI5yiOqjbN8i+HQw20bcf5YRU7VG8gL
 6qWzamTvBdR3eRnQhBWRxHA0BugSpAtF0CssEVaW3W/Pi7xA34YDoqrvjc3Jie0dTooDZqk
 aVIG01zukm5XC6AYA4gp4FcW+rMbjnY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7A3B68164E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 09:39:48 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728977988; a=rsa-sha256;
	cv=none;
	b=3UYPmbiYJZpzoCk/sG87wKwXbkdr0EvgK16fM/SXIysVEKEZ8EuPqUa9e4XhymewsKS+BL
	AtUtbifpcOhl9s0RpIatnLwL6FGuCnrnfBatgqdJnLThxzbGV/BUHjB9hjr62WF3MLk7XH
	63MSM72RirR06p+MiCWJ1NNojyhkywI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728977988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WGMBb7Tt7oNniS72ABECspdtA+OJLA6ghovR+VKhU50=;
	b=Kq87jAg1d2tST0MmiPRN5usVmlYfQ+8OVQw0ffdc2+kJkEQTqkD5KBecM6aGpDBBAB1xWZ
	TYdk/RQEk4rCzHti+BxjS2jex3p6oOJrgJy/2jHZownKRkG5e5yKf1EMpHjAhAVXNv8x35
	U5+RJljvrTKL4Gh3/5l0fJar8+eyDcw=
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de
 [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EB5E3FA132;
	Tue, 15 Oct 2024 09:39:47 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2024-10-15
Date: Tue, 15 Oct 2024 09:39:42 +0200
Message-Id: <20241015073946.46613-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V3UDL2O73WQCTBG7STDEWN6G4F34YXLH
X-Message-ID-Hash: V3UDL2O73WQCTBG7STDEWN6G4F34YXLH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V3UDL2O73WQCTBG7STDEWN6G4F34YXLH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20241015

for you to fetch changes up to 356c81b6c494a359ed6e25087931acc78c518fb9:

  batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback (2024-10-14 09:08:39 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Add flex array to struct batadv_tvlv_tt_data, by Erick Archer

 - Use string choice helper to print booleans, by Sven Eckelmann

 - replace call_rcu by kfree_rcu for simple kmem_cache_free callback,
   by Julia Lawall

----------------------------------------------------------------
Erick Archer (1):
      batman-adv: Add flex array to struct batadv_tvlv_tt_data

Julia Lawall (1):
      batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Use string choice helper to print booleans

 include/uapi/linux/batadv_packet.h     | 29 +++++-----
 net/batman-adv/bat_iv_ogm.c            |  4 +-
 net/batman-adv/bridge_loop_avoidance.c |  8 +--
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/translation-table.c     | 96 ++++++++--------------------------
 5 files changed, 46 insertions(+), 93 deletions(-)
