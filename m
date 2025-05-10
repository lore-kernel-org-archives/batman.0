Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC17C3ABCB
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 08:38:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F68684A1A
	for <batman-adv@archiver.kernel.org>; Sat, 10 May 2025 10:38:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746866284;
 b=PTtHEh3/4rV03Rn2jbF7GyO5SOYqAeYzrQ/nWmfs4TbGsjI++NMLGmP7TfHpo+iw19zuJ
 LTuD95E4APSKV0zVy/CFz9ZSzrfk3OYmytEu408Y2U+yvuEDv5oP/J1BHQKSTIF6M9pWBQf
 aMnYja0taxB8u99dtF5ZYbTazma3ppA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746866284; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/2Uy6pixP/6jbU9mTIug5m1HbpqijOqKQN653kuTLy0=;
 b=fyvB7vmvf6QIJPYJae3l7Z9aU25foLP4qGHhq44pVB8cTtNWLPRdURvdfQIZWM8N16y67
 qcBLnrOZyqVtpjDFQYoXlFB7T19wHbFdTDUkM1uVY4/s8nSrfSxBvKcjy8GX6QeOUGxenNB
 tYdunA/715q+pU2sXx/2yOcWxmgX1L0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D9E8284622
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 May 2025 10:37:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746866275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/2Uy6pixP/6jbU9mTIug5m1HbpqijOqKQN653kuTLy0=;
	b=cv8Y522lGSghk8OIrt17wR9reE/8ttmgbQ5H83sKx0g6zLx1HWDpft3RKyynNzo9l3QPfa
	A9mCWI0DWKhipd7+u6pnMaV/JDlAUNAn18y7M0+e2mtHsWWR4Hm36aLVcMDKoFrcupdIBH
	xmIHbwgk7IEgfb/iEBm5lsAy6awaYzI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746866275; a=rsa-sha256;
	cv=none;
	b=vF8a6iZl56eU10f7O2hdQajauqwO8MMI/h1C1r8zBRFxIMC0FTX1D5dWIdPveemvDEMUR+
	ucHAX0dFxTuUP8zwrFnZx3sGj+Uh8UmFWQO9knr9zKI4K74MViCnuYXbnFuzONsDbeBYgg
	aQSTNK6UDgz8biZt4bY5gDXZgtr2CGw=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9930754DF32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 10 May 2025 10:37:43 +0200 (CEST)
Date: Sat, 10 May 2025 10:37:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Fwd: [Battlemesh] BattleMesh =?utf-8?Q?v17?=
 =?utf-8?B?IE9mZmljaWFsIEFubm91bmNlbWVudCDigJMgMTDigJMx?= =?utf-8?Q?6?= June
 2025, Sundhausen, Thuringia, Germany
Message-ID: <aB8QVcM1ZCmgLnoU@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: ZL5ESTIEQFB2VQ5ILPVASJN5NHEG4OV5
X-Message-ID-Hash: ZL5ESTIEQFB2VQ5ILPVASJN5NHEG4OV5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZL5ESTIEQFB2VQ5ILPVASJN5NHEG4OV5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

----- Forwarded message from Andreas Bräu via Battlemesh <battlemesh@ml.ninux.org> -----

Date: Thu, 06 Mar 2025 22:15:50 +0100
From: Andreas Bräu via Battlemesh <battlemesh@ml.ninux.org>
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: Andreas Bräu <ab@andi95.de>
Subject: [Battlemesh] BattleMesh v17 Official Announcement – 10–16 June 2025, Sundhausen, Thuringia, Germany

Hello everyone,

We are excited to announce the 17th edition of the Wireless Battle of
the Mesh! This event aims to further the discussion on the right to
connectivity, community-owned infrastructure, and related free open
source projects.

Event Details:
Date: 10–16 June 2025 (7 days)
Venue: Sundhausen, Thuringia, Germany (51°09'25.1"N 10°43'00.7"E)
Cost: Free and open to everyone

In addition, the co-hosted OpenWrt Summit will be held from 13–15 June
2025.

Registration:

Please add yourself to the participants list here:
https://www.battlemesh.org/BattleMeshV17/Participants
If you’d prefer not to have your name displayed publicly, kindly email
the organisation team (battlemeshv17-orga@freifunk.net) with the same
details.

Accommodation Options:

* Camping: Self-organized, free of charge
* Apartments: Contact the organisation team (very limited, charges
apply)
* More details: https://battlemesh.org/BattleMeshV17/Accomodation

Visa & Travel Support:
The University of Nordhausen offers visa invitation letters. Please
reach out to the organisation team with your details if needed.
Travel support may be available on a case-by-case basis — simply email
the team with your background.

Additional Information:
Directions: https://battlemesh.org/BattleMeshV17/Directions
Workshop/Session Ideas (CfP): https://battlemesh.org/BattleMeshV17/CfP
More about the event: https://www.battlemesh.org/BattleMeshV17

Please help us spread the word by sharing this announcement.

Best regards,

Bluse and Andi
Battlemesh Organisation Team



_______________________________________________
Battlemesh mailing list
Battlemesh@ml.ninux.org
https://ml.ninux.org/mailman/listinfo/battlemesh


----- End forwarded message -----
