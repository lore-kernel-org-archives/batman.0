Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E6DC25B75
	for <batman@archiver.kernel.org>; Sun, 19 May 2024 14:34:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 15E0D82213
	for <batman@archiver.kernel.org>; Sun, 19 May 2024 16:34:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716129244;
 b=OQsOlGfoQEW576A+9PlfB2LmUHXM20F43U5ECaiFcbq9K1a/xPTisCCrQv7jnBy/DDxl/
 6TfvoTB9K99TCpKdOMR6az06z0T13Qs/GvvgAOfaragKh5lY3k+GE8cjYk9YhvcpZQyO14I
 /YvXuVMJ9DL+RSETJ5kazl7Vi9Wek0Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716129244; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NBZb1kcZFNTJ/CM/ttHhgUol0zl0YFiu97hcP5Nj/4Q=;
 b=o8XoyXDTSEEZQa3iw5dgS62GRzq8p7yUrvvHlliGHHycRSeWeRgcb49qgVp8x6xp+BMG1
 QsWRnxeDqKoWVSWjcGzix6ijtPuxE1iQxkbAovVcAHqEx4ODV0oYOzx/h2CkQT33JEmFdqa
 wna6TLMJxFAo2ItzUJDfMruZ1AoiDRY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s3.neomailbox.net (s3.neomailbox.net [5.148.176.53])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C345C8146F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 May 2024 16:33:53 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716129234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBZb1kcZFNTJ/CM/ttHhgUol0zl0YFiu97hcP5Nj/4Q=;
	b=GqYaENmkeWxou3sWKilrcVUrD5xEDErJD/G0pnI32bdfPc2mLN1Ly0qymOPAJaHG5cv0KG
	9XBlmkkyO3T4N+lOUKkaMKtMwXydRp7FhVnOS8Cz11PQAHauaVI3JC2luxn41wBHqysBUf
	Et+dhdm8JZPHcbCBvvnTD6TIHF9+glM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.53 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716129234; a=rsa-sha256;
	cv=none;
	b=ozp522EO8w2t8Hi9hvR/WRYeowwfYR0v75JMM9+bqCKaUOA1TLA9+VU0oLIguuOev06ahO
	vAo+hvbHqdsGgiodhdjknyL12HWHotsSefLPqnncjDyIUbDxEit5CQprkUVOXOb3pescS3
	32508pYYD9GxWzQ35uvTo6Guhkcv9bA=
From: Marek Lindner <mareklindner@neomailbox.ch>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Berkay Demirci <berkay.demirci@protonmail.com>
Subject: Re: About Throughput in BATMAN_V
Date: Sun, 19 May 2024 16:33:44 +0200
Message-ID: <5797991.sP1CNn8AQk@rousseau>
In-Reply-To: 
 <livakUAT6XSpa0RoYB-m2_tK2wjUm-5ZdcvIBa2G1Hw53hhh_tlHIwr2B5nOomayXajuotSI5NGl956q_aZjZG5yVRu5C-uth6lNJcUNCtw=@protonmail.com>
References: 
 <3327582.AxlXzFCzgd@rousseau> <2066205.UkFFEUeh36@rousseau>
 <livakUAT6XSpa0RoYB-m2_tK2wjUm-5ZdcvIBa2G1Hw53hhh_tlHIwr2B5nOomayXajuotSI5NGl956q_aZjZG5yVRu5C-uth6lNJcUNCtw=@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: AVGNGH7BOBRWM3HTZZNUU76SN5BPJXUR
X-Message-ID-Hash: AVGNGH7BOBRWM3HTZZNUU76SN5BPJXUR
X-MailFrom: mareklindner@neomailbox.ch
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AVGNGH7BOBRWM3HTZZNUU76SN5BPJXUR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Monday, 15 April 2024 10:20:20 CEST Berkay Demirci wrote:
> In the test scenario, two nodes move away from each other so packet loss
> increases over time but it increases more in network 1, and since the
> throughput values are overriden, batman still chooses that network based on
> that value. Only when OGM messages stop reaching in network 1, batman
> switches to network 3 and we see the PDR increasing to 1 immediately when
> that happens.

Correct, the throughput override is a static value and does not adjust to a  
changing environment. On wireless interface the estimated throughput would be 
adjusted as the nodes move away from each other (batman-adv is able to read 
estimated throughput values from the WiFi driver).


> Basically we want batman to be able to switch earlier than that and that's
> why I asked about the throughput meter implementation because the batman
> overriden throughput value doesn't consider packet losses.

Exactly, the throughput override does not consider anything other than the 
configured value.


> Another idea we had was to manually change the throughput value via a script
> if packet loss increases too much or something like that, we haven't thought
> in detail yet. So I'm asking if you could have any suggestion that considers
> packet loss as well.

It seems you are attempting to simulate a wireless environment using wired 
devices. Wired devices typically can not "move away" from each other, hence 
you are running into this issue with your simulation approach. 

Maybe mac80211 hwsim is an option for you? I've never used it, so can't 
provide specific suggestions.

Have you considered testing on a wireless testbed?


> Otherwise, I'd also appreciate the assistance you could provide for the
> patches for tp fallback implementation. Does it work at all at its current
> state even with problems or is it not there yet?

Your question isn't entirely clear to me. As a first step, you'd have to rebase 
the tp meter patches to work on your chosen batman-adv version. How much work 
that might be is hard to ascertain without trying it.

Cheers,
Marek



