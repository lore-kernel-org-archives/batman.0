Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05BCA0FFD
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 13:09:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1E6B183E83
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 15:09:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756732162;
 b=sXIqo7AFlPx4n31z47DdX8TM0FXO+tzTYtuVfWcLnVTr5QQjD5I+izQpqP8vOVxgZmfwW
 Zrdd9yIH3BuzIzyyaGPHBGtzSbtOlpGiKyhzSk4zH/WdO2v7OSsSkwEREtyCUT/tXdBVZBJ
 D4fgBeRyCmVR0/vXjhw5PkF5bylhtno=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756732162; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m5VjQZAVa1BHaSq1AXpNcFdY64WJdTs+/Rs/CiJpO8U=;
 b=RmI6+MOX4Tya0TliRPQ+d9Gv7llKUddhiSS836XzIs7vDm1ABGLHXFfqZYElVSmhEnrPa
 HaWZJDaS2M3JTDxKoC5rtYJLlU4LMUGMI4kzBpArNYX55jzTshPQRqdiziwVtoRr+KwSHsu
 kcWF6cybaNtzJyuDCP8VAFkJLzuSo5I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass header.from=mailbox.org policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0B84B80099
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 15:09:06 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756732157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m5VjQZAVa1BHaSq1AXpNcFdY64WJdTs+/Rs/CiJpO8U=;
	b=xJFAHsD3b9LQb3MCkFS8+cgIm8XoEU7KxcC5WIGZdzVQhdntEEmB0urBkrnMUpZeNUPiIX
	Oc2OAKrVDg+CNV7fcVjOGkUQ1JxEYvaqVqDvDXiY0bmbsvK9bxv+6ah3O1n7ZVbG4kS9JI
	ZNXrXd80RSNy5ft6+wdCXZmdUXrbQHw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vWJYzHdm;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 2001:67c:2050:0:465::202 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756732157; a=rsa-sha256;
	cv=none;
	b=Mp1W40RJ016QReCG3kEgtWda4B6tsJYe7TQu3F0o0xMBwumiED4oeKT3zkS7q4+pIainQq
	eJCIdOgkEaGmWrfaPckU6JwUk4mmWyw5AxQfS8AlvyAxVmHf6Rt1tfgpZbc0a/ZnnFf3qH
	FOhrOLebBQtXb36Tmrf9M1GKDTP6q8Y=
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cFq2M4P5Lz9tbV
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  1 Sep 2025 15:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1756732139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5VjQZAVa1BHaSq1AXpNcFdY64WJdTs+/Rs/CiJpO8U=;
	b=vWJYzHdmqKo56j+7AcaseLlaAcCuciBP7vs1n0KHqCAf1mdphpylrFAoXow5ThHjDXEaPi
	2G+MpLuLjnLtZGSH9oJdPEiVuChAWLcIb+JX5Nrh/OeYk8shT4SbbY4oRzbHSzNrej9vGT
	siySfs9uwwn6NCpws6UlU49ZVbIRJRE+vjnDGvWtFDrf+3GgExl1sJIqlagxIPRyUHJavj
	FGeFNPjaFb5IhgGTsLiX8tqKYZAw0yA0m7w8bTaorowh1IXU90PM9iGo0VCgmPQTJDAMjr
	MXgIaPd6cITeaFIGfsv0acdFwj+wDe59vr0x32KQlwvQMB72nmL7X+70F80qng==
From: Marek Lindner <marek.lindner@mailbox.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH 1/2] batman-adv: remove network coding support
Date: Mon, 01 Sep 2025 15:08:58 +0200
Message-ID: <2795124.mvXUDI8C0e@voltaire>
In-Reply-To: <20250831-drop-catwoman-v1-1-1071bb2a159a@narfation.org>
References: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
 <20250831-drop-catwoman-v1-1-1071bb2a159a@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-MBO-RS-ID: e80be1e3d5de1ea3f90
X-MBO-RS-META: s85or5uddap9qxbkn9kxnm84ydegg7ex
Message-ID-Hash: QWOK2OIIZQOQZE6XAVCIYIRIXMPQE3KK
X-Message-ID-Hash: QWOK2OIIZQOQZE6XAVCIYIRIXMPQE3KK
X-MailFrom: marek.lindner@mailbox.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QWOK2OIIZQOQZE6XAVCIYIRIXMPQE3KK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sunday, 31 August 2025 17:40:01 CEST Sven Eckelmann wrote:
> In addition, the feature has been unmaintained for years and is discouraged
> for use. None of the current maintainers have the required test
> setup to verify its functionality, and known issues remain in its data
> structures (reference counting, RCU usage, and cleanup handling). Its
> continued presence also blocks necessary refactoring of the core originator
> infrastructure.
> 
> Remove this obsolete and unmaintained feature.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <marek.lindner@mailbox.org>

Thanks for the cleanup initiative, Sven!

Cheers,
Marek



