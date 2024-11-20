Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADB2D711D1
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 17:48:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7870C83F38
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 18:48:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732124928;
 b=qNxcjWvP6nvUM67/0kHt68aFhZ6jJZeRrybaIvVs8eJpf4CXIVvqs4EuvjnieokttUMk4
 so9TWneUP5o74ayuSY7WpO5GaX4UYOhiMonC2YTD1xqWCmyHQmmPBYj5q8QgCBcEAoWrBOa
 Iv2XOiDIEpDdY6Jb85qIP6FS1o9mo48=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732124928; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TxOlDRYM6DiPBems9UikBYjdHgRjXlvaI1JZOcgNIUE=;
 b=osYPCM0A1Tf4vq89BH70ZTBOK/7kT61Gl/SKtQiUT8fEgL38w5imNJ6phxZdKUB4xeBOd
 7nan3kBBVCblZH6JhzZIyuRJwK9WFOjp2Vez3e0sagTn8mlCxOWqBjDKxJIaHOJgoMwAQcr
 dWdi1bRBEiJbKYbxmVEhFqQh9yYAmv4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EA31781D84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 18:48:32 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732124913; a=rsa-sha256;
	cv=none;
	b=I4dnu3RT5b+sGtbhIJw9zSVSUersNzpOT9dIjRIgZxw10GFmo55l0azQESfVXgRnjFMZwS
	VLuIvjO6Oi8Y2kKGIA5F4jU4q3y9NXY9HQFnMOxaQt4sejsMfjaPKSZa1uSDgtIFAOwWz7
	hsTk498dcuK4pB4cdgNtuieC9CSv36A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=VRo7AHAB;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=hjQeYl6k;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.8gddndohmjcehn7=txgaxu9rdzeo=gp2936vdc8kf0a@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.8gddndohmjcehn7=txgaxu9rdzeo=gp2936vdc8kf0a@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732124913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TxOlDRYM6DiPBems9UikBYjdHgRjXlvaI1JZOcgNIUE=;
	b=W+tJIbdw39WO5Zk72iALzMsOMQQZp44t7Wro+OJcCHoCoHnNQt8huzVWHDCvJs133JhKae
	0Rdo41nhslbLuIWI2mtxRYAKpfkpK+gPwkpESpr9osmbCQHW5LTiYMTcfzp7zIdLsnZVJE
	UM+KCZHS4hhaAvtuUmWzOSQ9+S5igMM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732125812; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=TxOlDRYM6DiPBems9UikBYjdHgRjXlvaI1JZOcgNIUE=; b=VRo7AHABGDjv5vhqBMoV38MWcl
	eMhYB9F69af8PXeSj1ki7eAQr/GWxcv+2DP1a8ps91ZU9ooEiscLMaOdLvOjtUc3MddZv4763IQcH
	vwOZ9QhrR53yBkFHyhuhU5syrVeyw3OT/vGy7xxARU4vHZ6iPWXTJl/+AZSZ+uaw/cBzd7tUvBVUO
	1O9e0uX9f+8FDZ9qZyNXZXUk3I7MXlgfau5RV/P4abhN5KJa+jRlnJrn422MYaME3uWqFB6QVBDwU
	xo2vrMcmA0GttBDABZBzxn4BJYk4Nc6DwUgLj9dIV3ofOZdvlU1PoB3pRvRP69roosvU2s/1PkUfN
	g8G3C0YQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732124912; h=from : subject
 : to : message-id : date;
 bh=TxOlDRYM6DiPBems9UikBYjdHgRjXlvaI1JZOcgNIUE=;
 b=hjQeYl6kNM1b7VtJOXCJ9xm0IutyYNotpgiZujJpfySaRqZs8iT2xA6YtILwZ557KVH6Q
 Be1a55JmVGi6hcrkhgd8VodAXDGawGIWp/OqZPjcsWUyLGMU/BSP2f1qtjAz98xFgOHV87f
 LwwkAAynfaLHCWsj4ae3vlhcuK9q/R6b2DuwO/wdiL0+ceKtmfgd+VdN5nW0c4AXjSKPzsr
 fMkBBLK7QoHevM9IMFDCChq+NBiBS65swbID9RT1Tajub4Wsc9TkEWZf8n4WMtclkiKQoUb
 jyVGrxaDEFoyqHv+cd9CrM8BS1gybpaTD62+SDahhMnWlkJuJrf62qS/iMMg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooY-TRk2wX-Mx; Wed, 20 Nov 2024 17:48:30 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooY-4o5NDgroivp-pdEO; Wed, 20 Nov 2024 17:48:30 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/5] batman-adv: TT change events fixes and improvements
Date: Wed, 20 Nov 2024 18:47:13 +0100
Message-Id: <cover.1732124716.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: rBj_dO9Vv8DE.bElPC4my2TpT.dEn1OA5UaDP
Feedback-ID: 510616m:510616apGKSTK:510616s19sbn7nzs
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: WVJXHQFNZLHNP55Z7TUCC74P7OSFRLRO
X-Message-ID-Hash: WVJXHQFNZLHNP55Z7TUCC74P7OSFRLRO
X-MailFrom: 
 bT.8gddndohmjcehn7=txgaxu9rdzeo=gp2936vdc8kf0a@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WVJXHQFNZLHNP55Z7TUCC74P7OSFRLRO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The first three patches are actual fixes.

The first two try to avoid sending uninitialized data that could be
interpreted as invalid TT change events in both TT change response and
OGM.  Following invalid entries could be seen when that happen with
batctl o:

 * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
 * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)

The third one fixes an issue that happened when a TT change event list
is too big for the MTU, the list was never actually sent nor free and
continued to grow indefinitely from this point. That also caused the
OGM TTVN to increase at each OGM interval without any changes being ever
visible to other nodes. This ever growing TT change event list could be
observed by looking at /sys/kernel/slab/batadv_tt_change_cache/objects
that sometimes showed unusal high value even after issuing a memcache
shrink.

The next two patches are more cleanup / potential slight improvements.
While patch 4 is mainly cosmetic (having negative tt.local_changes
values is not exactly an issue), patch 5 is here to keep the TT changes
list as short as possible (reducing network overhead).

V3:
  - Fix commit message wording
  - Update outdated comments

V2:
  - This has been tested enough to not be in RFC state anymore
  - Add one more uninitialize TT change fix for full table TT responses

Remi Pommarel (5):
  batman-adv: Do not send uninitialized TT changes
  batman-adv: Remove uninitialized data in full table TT response
  batman-adv: Do not let TT changes list grows indefinitely
  batman-adv: Remove atomic usage for tt.local_changes
  batman-adv: Don't keep redundant TT change events

 net/batman-adv/soft-interface.c    |  2 +-
 net/batman-adv/translation-table.c | 92 ++++++++++++++++++------------
 net/batman-adv/types.h             |  4 +-
 3 files changed, 60 insertions(+), 38 deletions(-)

-- 
2.40.0

