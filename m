Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC81D3F2A6
	for <batman@archiver.kernel.org>; Fri, 18 Oct 2024 21:47:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B8EF0830A5
	for <batman@archiver.kernel.org>; Fri, 18 Oct 2024 23:47:26 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729288046;
 b=cqEIqCNBXfI941zZX2ii8Dj9fEtAqS5kSBTbz71lNcNpcz1IU+z/OynKYI1uxiH8yrui5
 UP20bZJyyJmuCLiCuDu9A747xWwb31b4Usfnqsj0ufGeqUyVnyjkHxAwSW9z64cUhmMj4pV
 KzmU68i4C84xeETRmB6Dfd7pW/d3F0E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729288046; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dd1+3ptssi776oiTk7rLFxBQxpwthtCCh5gHwxSZMSw=;
 b=JaL7luPoo/9mroA2IgGs0kjJe05bcVtY4up+zmAwbcwc08AhmrP8W79zfzXpzoUUcK2UU
 6YML457lV3AzjYdx/BHGL/vA2JrFGz8eMs9AcUaFfW0jgD5bYKjZSgHyuEfKKt7nQVJF0Rd
 zQXvOU2MjAbv0BhDVaapxri0oG3daYo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 962AA8165A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 18 Oct 2024 23:47:22 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1729288043; a=rsa-sha256;
	cv=none;
	b=O+PSLYw4izWSmbojhjkVYz239ibm5DMArgBTZg6b00GZu1xV6IPNEwVVNr5ZoRYg0ILHBA
	GP+9S6arYaEc9yBlo7pCe9ZnhdXOFGT3VqEDaRxz+VC2YPK+p2fH2fnEZRZAMEupGPLcij
	e7/xV7hLC/EbXBuDHhmIUWiavlWAJsw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=UHMu2PB0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::b34 as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1729288043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dd1+3ptssi776oiTk7rLFxBQxpwthtCCh5gHwxSZMSw=;
	b=MPHcyr1aOlP7mipWRRXUyAf/FoJAfu4uV0L1QGKRZaYrjuZrZJ5G7YKC3g+82aYGKayAl4
	wH+LLSOgd6NVXWGVLvdkCWLqpHRLmXz/kdAQivivKs/wsUwZcQjn2rdVOtpaNp8b+VnZIf
	f8byOc+gDSuPxlUbldPS3BrWGs9XOO0=
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e297c8f8c86so2603879276.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 18 Oct 2024 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729288040; x=1729892840;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dd1+3ptssi776oiTk7rLFxBQxpwthtCCh5gHwxSZMSw=;
        b=UHMu2PB0KTMpR/QiUVhzmNxXdI1ZHOGVsyWrq3iJvCCpj1KQVZzASIFMdLpaoVZDtc
         Q9odpGT+OUy48mtZR6q74Xnvb860Aozi2jz4s6VJoa641SiPVm4LyseVZT1JDw1uT+l2
         WVxH0SbPR+mbPpsg7YvFc4OQyvD5lPcH0xM9c1kMFH2h/vAhtbBpLbdUOiW/JbFvcBXW
         f1G5bxKXZe+ApvupdVHK1iZa1K1e98Vf7Gwa7Dftn1tN8iniaj6PC+sct0kW+NFvtsU5
         xWnR/G7W07YftGBH7mx6UH34UCAFJetqAoGGM28S3NGVpEOujdvpIbG+lXvczx5H1I1P
         nPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288040; x=1729892840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dd1+3ptssi776oiTk7rLFxBQxpwthtCCh5gHwxSZMSw=;
        b=Lq/SS7ju/5URbeCwjcpmoJjOwfCyOdCTr05Z0ciz3R07Wbghmd2olzD0uLlmtMEac+
         zmpwPXPB71N/QdUKlZgReOEZlbZLoV6yjx85n8PZbpnD9qc8lGNbvDV9O20QF2OE/gmB
         AMuv9+nnhMU8Kv5p8R/UsyYbheXU2PEpfoSb46wQLP24OYQLYWTxV6H+Qi2vNIt2Luux
         DhLHFutMQZKQvFGBAi9dMdgTZwFSl44lVDtl+X/TBdHsfAu68Iu5j+pZOysCdu3hTYJI
         f3c3wl9vLTymvjk7756f9po117by/5YM5ntn+80QRugIE8SaF93faDiC2zVdLAURkihR
         dytw==
X-Gm-Message-State: AOJu0YxuYuYtqjI0fHwN/HewEwLMO0eSj5MCahxV3y8Ga5n3R1yP2phN
	LfGBIqeeGoF+t8ghPzI680bTh3Hz2mugmLUQD+caK6apcfwlg89tk7r7oG7WN5k=
X-Google-Smtp-Source: 
 AGHT+IEar+7qzlDxH7gc4Eyom5Pb4qZlLEwLvn3cQQSjET7ii334MAK8kHE9VDREf2DLffEeLSJoVQ==
X-Received: by 2002:a05:6902:2743:b0:e29:7453:f1cd with SMTP id
 3f1490d57ef6-e2bb168d2b8mr4110595276.37.1729288040413;
        Fri, 18 Oct 2024 14:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2800:860:71ac:7d8e:75c1:2f63:585:5dac])
        by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e2bc8e28380sm107773276.28.2024.10.18.14.47.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Oct 2024 14:47:19 -0700 (PDT)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson <NoahBPeterson1997@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: [PATCH 0/1] batctl: ping: Add millisecond precision to ping interval
Date: Fri, 18 Oct 2024 15:47:12 -0600
Message-Id: <20241018214713.91598-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YZFXLDCRF7S6K77N4ULYNZPNN4PDN7IL
X-Message-ID-Hash: YZFXLDCRF7S6K77N4ULYNZPNN4PDN7IL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YZFXLDCRF7S6K77N4ULYNZPNN4PDN7IL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There is a minor issue with using the new `nanosleep()` function: When
compiling with the `sys/time.h` header instead of `time.h`, a warning is
thrown about `nanosleep()` being implicitly declared when it is called on
line 309. This can be fixed by adding the `nanosleep()` prototype to ping.c,
but this triggers the warning "externs should be avoided in .c files" from
`checkpatch.pl`. Is there a third and better option, or should it be left
as-is?

Noah Peterson (1):
  batctl: ping: Add millisecond precision to ping interval

 ping.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
2.39.5 (Apple Git-154)

