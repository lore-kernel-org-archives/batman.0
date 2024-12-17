Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B35E7717F
	for <batman@archiver.kernel.org>; Tue, 17 Dec 2024 16:38:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EC06F83F30
	for <batman@archiver.kernel.org>; Tue, 17 Dec 2024 17:38:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734453514;
 b=tJzjewnQWfEetv5ae3bbQ//yKjjQ8UH2WogERthHhBz/H4NOeaPJkAs928PKINe+VtCYe
 yduk78EUntJ8LJ+EO/rmjX/5YS4L0UmSi1u27IZD4gLl/iu3GatFUe18af5yJjAIz4yEk9h
 inRFDyDDuQXzmOS1OCailLdtlztIGGg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734453514; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=d44w8cARKpTzaHoSP8X+RHU6h8qc++roOGmEHwE/jBg=;
 b=37tMeMzvow61xQvNVZU4Wz9MT+pjQi1m1EfpzdH7x/cmDPwyrecf6glY9NKArsrgGl0or
 8lCz+MK82WH44fgZXtqz74U1dM4TcQVQRyPMxqIzOfBDK1i6HrlFjwUqB7r3smaRdtPYT+9
 tvkUISQdPUu40YXtBlKgehFYbgJfKLI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 97876815E9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Dec 2024 17:38:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734453496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d44w8cARKpTzaHoSP8X+RHU6h8qc++roOGmEHwE/jBg=;
	b=q5qwsbfsRzizrrvCqum1VlJwqmKAwcbsFQevXo+1eddv0uF0PvCB2Q+O2qnUySF4QwcYFN
	x/lv/mDCIAJu7aBKkGciGvj7RQnD7AYbL6PuykRIHcxp8werNd7lINWzPoQrw79ZYwHtYH
	biJ34jtnE0KBlQ88CMLHlU/ZRH6Nq6g=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734453496; a=rsa-sha256;
	cv=none;
	b=aLRA3GPyz6bhkUC00L+sO46UQ+Ejpzoy/5dJf9bZ0oFAJWqUwXJ/xG1dTrrOhvztc/43vw
	/qIT15uPZK07H22okxc+MkQlbqp3QIvD7TXYpLJDKxKyNvmZWJH9Uch5YQvnulKT31CpCZ
	BzVqGvAgcdofx7/oVNQJ7ZU1MctdceI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Cv/rQ5EM";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1734453496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d44w8cARKpTzaHoSP8X+RHU6h8qc++roOGmEHwE/jBg=;
	b=Cv/rQ5EMAzxLRxMX4/JgfWXFRemGXEjpW6kgLtfQymj6ieCpleNjmVos3AH+csq+DnGK/8
	w1IB+Mko/n6UUTQ2An18rCG8eeVTSSCQQcoYcufYi12vSX8aBj1XlfM3pp8naDcGxPdgCx
	NQSUTlGiXwn0uR/JnImwo+a0tIvUIYk=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: Map VID 0 to untagged TT VLAN
Date: Tue, 17 Dec 2024 17:38:09 +0100
Message-ID: <2224062.Icojqenx9y@sven-l14>
In-Reply-To: <Z2GCU5mOICMJgiwc@sellars>
References: 
 <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
 <Z2GCU5mOICMJgiwc@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart115639156.nniJfEyVGO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7GCHSLV4PTEQ6JULMSXYYPALKO7ZTZPI
X-Message-ID-Hash: 7GCHSLV4PTEQ6JULMSXYYPALKO7ZTZPI
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7GCHSLV4PTEQ6JULMSXYYPALKO7ZTZPI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart115639156.nniJfEyVGO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: Map VID 0 to untagged TT VLAN
Date: Tue, 17 Dec 2024 17:38:09 +0100
Message-ID: <2224062.Icojqenx9y@sven-l14>
In-Reply-To: <Z2GCU5mOICMJgiwc@sellars>
MIME-Version: 1.0

On Tuesday, 17 December 2024 14:53:23 CET Linus L=FCssing wrote:
> On Mon, Dec 16, 2024 at 07:37:12PM +0100, Sven Eckelmann wrote:
> > diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> > index 8e0f44c71696f642d80304ec2724e8b5e56a5d93..333e947afcce7ca4128be84=
06f23295df723515c 100644
> > --- a/net/batman-adv/main.c
> > +++ b/net/batman-adv/main.c
> > @@ -637,6 +637,13 @@ unsigned short batadv_get_vid(struct sk_buff *skb,=
 size_t header_len)
> > =20
> >  	vhdr =3D (struct vlan_ethhdr *)(skb->data + header_len);
> >  	vid =3D ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> > +
> > +	/* VID 0 is only used to indicate "priority tag" frames which only
> > +	 * contain priority information and no VID.
> > +	 */
> > +	if (vid =3D=3D 0)
> > +		return BATADV_NO_FLAGS;
> > +
> >  	vid |=3D BATADV_VLAN_HAS_TAG;
> > =20
> >  	return vid;
>=20
> I guess with this patch all TT entries previously in
> TT VLAN 0 would be moved to untagged/NO_FLAGS TT entries, right?

Yes, as specified by 802.1Q-2011, it is meant to transport only priority=20
information and not a VID. For a switch, the PVID would be used but because=
=20
batman-adv is here used as the lower device (for either a VLAN aware bridge=
 or=20
8021q device), we don't have to add the PVID - the VID is simply missing=20
(because it is !BATADV_VLAN_HAS_TAG) and therefore has to check for the=20
"untagged" TT global entries (or add entries to the "untagged" TT local par=
t)

> Wouldn't that technically break compatibility? Let's say someone
> uses VLAN headers with VID 0 to be able to use priorities / QoS.

Then this person should have noticed that it broken at the moment and doesn=
't=20
work as expected (to reach the "untagged remotes" with the priority tagged
packets)

> What if some old nodes still announced+used VLAN 0 in batman-adv
> while others used it after this patch, with the mapping to
> NO_FLAGS?

Then the misbehaving old node would still misbehave. Because you should=20
actually be able to talk with VID 0 to the untagged global TT entries - whi=
ch=20
the old node fails to do. So I could also add

  Fixes: 0ffa9e8d86d6 ("batman-adv: use vid when computing local and global=
 TT CRC")
  Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framew=
ork")

if you prefer and transmit it via the batadv/net queue.

But I considered VID 0 somewhat esoteric for in-Linux usage because most to=
ols=20
just use DSCP. I am only away of tools like isochron-send which just inject=
=20
raw packets with the VLAN headers directly. And using another 8021q device=
=20
with VID on one side is a good way to create a unidirectional communication=
=20
(when you want a bidirectional one) because the other end will just reply
with a vanilla, untagged packet. And because of that, things like ARP will
not be able to "finish" because the answers are received on the non-VID0=20
interface.

But maybe I am wrong about that.

Kind regards,
	Sven
--nextPart115639156.nniJfEyVGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ2Go8QAKCRBND3cr0xT1
ywIoAP0SeyJpfAEElNIDbT7RNP4II3ufu2gkMYfTnVxVRyysVwEA/0n4hxUq35Dl
qCA7FXid/WL7eO45QaPx/7NQdT6BTgs=
=9F1O
-----END PGP SIGNATURE-----

--nextPart115639156.nniJfEyVGO--



