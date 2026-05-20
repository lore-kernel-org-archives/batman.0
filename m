Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12DBCD5BA4
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 08:17:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0447A818A3
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 10:17:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779265026;
 b=x6TsJArpoGsJS4pGAmFd5kS/n1VghjZSebQ6IyBzZCa+SHva6D4pH4dkutqk61qRmdMC4
 9YJicXfVRXGeMuiD+j3cG7YXNpO8Zh8H/7Wp1N2pfmVWhmPHCW9bgjBrTxhxa3YfgpAd6gZ
 LcfheIggdztYu0BJQj1bu5EkTfB34ZA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779265026; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bHfGMh4pefjZO5sb8M/ALllLw/5Oe8GAxPgoxjMl0gM=;
 b=3SCq/DfghLGbWIsUGvxmjTUliXm2QCL4buD43WF1kW8nf1BSv212EdxA4rPclENaZn+HG
 s4MGSvB0/x+yVps3lpSa+DKrORCftY6SrmTW+nizXQS2TjXK505RUKz2gqptDQsKSaguoxc
 b403d3CHE/4jJyXOvM/8FoLuvNd/HnY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE7BE8032E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 10:16:30 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779264991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bHfGMh4pefjZO5sb8M/ALllLw/5Oe8GAxPgoxjMl0gM=;
	b=BNeMS1o7NTqIS6kIAkXAF89rYGSLafXmdOdSMbkiXirlp9pX5zzlDvS2B8bRJ874a3h2ob
	KSml1UEXoG5aXYCEk/3ScNvH67a7lrxEpuZS4L/rlwikr3tzb3kR1kEIAQWUvMUE8hvA6f
	8Jn/M+Gtd26aUhseO2dK4qAMbcIsm9E=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779264991;
	b=dtkhR7bZV1WtHoXuv2Y7Ytvfdetoo5qI+A+dR9phk61X6vcHrwmNY1o4e/7s7x5HAY8InP
	km+tgEb+jwkcpf4ZRDlw6YtHpozTI3gVYZkhHlOJugIeT+f0xmPVr4juA3Lu+ASUUSjOb3
	PwYFeQSvOTNLVVJnsMsUetmgrRK0XRM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="eMKc7po/";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779264989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHfGMh4pefjZO5sb8M/ALllLw/5Oe8GAxPgoxjMl0gM=;
	b=eMKc7po/bwYIgREiHDJjH0oyM/3rFUOiKl3jtcEN93e0FWAaflZU5ic5Jlvic3E3j7WwTa
	H0/eFTJEJHyHg+ggRCKThCGTZyBazjQ/fQZOipef3MTHZ6zDhnRpmM+TcWB9frpRedW/Yg
	lzWtynXHH1UQW8XEHNmQDIeRJ4Dnhqwc3Bk00oojlCpr+hetpoEFRO9UeH8ZuvFW8WGvUB
	h66oDH3yIt8ZxBU2xWyj/AM22RMmvTuRQUkat8OTC1NHOgyKP7mUWI7LlOqKZPibaCxHB6
	VpluXDJZ6IxlPhmLpaZHSB++GQ8qin3iuYA14Ye/C6M4W9rtJQGDMjI2xtuoeQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH RFC batadv v2 4/5] batman-adv: limit numbers of parallel
 learned
 BLA backbones
Date: Wed, 20 May 2026 10:16:29 +0200
Message-ID: <48092628.fMDQidcC6G@prime>
In-Reply-To: <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
 <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: MIWHTGVHKDUOR2ELSDZH6WOJYK25DDYN
X-Message-ID-Hash: MIWHTGVHKDUOR2ELSDZH6WOJYK25DDYN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MIWHTGVHKDUOR2ELSDZH6WOJYK25DDYN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This looks mostly good and I like the approach in general!

commit message: batman-adv: limit numbers of parallel learned BLA backbones

numbers -> number

On Tuesday, May 19, 2026 9:02:18=E2=80=AFAM Central European Summer Time Sv=
en=20
Eckelmann wrote:
> A malicious actor behind one bridge port may spam the kernel with OGMs wi=
th
> a random source MAC address, each of which will create a BLA backbone, ea=
ch
> of which is a dynamic allocation in the kernel. This will at some point
> exhaust the available memory.

To get backbone gateways, spamming OGMs is not sufficient (or not even=20
necessary), but BLA claims and/or BLA announcements need to be sent (with t=
he=20
same group ID or need to exist on the mesh) on the backbone Ethernet.=20

Just sending OGMs will not create backbone GWs, so I think this commit mess=
age=20
needs to be revised (you already said it's a placeholder, so I think those =
are=20
the specifics for this counter ;] ).

>=20
> Mitigate this by maintaining a per meshif count of those automatically
> generated entries in orig_learned, and a limit in orig_max_learned. If the
> limit is hit new entries are not learned anymore.
>=20
> For backwards compatibility, the default setting of 0 disables the limit.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> [...]
> ---
>  include/uapi/linux/batman_adv.h        |  6 ++++++
>  net/batman-adv/bridge_loop_avoidance.c | 11 +++++++++++
>  net/batman-adv/mesh-interface.c        |  3 +++
>  net/batman-adv/netlink.c               | 10 ++++++++++
>  net/batman-adv/types.h                 |  6 ++++++
>  5 files changed, 36 insertions(+)
>=20
> diff --git a/include/uapi/linux/batman_adv.h
> b/include/uapi/linux/batman_adv.h index cca87d42..4188d83c 100644
> --- a/include/uapi/linux/batman_adv.h
> +++ b/include/uapi/linux/batman_adv.h
> @@ -499,6 +499,12 @@ enum batadv_nl_attrs {
>  	 */
>  	BATADV_ATTR_DAT_MAX_LEARNED,
>=20
> +	/**
> +	 * @BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED: defines the maximum=20
number of
> BLA backbone=20

number of BLA backbones (add the s)

> +	 * which can be learned in parallel
> +	 */
> +	BATADV_ATTR_BLA_BACKBONE_MAX_LEARNED,
> +
>  	/* add attributes above here, update the policy in netlink.c */
>=20
>  	/**
> diff --git a/net/batman-adv/bridge_loop_avoidance.c
> b/net/batman-adv/bridge_loop_avoidance.c index cec11f12..8bb8dec6 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -494,6 +494,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_pr=
iv,
> const u8 *orig, {
>  	struct batadv_bla_backbone_gw *entry;
>  	struct batadv_orig_node *orig_node;
> +	u32 bla_backbone_max_learned;
> +	int bla_backbone_learned;
>  	int hash_added;
>=20
>  	entry =3D batadv_backbone_hash_find(bat_priv, orig, vid);
> @@ -505,6 +507,11 @@ batadv_bla_get_backbone_gw(struct batadv_priv
> *bat_priv, const u8 *orig, "%s(): not found (%pM, %d), creating new
> entry\n", __func__, orig, batadv_print_vid(vid));
>=20
> +	bla_backbone_max_learned =3D READ_ONCE(bat_priv-
>bla_backbone_max_learned);
> +	bla_backbone_learned =3D atomic_read(&bat_priv-
>bla_backbone_learned);
> +	if (bla_backbone_max_learned && bla_backbone_learned >=3D
> bla_backbone_max_learned) +		return NULL;
> +

I think we should always allow "own backbones" to pass. This could be done =
by=20
adding an exception in this check.

If (for some, probably unlikely reason) an attacker fills up the table befo=
re=20
the own backbone is registered, this may create problems on many other=20
occurences.

>  	entry =3D kzalloc_obj(*entry, GFP_ATOMIC);
>  	if (!entry)
>  		return NULL;

> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1656,6 +1656,12 @@ struct batadv_priv {
>  	atomic_t orig_learned;
>=20
>  #ifdef CONFIG_BATMAN_ADV_BLA
> +	/** @bla_backbone_max_learned: Maximum number of backbone_gw */
> +	u32 bla_backbone_max_learned;
> +
> +	/** @bla_backbone_learned: current number of learned backbone_gw=20
entries
> */ +	atomic_t bla_backbone_learned;
> +

should this go into batadv_priv_bla or along the other counters in=20
batadv_priv? I'm fine either way.

Thank you!
        Simon

>  	/** @bla: bridge loop avoidance data */
>  	struct batadv_priv_bla bla;
>  #endif




