Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3151BECE582
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 08:45:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A40983D47
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 10:45:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725957924;
 b=NpLAM31AT66hMEvjSUIxfaroERLjJR3EJzOV6Ci8z95r5bk2yDKJGuKnRtHQk6JsJHTZY
 ueBlzn57JIMynMv8HhlsheIyfAOcSD4SlS0o5Cpo8YKTzkw48CIuPc63oRyqP57mCo/7LGM
 eE8x9LsQ1HFYl24hQ6E0rZmdrwkOI6c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725957924; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RDpw8Mrtojim7AeOGFK4ZnmV3b1Yx2A1OkRzDldjOmw=;
 b=OIrFKIu+C74tUjbwKeLlqbvx5Wtq8S6Dejku/nni+Bol6M3NQToBBwOHbE5BbLu6r7q/X
 P2LYdT8oFp9Y9lKugKU7REioylk0vYZHVjPyY2X26CrypdOU/9+En1HRfw8lP/oUNORnUQD
 vH7lMpdjKJnde2VaPy+1W9Rz1gKsfZg=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 00FED80401
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 10:44:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725957887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RDpw8Mrtojim7AeOGFK4ZnmV3b1Yx2A1OkRzDldjOmw=;
	b=Nko83+3+TANaAylagSDVtcXT1iSzeP71PFh2zrIVR8zFe5M0Hs+IQmGrTLotleSmRRIQ3L
	d+idL7dXHj/wymYYQI5qJAGjAk1ls8A33Bgp4aDDUNgwDF6CQFISJJhMO9ecODda8hajlI
	u6TbUaJ9/MwqCsBAdZFJHFyFlPQyqW0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=x7ZK53pc;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725957887; a=rsa-sha256;
	cv=none;
	b=0qjtkAYrIIlkXmEo66JJrhugIdZzXIQ87ZsvRXSL3RBYAtbFtH/cx6RmVNPk7tB7aHVnIM
	6j7/71qdpwgftDDEgYPzGUe5mso4UwEhnwPdxhRY95f0JFeWAN5gGMixBHyoW4WmCAVMOm
	YjgnJ2T9z+XfgKafnH6ERsL0TVSO31c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725957886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDpw8Mrtojim7AeOGFK4ZnmV3b1Yx2A1OkRzDldjOmw=;
	b=x7ZK53pcDv1KVAvHPHm5RLPNUy/Lyd+KRwaVSKVYA8JHJiy5hkXyGZiqkheGGK7B4qBxa9
	Ppgov2kC/H2PeDWUdcBh0v6K+xaokBR6aQae/1Nj5d0s0/PkyNxDxgUq8T0O1A9WPwCywd
	rDeW9FPvnZ9S7tN5adNWv/kDDL7lmWY=
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v2] batctl: Dynamically select header format in
 netlink_print_neighbors
Date: Tue, 10 Sep 2024 10:44:43 +0200
Message-ID: <2622720.Lt9SDvczpP@ripper>
In-Reply-To: <172593883400.1027.14861329029277869493@diktynna.open-mesh.org>
References: <172593883400.1027.14861329029277869493@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4373178.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 6KGWTEJJGQTLKOUY6U6ZKLK4KDNVMW6S
X-Message-ID-Hash: 6KGWTEJJGQTLKOUY6U6ZKLK4KDNVMW6S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6KGWTEJJGQTLKOUY6U6ZKLK4KDNVMW6S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4373178.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 10 Sep 2024 10:44:43 +0200
Message-ID: <2622720.Lt9SDvczpP@ripper>
MIME-Version: 1.0

On Tuesday, 10 September 2024 05:27:14 CEST noahbpeterson1997@gmail.com wrote:

You must have a proper "From:" in your patch mail - not only your mail 
address. And it should match your Signed-off-by line.

> The netlink_print_neighbors() function previously used a static header format, which did not account for variations between the neighbor list output from different BATMAN routing algorithms (BATMAN_IV vs. BATMAN_V).
> 
> This patch introduces a dynamic header selection mechanism that adjusts the output format based on the active routing algorithm:
> - For BATMAN_IV, the header is set to "IF             Neighbor              last-seen".
> - For BATMAN_V, it changes to "         Neighbor   last-seen      speed           IF".

Please don't use overlong lines in the commit message. We normally use the 75 
chars per line limit from Linux's checkpatch.

> 
> This change ensures that the table header output in `batctl n` is accurate for both BATMAN routing algorithms.
> Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>

Newline missing between your commit message and the Sob line.

> ---

Changelog for v2 is missing. You can use tools like b4 [1] to improve your 
patch workflow.

>  neighbors.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> diff --git a/neighbors.c b/neighbors.c
> index 3102b0e..f34952b 100644
> --- a/neighbors.c
> +++ b/neighbors.c
> @@ -6,6 +6,7 @@
>   * License-Filename: LICENSES/preferred/GPL-2.0
>   */
>  
> +#include <errno.h>
>  #include <net/if.h>
>  #include <netinet/if_ether.h>
>  #include <netlink/netlink.h>
> @@ -119,9 +120,28 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
>  				   int read_opts, float orig_timeout,
>  				   float watch_interval)
>  {
> +	char *header = NULL;
> +	char *info_header;
> +
> +	/* only parse routing algorithm name */
> +	last_err = -EINVAL;
> +	info_header = netlink_get_info(state, BATADV_CMD_GET_ORIGINATORS, NULL);
> +	free(info_header);
> +
> +	if (strlen(algo_name_buf) == 0)
> +		return last_err;
> +
> +	if (!strcmp("BATMAN_IV", algo_name_buf))
> +		header = "IF             Neighbor              last-seen\n";
> +	if (!strcmp("BATMAN_V", algo_name_buf))
> +		header = "         Neighbor   last-seen      speed           IF\n";
> +
> +	if (!header)
> +		return -EINVAL;
> +
>  	return netlink_print_common(state, orig_iface, read_opts,
>  				    orig_timeout, watch_interval,
> -				    "IF             Neighbor              last-seen\n",
> +				    header,
>  				    BATADV_CMD_GET_NEIGHBORS,
>  				    neighbors_callback);
>  }
> 

[1] https://b4.docs.kernel.org/


--nextPart4373178.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZuAG+wAKCRBND3cr0xT1
y+bwAQCK70ZBIR/4yTNP8p6I+U5mYbCHybxWHv5EZgpO8KmohgEArjyK/Q8PpHVG
ucEP4GyB+cYOWqsiLEX+HroSaRc8JwI=
=wqhA
-----END PGP SIGNATURE-----

--nextPart4373178.ejJDZkT8p0--



