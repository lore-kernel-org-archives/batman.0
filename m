Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C89CD3424
	for <batman-adv@archiver.kernel.org>; Sun,  3 May 2026 15:37:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C74C85327
	for <batman-adv@archiver.kernel.org>; Sun, 03 May 2026 17:37:05 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777822625;
 b=O1cYEzwGvSojx3yy4CFWvJ2Ob7GuM2em7ZHTXHGFmPn8BT/1X5Eoo75y19EoIOmWG6SSR
 3OD5NygUh9WAxYW5M2HhWfytIr9Kk6UhvPgtB3Z4UXbiRTV0vk3FmtF5RmyXx7OzJ3lI/+i
 w+3tt/z3TVpGM3sjYjh1aTWCzm1Y9UU=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777822625; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vDLg9mJR8DJj1lGEdhxbBO9XQQh+dXvY+RaR7dufCM8=;
 b=x0vxrMHM13QPNY/M8L1eigR5VeFuNv+nvw4glb2cFpnmUEaO1G3eOw/DSLP2poyhOwUzy
 enskPc8j5IyNl0p1Mho9sQTCKGx9QEg/w43SGtYPDjRcH8ENxYxok7sXTwMsr0IXgEZUAX0
 FeI0BkNafHde7MuhcxG4U5ejuaE0Efw=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 889EB81ADF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 17:36:42 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1777822612;
	b=DEDdTxWWHoIVSxKSNtgUWHzd7Dh/E4olRAtnDBAJuJsxDLFjF7D2sDm74FwxEGxIrbuoXP
	OMBEeww5sVeoZQlv0TGq42rxrXnaaUNQaN5Di5Obn6WSvG3d/lH03zrs1NGdZYZ2f9AGNE
	lFsxpIguYpL6R3X0J0wVxcxul4sSVUw=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BFBKcnz7;
	arc=pass ("google.com:s=arc-20240605:i=1");
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of dandenson@gmail.com designates
 2607:f8b0:4864:20::132b as permitted sender)
 smtp.mailfrom=dandenson@gmail.com
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777822612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=vDLg9mJR8DJj1lGEdhxbBO9XQQh+dXvY+RaR7dufCM8=;
	b=GQQB0/J2AWrTfUx7Ce2mGa6UwFTYvYX6bfoRAbfc3rqlDmc0DuO+RT65UBK+hksRaAmKGx
	/I3HO6KbJktERx38oaUpL01Kheyi0Fq5x3vVMR/FvN52VvJBA+4q5CG+paFOGvjt374P2r
	ntOMh7yFb4dN2+bAid2KnM091o3UvlA=
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2d868d014a5so3365887eec.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 03 May 2026 08:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777822600; cv=none;
        d=google.com; s=arc-20240605;
        b=BfvnCXOEPgjVg23yNRaZc49iIjurzoG/TS7PAq2qCFhc9lnZAqLTrCTfj5tlIfq6IX
         mowGX1ts58pwQFo0lka6LGT3Mu3XYIleYKkoSstQRvlAfyCJqV4CIrfdlOfN5GvWdfDU
         xNnk/QdXlNTyOBgqCFYLzn9dOcqXn/1Wc1JMexj4H56gHBpk1UStO4rT7DOmuHq+QlYE
         n7EKzRPjEYDTeGa4GNaen47TlEbJeWVXIkDXT1MLWYpa2skx6Xa4S/k5WKEyYRPJoBN5
         tXpZFiHzMbiNIuP526OqasaUIz8V2rfM3qnbbAXg9YNflY5abwIv0J5V+tBwSGkb4XNn
         qEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vDLg9mJR8DJj1lGEdhxbBO9XQQh+dXvY+RaR7dufCM8=;
        fh=bVam433rSKvSo7L5GFV19dGjUy2F8mqDVA2tadGCpPE=;
        b=Cz92FJAdzLQ6ICmrSVYHioWC8OcJqos1e/kn1iLXizXJrbjbtKhVhLKmqszIrQvMKo
         2J8jvuln/QmmWdaYg4QpMRSfKyO43iYc1eAmnv+R+LYLrqjtShLV7MDi2qqoogPYbeOU
         y2CIyAVVE9dwQaGabgfOyDZUyLKtxrtZ7jSvclXxlQmPGuSC0SM5CuHkPvi6tbCuFdxp
         u3KEOgQXOOYQjA916QvsZh+E7auxUTJ92R4XJD7bnkH/DHYgQNy2aHQ+6McMVszYsm98
         GxTT3jujlI6IDk/83il1OtoshNmnwi2zOatQxjzaj90pPr0LE7ZHls+3Z4YHKoEsHeOs
         ivOA==;
        darn=lists.open-mesh.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822600; x=1778427400;
 darn=lists.open-mesh.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDLg9mJR8DJj1lGEdhxbBO9XQQh+dXvY+RaR7dufCM8=;
        b=BFBKcnz7laJ9EGAXh+byz2xb66gRH8+Ihj1c142Hgb1yzTYPinGlBTk1k3XNsMXepJ
         xOz00eOmD3jnziUchSSOGsVXDDSnzYoHPohAY8wbBvKly7dN6z3nClacPVbJejkxQLZo
         6kU8R9Sz5htuXLYRLweKNNsvysDGxK0WPvwCarUOoDvKBbQzNHVruMhQW+9xh5TfqeBY
         +hZeX+MFut44LDf7OsWjQvhQ2x3bW8kyAb11shUoX8Ij4U1I/jzwhIngrGNAAtOmU1Tf
         lCkCoq6f+RFlmazUArP7oWDrSYxGUt0hWKyRmuD9MrHtxkOraKEHXcQe7ztpCAN2fsZ6
         RnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822600; x=1778427400;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDLg9mJR8DJj1lGEdhxbBO9XQQh+dXvY+RaR7dufCM8=;
        b=L3oCHa2NJnYX3ePGw4bt7edYy81hscLevM5P4LGmkjJzg93lAljtN4eAijr4oZHdl9
         OiAfqtg2/8gSsRMeZU5c4hkrfu5iUIBKzalboaDxwqe58RdkbzGK21idGIa/g94vW1zP
         5pvxoIRAmYb8H1MsGzFtRCQnxz0wf3euIkf+q5fLvRrJ4M8fVdgwhMPgyfqteM1MRlDn
         sNqEX/ZQYj3fDlrrNXpKGJUxcgmJc0uY+Uf5Qhc9GTY6eVeKYTvRRJyLlt4sXpUYbW9s
         OTXxRvh75gMSSUkt0p3l2BkukgsyrpXfacv44vpbKs5XxEvvvoty1TRDmHzGPQju7yRA
         8vAA==
X-Gm-Message-State: AOJu0YxFy2mlBo9pKbVk3k9k9bks6caGa3bwB7SvkGshEjSMYfD5kMkp
	KdC8GThk0o3EAWX0HBQ+YluA4URXizrWZsgqwX/E3H0NiRZ0OdD9U8Wv2decpn0gZkXymA0yomy
	qhWGOsZIfbbuzmfANULSywWBSj7k+2UjF7e6z
X-Gm-Gg: AeBDietKpsXKvCZ7oxkxVGkJdjfoPmIqLyN1YP1XIIG2+gmn8xSczHZ9qG7ppxOT8GB
	ObQyHt4evUBBSNPgynvyN8uNF1N8rR9GmZ2lKISBU8wStPGS/eY/vuBxdz2dEobw1g34NPbWN/9
	2IjPh2ulCMpMoKp9udVIbKpHTKerSw6qTvYApeO39XYHTlZY2HdYVQ757YgdU1tNUtjfkQYdqkp
	AREb2UBLPKQBnrqOoQllDwtjB43NTssARlfPJyb+SNEAj9w283p+HibMSKWKGRcUD5fmUR/tIb/
	Pa+XzCz2k45AVCMe/9FV4JaoDx0L1JtcA1ba0SN0tclZCo4NcC0=
X-Received: by 2002:a05:7300:cd8e:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-2efb7bdc820mr2487023eec.7.1777822600465; Sun, 03 May 2026
 08:36:40 -0700 (PDT)
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Sun, 3 May 2026 09:36:29 -0600
X-Gm-Features: AVHnY4IEKihDzyMefIZaf4wXkLONkubSyJS7kgxSCI2pMsMRWQPbegN7xrW6G_Y
Message-ID: 
 <CAA_JP8XEx6OrY9GV3xLFfyiECZK=cuHSjxWAqFFCVbjQwSdyFQ@mail.gmail.com>
Subject: maximum observed performance?
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: RPLJDJSKHTQNUAJZOFUU7WDUQPJIAYEG
X-Message-ID-Hash: RPLJDJSKHTQNUAJZOFUU7WDUQPJIAYEG
X-MailFrom: dandenson@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RPLJDJSKHTQNUAJZOFUU7WDUQPJIAYEG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi guys.  I've long considered building a batman-adv underlay mesh for
some wISP duties.  The problem I'm running into is that I'm only
seeing ~800Mbps in lab tests on real-hardware, far less in GNS3 tests.

I've got a number of >2Gbps RF links and often multiple links that I'm
currently using ospf ecmp to aggregate.

Anyone have any first hand examples or a published doc showing
multi-gigabit over a layer2 batman-adv?  specifically ethernet
interfaces.  The RF layer is separate layer2 bridged and can handle
iperf of ~2.4Gbps+ (Tachyon and Wave Pro radios).

my current model of ospfv3 works but it's all link state and to get it
back to layer2 I'm spending CPU cycles on bridging and encapsulation.
If I have to spend the CPU cycles, I'd love to switch to batman-adv's
link quality metrics

thanks
