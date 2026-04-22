Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A36F9EDD7
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 14:22:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A7000859A6
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 16:22:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776867724;
 b=T9ee52eFY0YcAh5y58LpQG6XN4ear9XPwpE1gk7baA8YVWqGM+ZqwN2RAtRkWaZH49/cT
 s+ph6l7Vp+SlfbJWjTFNFrFvB/lcbyywUEqnL/fsAQEj0XbbrAu5KsC8IcaYwH0KnmupbyR
 fnrARlINZT0U+MNlBzRAMTbvR9D3uVk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776867724; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bJi4BvGgxMRiaf6iBIys+pqoEYrH5Lgg4VXB+ViNH6g=;
 b=gW9C59yTPqavAGgwAw38egNq03BqOesKNfsjSNsNHac/C6lTiOCOffl32uXRYdtxumLXM
 0zpIgiNI0w0PXRsWIYE9E5iSc1vWVuz45ZhyTdq6Kr2OdQYUHH78vKctn5364gfGqNrGuCt
 gK36sH5EgW5U5JYhq4MH+DKppwcAfhI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F1C8B84511
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Apr 2026 16:21:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776867693;
	b=pDmz5PnM8OTeo85PA2SPP2ufsp6QstAjiFKAn9jEwEM3cVR3O090GE+13/t40AFTmOdsW6
	7XBQdewdm56MTdvaz8hYVu5JdGukTvLY+/sK3iO7lJG+O6QGifpZEKKfj+SvbVoU0Ne3Vv
	+wA9oHAXcQCR2HMivJJeRAFxy2CDGNs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=gg2Jx32V;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776867693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bJi4BvGgxMRiaf6iBIys+pqoEYrH5Lgg4VXB+ViNH6g=;
	b=UiUgB1OUyD0TkpncbhQer7bkq+O3KZnNLuC+DD319z3qIkpTSNFy7SAqzi9dyrmx47X1HD
	Vq7+SX8yQqEXynJAC6Oe1uTjBhq6SeAbFtwRWtsQj4erO8DiA3g8wh4jM07QFM3JI3T+9V
	aYh8p96DBC1jqW01KDLk1BOiFed/uao=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1776867690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJi4BvGgxMRiaf6iBIys+pqoEYrH5Lgg4VXB+ViNH6g=;
	b=gg2Jx32VHD17jFW9Y3ZOWwNh0umF8wycaaqyQPGbUoj143fAqIXVB/iu7vMqXUDZlxT7lv
	GQMyDCSQiEqjiYlJyK42FG5DUq6U1ZWV7NG0Z476mOWiglXZZEMQ/gmx1EBEfMEvW7I1Bu
	c3rBsyyJcohQJih75q7IKOfddv+NESmVm5t7pAy6GeQ6EhWvzpgXlR/bOKxCNQifD3pFEy
	0bMv0svzfa8P5mtpvzzSp/L7w1U4ulDB4MrLzr3xaY7LKY6V1QpTdCAjwOXpjEb8ZE+dbg
	B/0eMVXk905nu4j7cOf+zLNYUm9sIfCr0MFnClsj/K30WY1AtthiMZY+xSnfYg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Martin <martinvdberg@protonmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Gateway shut down detection takes too time from other nodes
Date: Wed, 22 Apr 2026 16:21:30 +0200
Message-ID: <3280589.q0ZmV6gNhb@prime>
In-Reply-To: 
 <T9GBvsX7uc7S-GxsAnHMFg5oj-euOauWkNTXi2SouU2ow1oX1yogmMCi6FW7mXlFuZ3D9zMBiIGARWa2UDobQ2S0OrY8To4neWUtWArNXzw=@protonmail.com>
References: <3735338.hdfAi7Kttb@prime> <7831023.jRhZ6ZUK3Y@prime>
 <T9GBvsX7uc7S-GxsAnHMFg5oj-euOauWkNTXi2SouU2ow1oX1yogmMCi6FW7mXlFuZ3D9zMBiIGARWa2UDobQ2S0OrY8To4neWUtWArNXzw=@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: SBGQ4LITWMIDPVGQKT6NMM7C5AT5AEPJ
X-Message-ID-Hash: SBGQ4LITWMIDPVGQKT6NMM7C5AT5AEPJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SBGQ4LITWMIDPVGQKT6NMM7C5AT5AEPJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Martin,

I've discussed this with my co-maintainer Sven, but we will most likely not=
=20
adopt this change to batman-adv unless we find a really good use case or re=
ason=20
why this change should be made - as I wrote earlier, changing the originato=
r=20
timeout is not really required for most use cases, and even your use case c=
an=20
be solved differently. We try to keep the knobs in batman-adv/batctl minima=
l to=20
avoid that people shoot themselves in the foot.

Therefore, I would actually recommend to not make this patch, at least not =
for=20
upstream. If you need this for your own setup, then fine, but just hardcodi=
ng=20
the change in the source code or use the application-level method we discus=
sed=20
is probably better.

=46or contributions we have a page [1] describing what we expect and how pa=
tches=20
should be made. But again, I would suggest to spend the effort on something=
=20
else. :)

Thank you,
        Simon

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute

On Tuesday, April 21, 2026 10:33:13=E2=80=AFAM Central European Summer Time=
 Martin=20
wrote:
> Hi Simon,
>=20
> I=E2=80=99m considering to add this batctl config. Do you have any tips t=
o get
> started and would this be  something that you are willing to integrate /
> merge, once reviewed& approved?
>=20
> Thanks, Martin
>=20
> Sent from Proton Mail for iOS.
>=20
> -------- Original Message --------
> On Monday, 04/20/26 at 14:06 Simon Wunderlich <sw@simonwunderlich.de> wro=
te:
> Hi Martin,
>=20
> I'm answering without PGP - your previous mail was encrypted so I guess
> others can't read it. I hope you don't mind. Please see inline:
>=20
> On Friday, April 17, 2026 9:49:13=E2=80=AFAM Central European Summer Time=
 Martin
>=20
> wrote:
> > Hi Simon,
> >=20
> > Thank you for your reply.
> >=20
> > I=E2=80=99ve considered your suggestion, and it sounds feasible. The on=
ly issue I
> > can think of is how to select the best possible gateway at the applicat=
ion
> > level in this scenario. Wouldn=E2=80=99t this result in duplication of =
logic?
>=20
> You are right, you may end up having some similar logic compared to what
> batman-adv does internally. I don't think this is much of a problem, since
> you would be re-using the same data but have a (slightly) different
> interpretation of it. The original batman-adv code doesn't (directly) care
> about the last seen time after all.
>=20
> > For the time being, I=E2=80=99ve patched the batman code to reduce the =
timeout
> > from
> > 200s to 20s. This works fine.
>=20
> Glad to hear! If you don't mind that the originators time out quicker, th=
en
> this could just be sufficient as well. Some other users may have even
> stricter timing requirements (e.g. less than 5s or even 1s) which may not
> work with this approach, though.
>=20
> > It would be great to have this timeout configurable via batctl. Is there
> > any chance that such a feature could be implemented in the near future?
> Personally I don't have plans to do so. This is quite a corner case, and =
we
> generally prefer to expose only few defines/variables to keep things simp=
le.
> In a typical community network (Freifunk etc), 20s OGM timeout might be
> less than the TQ window size (5 entries * 5s originator interval), and
> create other problems. I don't see a general case where we want to change
> it, and I guess you have two options now (change the one line in the sour=
ce
> or indirectly use the gateway list), so that's satisified too. :)
>=20
> If there is more general interest to this, you can also write a patch if =
you
> like.
>=20
> Cheers,
>        Simon
>=20
> > Regards, Martin
> >=20
> > Sent from Proton Mail for iOS.
> >=20
> > -------- Original Message --------
> > On Thursday, 04/16/26 at 07:47 Simon Wunderlich <sw@simonwunderlich.de>
> > wrote: On Wednesday, April 15, 2026 5:10:23=E2=80=AFPM Central European=
 Summer
> > Time
> > Simon
> >=20
> > Wunderlich wrote:
> > > Hi Martin,
> > >=20
> > > On Tuesday, April 7, 2026 3:46:59=E2=80=AFPM Central European Summer =
Time
> > >=20
> > > martinvdberg@gmail.com wrote:
> > > > I think I have a similar use-case as the original poster and ran in=
to
> > > > the
> > > > same problem.
> > > >=20
> > > > Let me try to explain:
> > > >=20
> > > > - Given a mesh network where each node is assigned a *static IP*.
> > > > - In the mesh network there are some nodes acting as a Gateway.
> > > > - The other nodes in the mesh are clients.
> > > > - Using BATMAN-V
> > > >=20
> > > > Each client node has a script running, when it detects "batctl gwl"=
 to
> > > > elect another gateway, the script will set the gateway's IP-address=
 as
> > > > default route: "ip route replace default via $gateway_ip dev bat0".
> > > >=20
> > > > Now whenever a mesh-gateway is turned off, it will take 200 seconds
> > > > before
> > > > it is removed from the originators and only then "batctl gwl" will
> > > > elect
> > > > another gateway. This results in some client nodes have no internet
> > > > for
> > > > 200
> > > > seconds.
> > > >=20
> > > > So far, I haven't been able to get batman-adv (using batctl) to swi=
tch
> > > > to
> > > > another gateway sooner, e.g. after 10 or 20 seconds.
> > > >=20
> > > >=20
> > > > Using DHCP is not an option in my use-case.
> > > >=20
> > > > Is there somehow a way to reduce the 200 seconds? Possibly by
> > > > switching
> > > > to
> > > > BATMAN-IV?
> > > >=20
> > > > Regards, Martin
> > >=20
> > > that's an interesting use case, although I would like to make clear t=
hat
> > > the gateway feature was designed for DHCP in mind, yet you use it with
> > > static IPs. The main purpose was to re-route DHCP packets to the
> > > selected
> > > gateway. Nethertheless, you could still use this mechanism for
> > > "signaling".
> > >=20
> > > The gateway selection can be based on TQ or on bandwidth parameters, =
but
> > > there is no option to speed up the "dead marking" from the 200s of the
> > > originator timeout. you can decrease that number in the source code, =
but
> > > I
> > > would actually advise to use a completely different method independent
> > > of
> > > batman-adv - for example by using a layer 3 routing daemon, or another
> > > application which regularly signals their availability as a gateway. =
=46or
> > > DHCP (which it was originally designed for), lease times are typicall=
y 5
> > > minutes minmum, so the 200s timeout are not really a problem there ...
> > > but
> > > I acknowledge that it's not really useful for "fast" switching.
> >=20
> > Perhaps one more practical idea: You could parse the gateway list and t=
he
> > originator list yourself (batctl has json output options). Then, you co=
uld
> > get the "last seen" value from the originator list, and combine it with
> > your gatewaylist. In that way, you could easily filter the "best gateway
> > which was last seen <20 s" in a script. This doesn't help with batmans
> > internal DHCP forwarding, but since you use static IPs anyway and proba=
bly
> > already use a script to get the current gateway to look up the IP, this
> > may
> > be an easy fix ...
> >=20
> > Cheers,
> >=20
> >        Simon




