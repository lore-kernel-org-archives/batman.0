Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC347C3ABCB
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 08:38:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3706184ADE
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 10:38:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746866330;
 b=z7knH1udhFbAY08cpj552GwT+oeovdwhm4DZJwtboce6SzrUs3s/BpldnI4s/Omb08OWs
 Y1tjjWR3FinE/V8l2XGpIHAS1Co61tmmEBAhbGVrQQjaHrxR0AGfIAPnjSZ3WUaN8OmRLMo
 pvdxSo7h3piVodkIe69sZdejfxmJOgk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746866330; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KXlnFH0TGqGQmK9MGm0Bn6n3pRojpRMhl3aIrIOl+gc=;
 b=KzcMSj1uiMlxSxdPxThsyD48fmovTacpO8Q+lnfRewaGFZiHYEEkbdLUn8W2AnmFx/5U3
 SQ+doZnrX6e+i4iNVv0HrjFvJz3AtSbnpkHY6Sxzx9VXca0tSC7YB2GoA3BsdExL3HgePLk
 oanvbYTOWmves/WxcZvqkmQPBW7pg4s=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2AB3284AB6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 May 2025 10:38:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746866308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KXlnFH0TGqGQmK9MGm0Bn6n3pRojpRMhl3aIrIOl+gc=;
	b=pK6VVmvtkACOkRJEI3D4gXkyvEqdxukij7xdlvr0S70XSmHEdzulD8Z6iu9qmiQhfVryGV
	EOQpGBWq5saAcXpVjUaQ1nHTrWosP2xOBrYod1xtqmE6klncHaipdEWDtv5tuWEg/3DX8V
	AQO6766ex1fSiXc/4SPeKRxQ97S5H80=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746866308; a=rsa-sha256;
	cv=none;
	b=wWkFyNxOaRAdoZCEe4NGkkpDrFd0VzpwpI2tFBL0f/vXsBjXI4/NzoU0mFYTZdt+0wR/jj
	QhtFmf302sWcUWadv7YlSHI2voPV5xmvi/f06TcoXmPwyYJW1gjIJ0yfhtCOxNjzVA8yvO
	M253gZdHUc4P0nE8D7VUm6tFDZaD8l8=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6BEE754DF32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 May 2025 10:38:27 +0200 (CEST)
Date: Sat, 10 May 2025 10:38:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Fwd: [WLANtalk] Wireless Community Weekend from 30.5.-1.6.2025 in
 Berlin
Message-ID: <aB8QgsJmsiYI0P7M@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: W7A3F7572CAZFUTWNRXVPIIUHWX4SVGD
X-Message-ID-Hash: W7A3F7572CAZFUTWNRXVPIIUHWX4SVGD
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W7A3F7572CAZFUTWNRXVPIIUHWX4SVGD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

----- Forwarded message from Andreas Bräu via WLANtalk <wlantalk@freifunk.net> -----

Date: Sat, 22 Feb 2025 22:42:59 +0100
From: Andreas Bräu via WLANtalk <wlantalk@freifunk.net>
To: Deutschlandweite Liste für WLAN Layer 8 = Diskussion und Austausch <wlantalk@freifunk.net>
Cc: Andreas Bräu <ab@andi95.de>
Subject: [WLANtalk] Wireless Community Weekend from 30.5.-1.6.2025 in Berlin

Hello everyone,

the next Wireless Community Weekend (WCW) will take place in Berlin from May 30 to June 1, 2025! 🎉

The WCW is the big meeting of Freifunk communities from all over Germany and wireless network communities from all over the world. It's all about exchanging ideas about free networks, mesh technologies, community projects and everything that connects us - technically and socially.

📍 Location: c-base, Rungestr. 20, 10179 Berlin
📅 Date: May 30 - June 1, 2025
💬 Topics: Network technology, infrastructure, community organization, politics, exciting projects, BBQ and more!

Whether you're a long-time community member or a newcomer - everyone is welcome! There will be sessions, workshops and plenty of opportunities to hack, discuss and network. 


You can find the most important information and pages here: 

ℹ️ General info: https://wiki.freifunk.net/Wireless_Community_Weekend_2025
📝 Registration: https://wiki.freifunk.net/Wireless_Community_Weekend_2025:Participants
💡 Suggested topics: https://wiki.freifunk.net/Wireless_Community_Weekend_2025:Topics
🛏️ Accommodation: https://wiki.freifunk.net/Wireless_Community_Weekend_2025:Endorsements



We look forward to seeing you!



Best regards,



cven and Andi

ps: the WCW happens about 10 days before this year’s battle mesh v17 in Sundhausen, Germany!






_______________________________________________
WLANtalk mailing list
WLANtalk@freifunk.net
Abonnement abbestellen? -> https://lists.freifunk.net/mailman/listinfo/wlantalk-freifunk.net

Weitere Infos zu den freifunk.net Mailinglisten und zur An- und Abmeldung unter http://freifunk.net/mailinglisten


----- End forwarded message -----
