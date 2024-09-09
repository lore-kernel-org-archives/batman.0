Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5988FECE57B
	for <batman@archiver.kernel.org>; Mon,  9 Sep 2024 09:30:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8315783C1F
	for <batman@archiver.kernel.org>; Mon,  9 Sep 2024 11:30:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725874224;
 b=tk5+kpn7TobQ39kBOfBm5EJ83m3q7mkSxyTV0ovyXABC1VjncDxZRrVH8RtyQU1M3lUfJ
 0UKUE2l1TZSz/m+EsGGAPGzOr3KvbqPoxXBMwwRYl38yNOLU0UIEgcs2ZxBOzPhAu/fCu22
 B1RQfGivqw4MJr+P6vnp+1LAA7e197s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725874224; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yQcNtpohyGYt7JRImHkD3n21yvAQDJRBAd/SGxU8fr0=;
 b=qPRg7VmLAtqPEm5lE7ardA5LlAQCDH4eYn81DiXYQKgilFPo0nYmvGy2fo1OZQ5RLHbXm
 qfd9KZNZnMB0Gr07ks/oRbZXHk55J8AL8qJcNNJURUrwBgV7DHY2SXUV7MDJsf9XKQyBavF
 sLWl562Fo3D584y3Lk+MlRrLj/CKUks=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BFA9C81F40
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Sep 2024 11:29:55 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725874195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yQcNtpohyGYt7JRImHkD3n21yvAQDJRBAd/SGxU8fr0=;
	b=d8BZd7IvusDF7+3rYOoZAD+Ud0fF+/+r4Wtkgxe4zk4ExDP7kxLgkLMgRFcxsO52Io6x+t
	IruwToP0cCzqmLSJ847BQHMg0ofxZPHYNzEHRIYv7aQUPCCI5W9wxnNs4d114tqojaDnCp
	GdpdGoKsfwSkBgddUlicOdfHAOxwJcA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725874195; a=rsa-sha256;
	cv=none;
	b=Tyb5MbNjJhdpbbRrfH9zMV6nyohxV1CimUrmgh/QipV1xvnUbmW14+eKykCz8gM5r7PJQY
	Xi3WsyPpgCC9kAhqH6VvXc1eF24jZctn6jvblcgRJ7Ff0LG8xBxJzL1U3iPEfdBn54ah3D
	si0fx2Wm0s6R7rru2jtc8BzWsKyQRBg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UmFqDxi7;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725874195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQcNtpohyGYt7JRImHkD3n21yvAQDJRBAd/SGxU8fr0=;
	b=UmFqDxi7W8OHY0OhxqGeyACTTtWW1n8gCsOP0BW6gZkBaSgkeemoTQ+UgQVlDWKZMseYu/
	IshGMKRqzcoYQEcDxdcGrjpsvJSjYWPs6Me9HNXQWe4+blom36jYJmX1dBoIL1phaQdGdC
	3kQZFZW1T+RRH0egAN89uCSjgA4/1b8=
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batctl: neighbor: Fix print neighbors table header
Date: Mon, 09 Sep 2024 11:29:48 +0200
Message-ID: <2953877.e9J7NaK4W3@ripper>
In-Reply-To: <172582484739.965.4055700225406232992@diktynna.open-mesh.org>
References: 
 <2343687.ElGaqSPkdT@sven-l14>
 <172582484739.965.4055700225406232992@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3309937.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: YT2XKSJ5SHST3H3W4KWRTRQXNBE6KHNS
X-Message-ID-Hash: YT2XKSJ5SHST3H3W4KWRTRQXNBE6KHNS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YT2XKSJ5SHST3H3W4KWRTRQXNBE6KHNS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3309937.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 09 Sep 2024 11:29:48 +0200
Message-ID: <2953877.e9J7NaK4W3@ripper>
MIME-Version: 1.0

On Sunday, 8 September 2024 21:47:27 CEST noahbpeterson1997@gmail.com wrote:
> > This is wrong, this is not what it outputs for the default B.A.T.M.A.N. IV:
> 
> Oops. I believe I now have this issue corrected. I copied the routing algorithm checking code from the netlink_print_gateways() function in gateways.c and change the header accordingly. Let me know if I should revert the change in README.rst.

Doesn't apply:

    patching file README.rst
    patching file neighbors.c
    Hunk #2 FAILED at 120.
    1 out of 2 hunks FAILED -- saving rejects to file neighbors.c.rej

And you need to resubmit it as proper patch in a separate thread with
"[PATCH v2]" (instead of "[PATCH]") at the start of the Subject.

> Let me know if I should revert the change in README.rst.

Yes, please revert it. And I don't want to read stuff like "The examples in 
the README.rst are updated too." - which is a rather obvious information.

And regarding "netlink_print_neighbors() now prints the correct header to 
match what batman-advanced currently outputs." The first part is trivial (but 
incorrect) and the last part doesn't make any sense. Please describe instead 
what the problem was and what the idea behind the fix is. And potential other 
information which might be helpful to understand the context for future 
persons stumbling over your change.

Kind regards,
	Sven
--nextPart3309937.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZt7ADAAKCRBND3cr0xT1
y09lAQCfbBXquGUl/vKgXoDGGAAI4F+ImilwtDYw2cUIFvRNOAEAoEQ+3JEeuk0U
g2ot6AcMNmZyu80RLzxt6TDaaIz59g0=
=FIqm
-----END PGP SIGNATURE-----

--nextPart3309937.aeNJFYEL58--



