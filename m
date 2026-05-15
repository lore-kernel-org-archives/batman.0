Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D0CCD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:05:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 05C8085BA2
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 14:05:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778846756;
 b=mLpcclvb1LEzfpLBh4TzbrXuMrmm7DskqWEpr8VqyGEd9UROcbqlcRpgU2hFprPuIMduX
 veya8cUBdSEHdpKXFOCKaHzr587BgocxDcH0UQRkKkt4RuTojVTXCCjaKGWHvHmLjDXrgD9
 8XGVHsoaaKt0fYVzpWhAxP6IXbVK90w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778846756; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0yOQzcwBovUCFTj5r+vnA2KGDV0IVDWP8Uv8obelYFU=;
 b=fhhlGdh52BYY2PkPf5m9KJOA9W6WnOdobkuU9InxXsT/BX8Y4XIYSd3pJV586/76b6bHm
 nB8QCFcCEuAgsgkSOICFkKVuMTegIvKcnu4nagRqNaqHdQDr6CWfNAozibix4hZotw9fFOY
 uazV7W7qUgFYV8aty0WzyKrHK/TyirA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4052D8430A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 14:05:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778846731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0yOQzcwBovUCFTj5r+vnA2KGDV0IVDWP8Uv8obelYFU=;
	b=Acu4H9Yrwzrlb6vlPfNWpq65AnNTXx9oYRIwY3hxj0piy6YVrssEZYEQO6kdLTJHhBf51T
	wKumWHwPA2/CZ0oBR0DzaPYd/Y4h9GSjpC4fYIrhnNBg2og+Rr3jR9dG/fluCCR8GWknlT
	zT40dMwN1oIU6FKn/DlBEWWDnc5AsMU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=qkkixbfM;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778846731;
	b=liOLv7D7dJnKEz5ZeWfk31Hj1LT2FSehJsT0fAKQTzxws6I9G15Hjb7kSLTNrIXwkIkYSX
	O1zT1hYBdI+uPMufGP258YkIC3zOFM+mabpoDZkyyaUywYvWcDgv2715NphIkhUY0+24Bt
	hr6a10adCVFFWOWM30Lpktavt6QCCvU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778846730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yOQzcwBovUCFTj5r+vnA2KGDV0IVDWP8Uv8obelYFU=;
	b=qkkixbfMqSpNqEFJnZE3E/54F4yST8D2pgvEWga9BmH8XKqS4FifdR7v28ui852yRpgqG3
	+VYvfZ7Sa48FI0+5MQa7jm8muzXkvp8Mb2mUksMYqbx+bM7aiIsyH6U9p97TQJ+YzUWD1o
	dHGmG2A3x/A67T+593sppZn7/2HUAjqHJ4YCXP9JnF1ZXQxh9EhYWt+jD7H/+9/H+SDYEp
	Lru9OyNhMKq6DHZyLqoYa9Fdeel5pujNmx08/BueNzE88IPo8uO4A2Zsoxja+HTdHaLiDN
	97VGUu8s2t9JUIOBJL7DOQym3qQTezF32a3fzeoyFBuQCIGTT40U3BuzJSWAIA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Sven Eckelmann <sven@narfation.org>
Cc: antonio@mandelbit.com, marek.lindner@mailbox.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH batadv v3 2/2] batman-adv: bla: avoid double decrement of
 bla.num_requests
Date: Fri, 15 May 2026 14:05:30 +0200
Message-ID: <5395267.31r3eYUQgx@prime>
In-Reply-To: <5105124.31r3eYUQgx@sven-desktop>
References: <20260514-bla-cancel-work-v3-2-dc65d3485e11@narfation.org>
 <20260514210047.08C2BC2BCB3@smtp.kernel.org>
 <5105124.31r3eYUQgx@sven-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: UVYXPFUUEGBWLMUYTVHMAS5URVDCDTGU
X-Message-ID-Hash: UVYXPFUUEGBWLMUYTVHMAS5URVDCDTGU
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UVYXPFUUEGBWLMUYTVHMAS5URVDCDTGU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thursday, May 14, 2026 11:11:04=E2=80=AFPM Central European Summer Time =
Sven=20
Eckelmann wrote:
> On Thursday, 14 May 2026 23:00:45 CEST sashiko-bot@kernel.org wrote:
> > [ ... ]
> >=20
> > > @@ -1517,14 +1529,21 @@ static void batadv_bla_periodic_work(struct
> > > work_struct *work)> >=20
> > >  			 * some grace time.
> > >  			 */
> > >=20
> > > -			if (atomic_read(&backbone_gw->request_sent) =3D=3D 0)
> > > -				continue;
> > > +			spin_lock_bh(&bat_priv->bla.num_requests_lock);
> > > +			if (backbone_gw->state !=3D=20
BATADV_BLA_BACKBONE_GW_UNSYNCED)
> > > +				goto unlock_next;
> > >=20
> > > -			if (!atomic_dec_and_test(&backbone_gw-
>wait_periods))
> > > -				continue;
> > > +			if (backbone_gw->wait_periods > 0)
> > > +				backbone_gw->wait_periods--;
> > > +
> > > +			if (backbone_gw->wait_periods > 0)
> > > +				goto unlock_next;
> > >=20
> > > +			backbone_gw->state =3D=20
BATADV_BLA_BACKBONE_GW_SYNCED;
> > >=20
> > >  			atomic_dec(&backbone_gw->bat_priv-
>bla.num_requests);
> > >=20
> > > -			atomic_set(&backbone_gw->request_sent, 0);
> > > +
> > > +unlock_next:
> > > +			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
> >=20
> > Will this prematurely reset the bridge loop avoidance sync state when a
> > request is sent?
> >=20
> > In the previous implementation, batadv_bla_send_request() set request_s=
ent
> > to 1 but left wait_periods at 0. When batadv_bla_periodic_work() ran,
> > atomic_dec_and_test() on wait_periods would decrement it to -1 (returni=
ng
> > false), which correctly kept the gateway in the out-of-sync state until=
 a
> > valid ANNOUNCE frame arrived.
> >=20
> > With wait_periods now being a u8, if batadv_bla_send_request() sets the
> > state to BATADV_BLA_BACKBONE_GW_UNSYNCED but leaves wait_periods at 0,
> > the next run of batadv_bla_periodic_work() will evaluate if
> > (backbone_gw->wait_periods > 0) as false.
> >=20
> > Because the code falls through when wait_periods is 0, it appears to
> > unconditionally transition back to BATADV_BLA_BACKBONE_GW_SYNCED.
> >=20
> > Could this spontaneously drop the out-of-sync block without receiving a
> > valid ANNOUNCE frame, potentially allowing broadcast loops?
>=20
> @Simon, can you double check this? My understanding is that this code is
> only relevant for own_backbone (see batadv_bla_get_backbone_gw()). And for
> own_backbone, we are always setting wait_periods to
> BATADV_BLA_WAIT_PERIODS.

This part was/is only relevant for the own gateway (we check for the own=20
primary address in the beginning of this function).

The wait_period is only set when creating the own backbone_gw, and then onl=
y=20
decremented in the worker. The idea is that we wait for ~30 seconds or so=20
after batman-adv initially joined the network before we allow broadcasts.=20
Sometimes switches or the Linux bridge need some learning time of their own=
=20
and would not forward our BLA announcements either, so we want to give them=
=20
this time to get to know us.

> An underflow was never expected and this code should not run for
> batadv_handle_announce() with CRC error (see batadv_bla_send_request()).
> Only in this codepath, we don't set wait_periods to anything.

Yes, I think this is the mistake on Sashikos side (saw that in another revi=
ew=20
previously):=20

 * we don't reset waiting times again. It's only set during creation
 * we don't send requests to ourselves, therefore request_sent shouldn't be=
=20
touched by anything else. So basically the request_sent is serving a specia=
l=20
case purpose for own gatways.

Cheers,
        Simon




