Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64FFEEAA75
	for <batman-adv@archiver.kernel.org>; Fri, 15 Sep 2023 14:36:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D8C9F832AB
	for <batman-adv@archiver.kernel.org>; Fri, 15 Sep 2023 16:36:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694788606;
 b=tkS4KZcUcWfSka3VfEu0WixGZAnxQlJv4tMtO9CkLa0LuPkLLLN67Vm5/SXEVM969MXiu
 dCvLmCFiFfooYQWZIwtMFacE9QuAc/NF2RYeFm8GYUn5VrfZ19ZqN2LrnMOQd1+Bu9UiMth
 ah73mcBFkvvbZgx0t7xrtc/Mpn/JpIU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694788606; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7mRDv9DZrZWBaMwkiJu68PEfJIpeuMcXO9I8vSqvp9g=;
 b=CLgRkxwuUfGvtXkastOVEuFI3qwqfcdMyx+L0LajytWcviv6tsdzhubjectERfpU50n6O
 PPp8U1aMDdND6ydn/dxJC52oG/rWcECPCeErJR6Eyfl7Bahjr4qqtLWMbKRJ7NjL1Jf38Da
 2AyVj2zyN2ckKAD509qp8Y4qSwQYtiA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F310F80BD3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Sep 2023 16:11:56 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694787117; a=rsa-sha256;
	cv=none;
	b=JXP9SvLyT4eSEleq510iMnYRq/VJbvfsCSrK7hy/WAy3W9rz3TnJHtwZK+t8e+Qg465YEp
	/CUTM22V9Ni2/QYcdcxCwk3Fk+tdG1InSCxzPTdtcbcw4X9MPSNFANOMgNId5byWQNHhO1
	6kRg5VAyQ+fUAChfbK9lGXb9IratQl4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Sb56EzmZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of obiwac@gmail.com designates
 2a00:1450:4864:20::62a as permitted sender) smtp.mailfrom=obiwac@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694787117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7mRDv9DZrZWBaMwkiJu68PEfJIpeuMcXO9I8vSqvp9g=;
	b=3irMLBS8v6FtHavenbGkYFWbV8b3ya8lnIgfgHuClBC0sZ7Q+NXIZkDhPjUZvk9t17Khvh
	G2GQDYnWVsoNdw3FslmF7TPUtcMT3MshUFJd166lbZun2OSKwgVmyM8VbRu01h9IFcJUgn
	tMhve16CvGG5jg/JUdm8vMFdbzBLjoE=
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso275364166b.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 15 Sep 2023 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694787116; x=1695391916;
 darn=lists.open-mesh.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mRDv9DZrZWBaMwkiJu68PEfJIpeuMcXO9I8vSqvp9g=;
        b=Sb56EzmZfEmEhqKN5F1zcfXsXAL776sIwZK7+4d8WF/HldBLKyscAdv9sQNP5lVfYb
         6lMXAm+/wq3BVSo2AK30qDoX6AjJUpaM/98qzpK99e1OJiH9rosCFvOLWkiJv9wghECp
         xUFnt/ilwqPV8TeRoqNqwPIYXlou+iEKeu1BbAqoq6xhmK9A+cBWE6uYk2AZfjxu1bJd
         bp/gj8FlrqLSsNNyKh2ALXpHcVotEPfnGxU+Xq45T/3R0tN5QCCndZXKQR0dmzCLEfoC
         zlu96ud7JPqLt5iBW189srFryXAk3Bcck4qeJmtG9bMZ4A906Alnh/IKxoVhnHPcy2DX
         zK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787116; x=1695391916;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mRDv9DZrZWBaMwkiJu68PEfJIpeuMcXO9I8vSqvp9g=;
        b=YvfkhfLGcqu515lEGw3WipM4ZopffelyyPav340q3MwvPJT7Yt/rHES25PARFvnuIB
         IxoCDDc03+cQj78VgzsmeDzosJgxZ9Eh3MM9tKBUBwsIvDBwglKHdU36CAuccPXvZr3D
         iRktASEp0L456oG+hFkB+zQj71I8rt+bmg1q/c0+1DP0oU/8ia48TzMG9aF6zCoSOXDS
         97p+m9WwqD4K8tonPf+z7ArrP5NKopyhxAojMoWX7Pt8zhY3brgKIx6gRIsboAihicYh
         VPkifuc4BzQ/ALspvbLWzLdgQzpEzCbs31oqEBaxru9ENi0Q1l6UCADZ3rNUJ+GqGJru
         wXvA==
X-Gm-Message-State: AOJu0YwSEnzwoDb7hSUTqE/I6ibC1Qa4CKYjTvVxWWDE9g/JWHSipFhS
	m8XhvoZwjDh+C++oFSo9/btPh/cQYFoevUeWYjXSdWMecqpY95c5
X-Google-Smtp-Source: 
 AGHT+IEu2ksqR2S7ls1t/CaO4Luj+Wlz0Bk08KN4IevJHSdt6RFntzYj6I9IOBq0Ir+Who08dXzgtT6TnNV/0qAqrZk=
X-Received: by 2002:a17:907:1ddd:b0:9a5:d095:a8e4 with SMTP id
 og29-20020a1709071ddd00b009a5d095a8e4mr1393917ejc.1.1694787115952; Fri, 15
 Sep 2023 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAN8-kNUktsXSTnG2jA51h3piRxf8-a-JJBGtPF8uJdEWXspm1w@mail.gmail.com>
In-Reply-To: 
 <CAN8-kNUktsXSTnG2jA51h3piRxf8-a-JJBGtPF8uJdEWXspm1w@mail.gmail.com>
From: obiwac <obiwac@gmail.com>
Date: Fri, 15 Sep 2023 16:11:44 +0200
Message-ID: 
 <CAN8-kNWFXhFzeu0fcKg115VHHj_qLoL-GEroBRqSroHY65EMSw@mail.gmail.com>
Subject: Fwd: Possibility of dual-licensing to ease bringing into FreeBSD
To: b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: obiwac@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: B4PJEY5AFAIUNWDLSXLJ6DBA6FFJ3M2W
X-Message-ID-Hash: B4PJEY5AFAIUNWDLSXLJ6DBA6FFJ3M2W
X-Mailman-Approved-At: Fri, 15 Sep 2023 16:36:34 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B4PJEY5AFAIUNWDLSXLJ6DBA6FFJ3M2W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

---------- Forwarded message ---------
From: obiwac <obiwac@gmail.com>
Date: Fri, 15 Sept 2023 at 16:10
Subject: Possibility of dual-licensing to ease bringing into FreeBSD
To: mmokhi@FreeBSD.org <mmokhi@freebsd.org>, <imp@freebsd.org>,
<jhb@freebsd.org>


Hia,

I recently ported batman-adv to FreeBSD as my GSoC project:

https://wiki.freebsd.org/SummerOfCode2023Projects/CallingTheBatmanFreeNetworksOnFreeBSD

I'd like to bring this work into the FreeBSD source tree, but they are
reluctant to bring in any new GPL code. Would it be possible to
dual-license batman-adv to GPL/BSD, or would you rather not (in which
case I'll ask FreeBSD's core@ if an exception could be made for
batman-adv)?

Thanks!
Aymeric
