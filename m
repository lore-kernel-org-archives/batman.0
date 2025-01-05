Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3DE77188
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 00:09:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D6DBA840C7
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 01:09:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736035772;
 b=ET2mGkSFLBCOkn6yO/Xx4kxc9GmRkbk2ALU5vKe+WzPZ0JshHE0ABCNBpioCmdJV4r0hn
 NhDQ0JcrrkE1/jT+cFb9l7tL5J0ScxzBDUgrV6Ac8N/qijAB28FOA6DayqftPhIxHIyW9+I
 YeJve/azeH/TcLXSmKBFDHJQ/KroHY8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736035772; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=C/hK32fihwLCHI7FIwbqhnKhKk9Rczu96fb+mdZ6d+0=;
 b=WLLBAuhBXDWXDxeBVcJ6H2GiaBTiS8l/1NJ7EKp5hB8VfdkCkYC80xnDFGPN0LkxaCmV3
 8+pDH9pNIOZCAjUB8GqGQ5fntUxrVac3JARZnpFPDQGF1rQXYXDLkafexu4tlrtq52bkzG5
 F5rEZDSsBo6TZn2d5czU1Y6/bz8nSB4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6B3F381DCF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  5 Jan 2025 01:09:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736035757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=C/hK32fihwLCHI7FIwbqhnKhKk9Rczu96fb+mdZ6d+0=;
	b=NLUpeZDqWsrPe8J0zdXFfaDPZkYbLZIUqAnmqhbXYA1WLCfVl8qqweWfPemW0656TKA3dF
	5EwN8WGusBftlVcNWTD8DP9gixu9WF3NahLm3kwnu5ntuMMvk5LIqyZewxQfFuvJUrw2yU
	sxGW0FHb7Abz1L8Aj3NSX+g9AnVzW9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=KiOlQEmn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::e2f as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736035757; a=rsa-sha256;
	cv=none;
	b=MwcClGAe717DHdbyZongKOhNHTxpwpx1I9ebmjQBmFPmZChRshCMe/UewUusLt4KEZBLST
	AM2OxJ3qbw0CzPiqH2z7KA90msEXqh+qAhDngCPH0yYgw6LiGnC/2t5hfQJDw/kW12cFPz
	Yx/NwsbNh2Tbml76if/gecBGi5OPY4Q=
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afecb2731dso3577056137.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 16:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736035756; x=1736640556;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/hK32fihwLCHI7FIwbqhnKhKk9Rczu96fb+mdZ6d+0=;
        b=KiOlQEmndNitR1Mypqhk7dtRLSZSg6erbxL7venaX5KdISJ5I2eKqtbMead2i4azLh
         6yU6uqTXMbxW7Q4ecf7InKbAQU/sYcdfY6oFjEk0m0R+mVEy6mYwa+pZaALnGsQAlXrh
         lDbj9GL6hidIwRmoXgjm4Snj2jaSwe8pXUMqNZ0cmFihpwk6IS2YlGgde7TjlFOKDngW
         AFaXiybR6rEIqePRSrO1/pjbHqDS0ZFHRRth9YSJ4DLtXA1YOpQpPYAQihinGuf7azJk
         0Sj0swMFjWPG0QHkFyVQt7gCcYOpseOatodeIrIqRpKCYpOSbge5nQqIi/o8p1c4rrlO
         h9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736035756; x=1736640556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/hK32fihwLCHI7FIwbqhnKhKk9Rczu96fb+mdZ6d+0=;
        b=sgsxLCvgdVTfdbuoCg+JiCCUL458VD53pCjJg3GHyDVfQ5wBMZdwdR3wOb2rqxik2N
         sQdvF5Dq4e0ENilnUKyshbL3Ve8hyraLg6zFiIXAM9JQzy2xO8fNInPycKzKKONdM0UL
         CL6oxIVsjGKxmDDlxWcE80v8f7nM0e3//pKEbU1Q+xZigQ5mep37fISjKkezTyZ9Htf5
         c0B8VUy35sXBBxw8srQl5+7p8Jxrp2FeJ8PBucH6exGgbQOyHYVg+9ufsImo6SORmHM/
         1SMAx4cTPzl7iQQg5TOMcWUJyHhsYPJlDSWvw3sgujGRmyhH5uvQ3i7UULcIh33QGpDY
         rMpA==
X-Gm-Message-State: AOJu0YwkUBUnvULuGoJeay79l9AAbtM7tDsObL0aLjVAfCxUMRn4cZgA
	/Ou2V7xUsbIjpNLH2IHmx7vnXMVqTKcV+7VX3IZf32j6N/KZlfWjbo17/GNO
X-Gm-Gg: ASbGncsoS7xJ/X1SYzAx9wATuEP3eXLFEOVWU/W36/Ez4mhmVApzBhs6mF9B0fkMABp
	sYCOD2Q53PKiSkI78k/VW8dAqdjGblFsUVrCs3JF/IfrhEPli5eKFxcEvGfts72Pgezy9HLxp8J
	22InYaNZKgF/419Cn4BdCO3bkgmlb+j9QQ56rm03AbtYww42neuuZ3Xyth+b2LYixopPgvrYaq/
	6e7ZJGgiqWjpTwA3lbtk5Yr40umHFZfAi6gaIMyhzB5dsjQ8ifxPIAWvhPSM6edYNEkXO9hqZsF
	acNfz6KKtB+NuqRotw==
X-Google-Smtp-Source: 
 AGHT+IGjU2codNmdPUC3XKXVtJJtkLtVerntMkCPXJmozgU98/r8QuC9cGgq/RswEvtBVDM1xlcnQg==
X-Received: by 2002:a05:6102:1629:b0:4b2:5d16:f75 with SMTP id
 ada2fe7eead31-4b2cc31c5e0mr37637167137.4.1736035755703;
        Sat, 04 Jan 2025 16:09:15 -0800 (PST)
Received: from localhost.localdomain ([190.113.102.112])
        by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8610ac1d4bbsm6365126241.2.2025.01.04.16.09.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jan 2025 16:09:14 -0800 (PST)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: [PATCH v5 0/1] batctl: ping: Add subsecond precision to ping interval
Date: Sat,  4 Jan 2025 18:09:07 -0600
Message-Id: <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MVFWRDMI6M2PV36H3M7JI6NJN2VMZGCM
X-Message-ID-Hash: MVFWRDMI6M2PV36H3M7JI6NJN2VMZGCM
X-MailFrom: noahbpeterson1997@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MVFWRDMI6M2PV36H3M7JI6NJN2VMZGCM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Apologies for the prior errors. My text editor was showing all differences
except for the added whitespace. I also failed to compile and test the code,
but this version has been tested, and I can confirm it both compiles and runs
as expected.

Noah Peterson (1):
  batctl: ping: Add subsecond precision to ping interval

 ping.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.39.5 (Apple Git-154)

