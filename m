Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A95CCDB482
	for <batman@archiver.kernel.org>; Wed, 18 Oct 2023 20:00:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6EB62831DF
	for <batman@archiver.kernel.org>; Wed, 18 Oct 2023 22:00:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697659207;
 b=AQulf5uoJJ6wFUBijtHO2/8SteGSDIn9OlYDaKMBBk84QX4EIS7U/ciAVfiVF6p/rK4gc
 i/VO70TlnQu3SmevyEoaYQv/XIeVWRGLcB7DcOTxxS7XUJLz+YPbmB4dnscdUbGiJ8pPxSA
 6tJnu0fbHt62rTwSn6XwF24cgLmZpFo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697659207; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=88vbI0kkdnHBY3Srh2oFFYR0xcQ66MOVuu0PyaxbTm0=;
 b=3ps2K459uEsGmsLvqv2PIjBVTn/Ky/xpsoixwj+Qu2j+oe3T2Q8kLkE6r1Krpi2B+NVSN
 uRv4USwaRh4m3cTXYjQFUZZbiVRT1wBbdMtd9u7aUMHGfupCbYb6HqjBQbtJa/AutYwKc2i
 1YiI2G3bbj2RUB7SJO1rahuhY6qZMvc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 179DB80868
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Oct 2023 21:59:44 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697659185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=88vbI0kkdnHBY3Srh2oFFYR0xcQ66MOVuu0PyaxbTm0=;
	b=VWqFkG8AilIs/X06/v6Fdeb6V/TMiZVegdP6GrdGf9L14auWeEEdO9128MWKwhCJGfgkoh
	hlKF9dB/N/aB2AU9mzlY3yYfEDcFwBrM7myhALuLHVWxmiuPqlye+8udsQlxCmP6+tQC63
	2oC0KtTa18/SvCl8yDJou6GamoUYWk4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=xBmaHHZi;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.11 as permitted sender) smtp.mailfrom=repk@triplefau.lt;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697659185; a=rsa-sha256;
	cv=none;
	b=eyX8r/SxpRw26Zi0w1FTh0dkxjGIzO3+2Hq1Wzk1ds0nZYeN1bqnkRixoYHexcZPXcguzK
	OxUftefeDHR9gJZIRe2tEFugeRDJhVTz6OBbtwnySDsFRarYAdB7aydwtlSCHjq6z+Ihy7
	p9/uk4YW18Ub/E57/c7xtVy/8SWZmSE=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1697659180; bh=WgAhYaARliXVfPrCNd91hMqyo+vKnLrJTSWpkVFXLn0=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	b=xBmaHHZigM/DVwjfWlKDxVUIP3PDpuzsnjmjmbY6ZlBt7iG2o//jg1d4+744KG5ho
	 MVlD493Pkg7pvlKkhGdqb/i545tfpqx5cKEPpIX/qb1JkSNT3GfWywtDGBxBpxr27C
	 BfAUG2Yv+ZRR6lgXjf75u4mCKbCs67TxQKBAUZWI=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Wed, 18 Oct 2023 21:59:40 +0200 (CEST)
X-EA-Auth: 
 waNh5IPe+xc5OhXs/H/QViMjoTVAknpwhTorBgeK4UTNEHod7KZj3aAz/90O/0Hp/6YUyJm7t0C4UYVt4lN9N0gIG0+c+wgqgW9L4pv3QL4=
Date: Wed, 18 Oct 2023 21:58:09 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH RFC 2/2] batman-adv: Better half duplex penalty estimation
Message-ID: <ZTA40fGA-NSvYkoq@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <09c086e5e68055e52d1f92ba17d0e921084107e7.1695904299.git.repk@triplefau.lt>
 <ZSoixFsJi5vYCRxh@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSoixFsJi5vYCRxh@sellars>
Message-ID-Hash: IUKXGZ7P36RXSROA7ODPZB6UWB4BWWXX
X-Message-ID-Hash: IUKXGZ7P36RXSROA7ODPZB6UWB4BWWXX
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IUKXGZ7P36RXSROA7ODPZB6UWB4BWWXX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, Oct 14, 2023 at 07:10:28AM +0200, Linus Lüssing wrote:
> Hi,
> 
> Thanks for taking your time to look into this and the detailed
> explanations!
> 
> Generally, the issues both patches try to address make sense to me.
> 
> 
> On Thu, Sep 28, 2023 at 02:39:36PM +0200, Remi Pommarel wrote:
> > Let's consider the below topology
> [...]
> > However the following formula seems to be a more realistic approximation
> > of PT_ac:
> > 
> > PT_ac =  PT_ab * LT_bc / (PT_ab * LT_bc)
> 
> Typo, I guess, as this would always be 1? What is actually
> implemented makes more sense to me.

Correct ought to be PT_ab * LT_bc / (PT_ab + LT_bc)

> 
> [...]
> > -	return min_t(u32, lth, oth);
> > +	/* OGM throughput was divided by two for retrocompatibility sake */
> > +	oth *= 2;
> > +	return oth * lth / (oth + lth);
> 
> Could we end up here with a (forged?) OGM that has both the new
> half duplex flag set and a throughput value of 0? While also
> having an lth of 0, therefore dividing by zero here?

Yes good point will add appropriate checks for that and the other
possible integer overflow if this RFC goes further.

> 
> 
> In the following scenario:
> 
> +-------+  ch.1  +-------+   ch.2  +-------+   ch.2  +-------+ 
> | Orig0 | <----- | Orig1 | <------ | Orig2 | <------ | Orig3 | 
> +-------+   300  +-------+  30000  +-------+    110  +-------+ 
>                      ^                                   |   
>                      |                ch.3               | 
>                      +-----------------------------------+ 
>                                       100
> 
> Would the results on Orig3 to Orig0 be these?
> - via Orig2: 300*110 / (300+110) = 80.5
> - via Orig1: 100  <- selected
> 
> While it should have been this?
> - via Orig2: 30000*110 / (30000+110) = 109.6 <- selected
> - via Orig1: 100
> 
> But we can't calculate the latter on Orig3, because we don't
> know the two hop neighbor link throughput? Or am I missing
> something?
> 

No good catch thanks. I can think of a way to fix that but it would
need additionnal info in the OGM to store current half duplex link
speed (maybe to add a TVLV for that). So let's first see if the idea
seems sound enough to go further.

On a side note, the current implementation also has its own flaws for
this scenario. Let's say you consider Orig0 to Orig3 instead and packets
will also go from Orig1 to Orig3 directly instead of bouncing on Orig2.

> 
> Also, this seems to assume that time slices are divided equally.
> That's probably only be true for WiFi drivers that have airtime
> fairness changes integrated? So only recent versions of mt76,
> ath9k and ath10k? Has anyone verified that this works fine not
> only in AP but also in 11s mode?

I don't know how that would behave on setup that does not have airtime
fairness changes integrated, if you think the current dividing by two
approach is better maybe this can be made a configurable option but that
could be tricky ?

For 11s, I have also run tests using mesh points instead of AP/STA and I
have measured similar results.

> 
> And a third concern, but we'd probably have this issue with both
> our current and your suggestion: Would we be off again 802.11be
> and its "Multi-Link Operation" in the future?

This, I have hard time figuring out how MLO would play along with
B.A.T.M.A.N-Adv integration. Unfortunately right now I have no way
to experiment that yet. IIUC the link would be a mix between half and
full duplex, and this would probably complicate things a bit.

Thanks a lot for your review.

-- 
Remi


