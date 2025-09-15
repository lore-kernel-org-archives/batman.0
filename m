Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377C8CAC597
	for <batman@archiver.kernel.org>; Mon, 15 Sep 2025 15:45:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F21784611
	for <batman@archiver.kernel.org>; Mon, 15 Sep 2025 17:45:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1757951101;
 b=OIAbufbnHt817VxcP/95FkHEpR40BnyZ6zkDrDxp/MpYdWFIkzGj3Y5kCZhaLZdzxp0DQ
 tCkMAYblcSqoJeMHbqlGFHXIXgYSfJfifS/Y8W4cb3QBEHdFXs0CMuzumyCt+PaDQChbh8k
 ZbRjbEg4kyO+5d4xo+f5SP52ZM05y8U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1757951101; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KTXKCMxwbcP49H5LBrmWVv4oui5DohGUnCKREPxuOqM=;
 b=W2ku9HwJR+nHzBdCOHpkX1miL6QfqSN7wrNdhuMJFPxkNNqX0ZONvgkJzXCxv3/GcJxYO
 eEVDROcPU8M+ugYPJ9ZyYYgs8T/K95M6gvFNtsko1nymVctAThnTbk4ZX5zQ3bQ0avuNmFS
 piqFPzxn4YLf5CAaU7Q28JpvTd4zZEo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=protonmail.com;
 arc=pass;
 dmarc=pass header.from=protonmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=protonmail.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=protonmail.com policy.dmarc=quarantine
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch
 [185.70.43.167])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9CD6384576
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 15 Sep 2025 15:51:36 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1757944296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KTXKCMxwbcP49H5LBrmWVv4oui5DohGUnCKREPxuOqM=;
	b=ozAxehX565ryJ7gJV/0ALBWQ5LN46NUoT2eCKuce0Bn/LKKENC1lax3GyfBBh/WzvgEgsc
	yGXPo2kt37/xPbTWczAf3s+FDwzcHuU3b1G6dmEjNQIon4sdv/ENIZSTbffjnvW9C07ESJ
	CKlCNV+TZZ+GdDeRsMo0eCpGjt0M3wE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=protonmail.com header.s=protonmail3 header.b=taRcLydr;
	dmarc=pass (policy=quarantine) header.from=protonmail.com;
	spf=pass (diktynna.open-mesh.org: domain of martinvdberg@protonmail.com
 designates 185.70.43.167 as permitted sender)
 smtp.mailfrom=martinvdberg@protonmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1757944296; a=rsa-sha256;
	cv=none;
	b=1t9BDwDVdkRBkx5uRStT2PmZn9oY9Lzz5VogRElOodyef5UwurSTfIsGIn6r0bcbqx40j7
	Of66KbMblZqU/H9GUMJY11bEj9ljOdA5uJz6HuefRFAUw22Fqwy6qxGNZYkKDuS96dCUuQ
	ZnXgB4C1dyFLYZ7t6nsM8ikvhS35DRo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757944295; x=1758203495;
	bh=KTXKCMxwbcP49H5LBrmWVv4oui5DohGUnCKREPxuOqM=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=taRcLydrVBW8oKsYGKgpH4YhyHU8x5RhyJV8/ueGEkcwwtblG75aobmdqnwkaWxdT
	 ZhPDtJAO4AjVWZVPwU+En5Epr7pzPE0EmAWSwJkN5ysdLz99fRUh0NVWAIv1FuDiri
	 ljL+m18NBGSBFyY1qLT+OnScF44yaPPcVxKeUtku2BM3rY1B9sZYxV/iKc4SViUh4z
	 7BryxhMOR+mscvjtw9bcYhZA+DlT+OzVWTFbrD8sMgu1OiW8KAZAwicObrbKy7PXh2
	 eA+CP6GKen+wNUYYWobXHn8yeZGvJT4x/+MmQaA/iRHXGjuOLuLNQppwpk9v0amDfk
	 StdTjPKR7MGSg==
Date: Mon, 15 Sep 2025 13:51:29 +0000
To: b.a.t.m.a.n@lists.open-mesh.org
From: Martin <martinvdberg@protonmail.com>
Subject: Re: Mobile Ad-Hoc use-case where each node may be Client and Gateway
Message-ID: 
 <qHQMzCyEL-Q3npasUKO_FuIkHWmEcRMmUwzL6GVCabNQ_Xwk5-jYPeiU1cb82Vv84XfVtD5dGM0VLKbJBI70Te6SJktZGuO5EUfGr_8uVT0=@protonmail.com>
In-Reply-To: <2da5b8ef-1628-4296-b85a-9dcf8ae1a184@unstable.cc>
References: <175776078622.1495.8426151955000236578@diktynna.open-mesh.org>
 <2da5b8ef-1628-4296-b85a-9dcf8ae1a184@unstable.cc>
Feedback-ID: 6271043:user:proton
X-Pm-Message-ID: 2423b3de25bb06b73dca62183e8ecaf6370f2faa
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: martinvdberg@protonmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: UJPWQ66V7FTQMAVH3KJUZ3GNUPMQ74TP
X-Message-ID-Hash: UJPWQ66V7FTQMAVH3KJUZ3GNUPMQ74TP
X-Mailman-Approved-At: Mon, 15 Sep 2025 17:44:39 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UJPWQ66V7FTQMAVH3KJUZ3GNUPMQ74TP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


Hi Antonio,

Thanks for your reply.

> > My main concern is whether a node can simultaneously act as both a gate=
way and a client. Is this possible, and if so, how can it be configured?
>=20
> Given what I said above, I hope you understand that batman-adv expects
> each node to be either gateway or client at any given time.
>=20
> If you want to dynamically switch between gateway and client, then you
> must have some extra logic (external to batman-adv) that takes care of
> the switch.

Clear! I will need to add some user-level deamon that takes are of the swit=
ching.

Regards!=20



