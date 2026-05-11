Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337BBCD37BE
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 17:30:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 73AE185A34
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 19:30:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778520633;
 b=mfVzFOfyiuljuqi9iHrxzqUMrr+rbuxmOEiSbXe6fQVrQKX4J1URnxI2ZkWBhtzifStwZ
 HUmQ4CfttDIiviyObwV5a461sjarGoNKceQxpmE5hH40YyYy4JVSNZn0edfGDyHn59HdyZk
 M3Zg4oT/EKNgfDOLH6162uBODjvEs08=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778520633; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TN2D6slwp5X7LjMGq0V/IX7ANpmpnZ8EogZBePRqEnc=;
 b=uixP9fHLbtWGHz2Up0ZDBkdRODT63PapoRDQeEN71pRKNLEeTNfv0sbrtSb0iAHvTBI2O
 yT8W2bNYjmQzxAV8M/GsNk87J/tB8an1G16XJe14kfi79PpqUZvdvNYmE0GFBcKmhULWIz8
 jea6ZRroXUFHjyX9lOUWl6pm5G0k+RE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 94C2581A04
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 19:30:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778520609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TN2D6slwp5X7LjMGq0V/IX7ANpmpnZ8EogZBePRqEnc=;
	b=O1xucaSwhXYv164aS5BnkW58r5rM0gxk2OWXeHBwhrWS5qRMsW/fsY8d8ITANHrdkfl4aL
	+72WwX6W07pxeihyki5saII3OpGGVeXduPLiwFo2IXteKvZ+rHXElRfAclcVj7PmcpiSpX
	nYR1QNEwLa0KX1iOH53oJt/QMAT117M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Zeu3A5wD;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778520609;
	b=03kL9FhteigRdhXnlTvSI5RUfNC9Ffdf+/RjEjlZooghxQUxltJaQWoeg2DVHixw80KkDR
	CS35LBtV48AzFUh5t+VH8agnBhSFFAbQoFoyT9ReqklgC2FTHz+7cOZF/CcXzbmQQp/fIS
	X9y2V3tvWngPIiDD9e5a9OE2u9LYCO4=
Received: by dvalin.narfation.org (Postfix) id 716241FFD9;
	Mon, 11 May 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778520607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TN2D6slwp5X7LjMGq0V/IX7ANpmpnZ8EogZBePRqEnc=;
	b=Zeu3A5wDIrGumZmzNA+79PFeQ/QQV7r/zVeFeo0Qi3olr1D9gqroYWbTeNs3FEL5aEakkF
	JMn90CGSXrZaJfePm9EMgVtw4zqsAJ/fv/WCjbmnZ/vU4dmFyvBBPQCxUlYCKCKe1LATdn
	C/8BQImKmj5R5rK/6Ha6TJWx6i3P0uE=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/5] batman-adv: collected fixes (Yuan Tan)
Date: Mon, 11 May 2026 19:29:58 +0200
Message-Id: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYSAmoC/yWMwQqDMBBEf0Xm3EAaMNT+Sulho6vdHtKSTcQi/
 nujnoY3w5sVyklYcW9WJJ5F5RMrXC8N+hfFiY0MleGs87a1nfkVipmi7W4mlGmUhdWMHLxvnds
 T1fwmPoYqPhAo0zDjefZawpv7vF9i2/7WHdMHfwAAAA==
X-Change-ID: 20260509-yuantan098-bugfixes-feb66522feb6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=sven@narfation.org;
 h=from:subject:message-id; bh=X8ENKPgRj/dS8Z4iE/j3GV2w54BCcOdyzpZmtfU4ml0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMQlI347eG/Kx4G3Zh1oS7nO3O4vqft2u2X79xd8lm+
 wVS7i/mdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0h7PyNCzZdaclAm3wngC
 rKtL3q/S+XJ32YE81oOOfL+0BEz515ozMvw1cHke9X9ijapitlOgZnjUlELp3hlbDRhf7NmdLPP
 AjBkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3MQWNEMH3O2KRG7FEJEC2VCDMEZH2MR5
X-Message-ID-Hash: 3MQWNEMH3O2KRG7FEJEC2VCDMEZH2MR5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3MQWNEMH3O2KRG7FEJEC2VCDMEZH2MR5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I was contacted by Yuan Tan regarding some of the problems which were found
by them. I've proposed to go through the list and prepare changes for
things which looked sensible. I've also prepared some PoC patches (lets
call it part2) - just so Antonio+Simon+Marek can discuss about them
internally.

The ones which don't need further discussion are shown in this patchset.
For the others, I am waiting on the results of the internal discussion.

It is more than likely that there will be updates to these patches because
the team around Yuan Tan need to verify that these are actually working.

Thanks to Yuan Tan, Yifan Wu, Juefei Pu, Xin Liu and all the other people
involved in finding + fixing these bugs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (5):
      batman-adv: dat: handle forward allocation error
      batman-adv: tp_meter: avoid use of uninit sender vars in recv_ack
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: v: stop OGMv2 on disabled interface

 net/batman-adv/bat_v_ogm.c             | 11 +++++++----
 net/batman-adv/distributed-arp-table.c |  3 +++
 net/batman-adv/fragmentation.c         | 35 ++++++++++++++++++++++++++++++++++
 net/batman-adv/tp_meter.c              |  3 +++
 net/batman-adv/tvlv.c                  |  9 ++++++---
 5 files changed, 54 insertions(+), 7 deletions(-)
---
base-commit: 8d059d119c8c368d12be617f54c9473beca2fb66
change-id: 20260509-yuantan098-bugfixes-feb66522feb6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

