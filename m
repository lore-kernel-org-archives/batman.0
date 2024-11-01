Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABFE6F08E
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 22:05:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5B4B083D15
	for <batman@archiver.kernel.org>; Fri,  1 Nov 2024 23:05:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1730498746;
 b=RcG5Xk2QLTiyegtmDRdbCN4b5qrvyYgPDfdhQmYWGDvVDr+lsRZey3ESxSqagHqZx7OvE
 BOUvSZHAjWSA9yFzyYHC2xaxD4m1d+gK3EcPJisr3pGZEHD2kz+KW+QsN0Ba+1TVOY4g/3q
 yEYDDhDzhxDOmLWaabReSfQeRANvqaY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1730498746; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1kWelsFdkXy272TEXnZ9Uc/lMGvEi+JsOPmDSHUal+U=;
 b=q4zwAoIbXb/iacrNqTCMVhWnsSv6BKkKkhVn0WSFnyDD/Y5i7eEvUAPzakAaD0yvqBKrS
 nZywr6PCCz70EP9gUwKS4CCM/rvWKBoWAxgZa49Cqz1PnbxYHYxz41uQYXgnc9z3dGVXm3T
 i1ofVDk53OVvHoBoqGj6i8GLQJ91yoM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3184A80EAD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  1 Nov 2024 23:05:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1730498741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1kWelsFdkXy272TEXnZ9Uc/lMGvEi+JsOPmDSHUal+U=;
	b=DijM9jM5X6C2IIaZv3C/Eoc/j/54siFsqvCftXD8yEbfiN0uT/BmG/9rFCI4jt6JevKFXL
	9bG0X5HbADYGu3uP5HP96snrVJRWBh7FwI/AzMO1Avlfvomr7I+GoUsgwUux9F2wknV2cw
	EmIQ8SnIcF9t8Yc3/YS69aDx0DyPpQk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1730498741; a=rsa-sha256;
	cv=none;
	b=TiocBisNLyr/Y7VDou9r/g5W6RCI3yxKEeDENZerwvqA+Vn2wvq7eKnDi7uuPp4k/vF0Tc
	MVEYoAJ6/g0DjEnax6SXwxC84OwjXtkeeakB7QKJhNjDrygPInOb3v22EfUwYwhzKXK52l
	mOKW7O8WOfi7nCQT/eVOpmdHj6Zrbkc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=Ld4RdbK5;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=OcIQ1Nft;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.7op6ls2kew402q6=sis6xigyx40d=z1ngjpcreens81@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.7op6ls2kew402q6=sis6xigyx40d=z1ngjpcreens81@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1730499640; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=1kWelsFdkXy272TEXnZ9Uc/lMGvEi+JsOPmDSHUal+U=; b=Ld4RdbK52ZVReqHuNSb/V+4FHD
	o7RirBsgdKBp44NsEnHnIXAsnpXNBph2N14H8xkod1jlmTOP8qxjKaC0sDh5Lu7Tsbmy3H3M4OgE+
	NEOin8LTUc/BC0aZJSW4ZR4ELUq8uo4o6lAhrvuLE5vl4bAKFTRjypTqlk8ZortPhh0K9mvhuE6Pa
	/MgyxvJ8d9HBdxM20Mfe+ZJvuLO09s9fpSJOibbdXgcz239sEik6daHccYjmcyaLaKrHNVYVlWpu2
	Z5DYM3tF7Nrk9UzHOLvOEFosBmGD1nkbsCA6BqLlkwWH+QzjVECeOO4E+RZDoxo9jXz9uUS34qcKw
	8yu8fwpg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1730498740; h=from : subject
 : to : message-id : date;
 bh=1kWelsFdkXy272TEXnZ9Uc/lMGvEi+JsOPmDSHUal+U=;
 b=OcIQ1NftSqUrNokFhid853ucWZwxsSCyh5LrX7a/28i5tsR9vET8YH39cMi1cgsmb/r97
 ucW0XUeAksX/4GJEdIfiuKGnEBxqlp8XejK4XEX1jPgSMNB2kZSqh0qQVN5kosxUZmaY/Rj
 RzcIkUChP8PrZT8woPjDzVh9ae2pOcwVoUxJHcGdLnZg7RSYxu2Vnx1byHgK3QxtkRpnZ+5
 FeYPURlQfVjVI/EpQxaJ6/xESZUiJe9Sg/UoEUwZHabSl+foBcv3uHnCCLeDksh9MfJD+kS
 U9vcA9H/GYua00InVDjUFyQXxCP8HuNCcgN/vFO4qyaWIu3FkqIPxCYl60IQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zly-TRk4fn-Pv; Fri, 01 Nov 2024 22:05:38 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t6zly-4o5NDgrqMyO-qkcA; Fri, 01 Nov 2024 22:05:38 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 0/4] batman-adv: TT change events fixes and improvements
Date: Fri,  1 Nov 2024 23:04:58 +0100
Message-Id: <cover.1730497875.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: kkj9Ei0zHxj3.y5e_IodCTGoD.yqiYmArUefw
Feedback-ID: 510616m:510616apGKSTK:510616srgApmtrw_
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: 4OYSAT3LCCDK5B6GB2564HZN2R7APCCV
X-Message-ID-Hash: 4OYSAT3LCCDK5B6GB2564HZN2R7APCCV
X-MailFrom: 
 bT.7op6ls2kew402q6=sis6xigyx40d=z1ngjpcreens81@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4OYSAT3LCCDK5B6GB2564HZN2R7APCCV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The first two patches are actual fixes.

The first one tries to avoid sending uninitialized data that could be
interpreted as invalid TT change events in both TT request and OGM.
Following invalid entries could be seen when that happen with batctl o:

 * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
 * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)

The second one fixes an issue that happened when a TT change event list
is too big for the MTU, the list was never actually sent nor free and
continued to grow indefinitely from this point. That also caused the
OGM TTVN to increase at each OGM interval without any changes being ever
visible to other nodes. This ever growing TT change event list could be
observed by looking at /sys/kernel/slab/batadv_tt_change_cache/objects
that sometimes showed unusal high value even after issuing a memcache
shrink.

The next two patches are potential slight improvements. While patch 3
is mainly cosmetic (having negative tt.local_changes value is not
exactly an issue), patch 4 is here to keep the TT changes list as short
as possible.

Remi Pommarel (4):
  batman-adv: Do not send uninitialized TT changes
  batman-adv: Do not let TT changes list grows indefinitely
  batman-adv: Remove atomic usage for tt.local_changes
  batman-adv: Don't keep redundant TT change events

 net/batman-adv/soft-interface.c    |  2 +-
 net/batman-adv/translation-table.c | 48 +++++++++++++++++++-----------
 net/batman-adv/types.h             |  4 +--
 3 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.40.0

