Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F61C0015E
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 13:50:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B05B9824B9
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 15:50:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690552206;
 b=M4YHB1COBDaoI6ozTeeVgRqY8ojKqqRZukg3EVrWlJ7pxB7ygso6yFPRiTszldR+hJgOY
 ev1n8UmBLreSS7jn35o3d9FY3G7Nb2C42mRdsn+F8xHk1cHuxYtJan94VNd41dqUEIBtC5G
 xYGP0nVQjP7t8DAPR1GyB5O/8sCXh54=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690552206; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=beUQirsMvfL7pIAGw8UPH+X8qz8ibMFPM/0HewqlhHM=;
 b=lYcMiQLJhy69qfvak71Aga2N8EBpfUfjAFK9bpVcaDq6wGNx7A9FtLJ9kg99la9M42L9Y
 AWsxrDNwEc6ZojifQgeYLWSHpiiyLnWm+UMdqev+Js7W8keBRdPJLqyS5Q5tGRhYxTThbyi
 NHhLpSwpQs4ud/1YW5VZOO9d2d4ljoU=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A337B800F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 28 Jul 2023 15:49:50 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690552190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=beUQirsMvfL7pIAGw8UPH+X8qz8ibMFPM/0HewqlhHM=;
	b=IWsJN0RteWmS1cjKjOkSS+fzVV4z+gjE5M0DUrCajeh69do9Ik/opAVvhWTLozXyjBGpmu
	r4M0+4DvP+iwegZZGCmdv+k/m26owzv9NL0EM8QzSnGineZKXDTYvmWK4XRRtwhROBQIcx
	P/U3XdErk2rTrLjIeFZs3FsmIw/pAJs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="QpAGFR/o";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690552190; a=rsa-sha256;
	cv=none;
	b=iscPtYJQgGTdu+fH/FR4w/e0dXrVs7c07h8amgZcjwpngY4vkGqod4tpIeawWguiGKTJPU
	ZDyrKvnPctdZ5yv+3ZXtMayxWvMdHE/W5FgecLwfpf3Ryr4SRJnEp57pma+36WZeFTVLuT
	nFfGPsSSOjTLWJPa9B7DaX0DwMDHdkI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690552190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beUQirsMvfL7pIAGw8UPH+X8qz8ibMFPM/0HewqlhHM=;
	b=QpAGFR/o+41x3t9rha6iw1qPxQh+42P177EVztTm3SxBjqpEka2CYRuNxbBGG5z6Q6tOyP
	Nh8gQDIFZRkEHa/E/3AQpmr7DF/RENtO3twpdKzGvSvH6w/ZIszfwfWOHzvs9Hk2rFOeod
	NXdjLqijb/3NaUZGju19tap9yVk2eQk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: 
 Re: [PATCH net] batman-adv: Do not get eth header before
 batadv_check_management_packet
Date: Fri, 28 Jul 2023 15:49:46 +0200
Message-ID: <10396914.nUPlyArG6x@sven-l14>
In-Reply-To: <20230728133850.5974-1-repk@triplefau.lt>
References: <20230728133850.5974-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2318948.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 2VMMEBSBTLF5FWTKFL7YQUVKGVKX4MXP
X-Message-ID-Hash: 2VMMEBSBTLF5FWTKFL7YQUVKGVKX4MXP
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2VMMEBSBTLF5FWTKFL7YQUVKGVKX4MXP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2318948.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 28 Jul 2023 15:49:46 +0200
Message-ID: <10396914.nUPlyArG6x@sven-l14>
In-Reply-To: <20230728133850.5974-1-repk@triplefau.lt>
References: <20230728133850.5974-1-repk@triplefau.lt>
MIME-Version: 1.0

On Fri, 28 Jul 2023 15:38:50 +0200, Remi Pommarel wrote:
> If received skb in batadv_v_elp_packet_recv or batadv_v_ogm_packet_recv
> is either cloned or non linearized then its data buffer will be
> reallocated by batadv_check_management_packet when skb_cow or
> skb_linearize get called. Thus geting ethernet header address inside
> skb data buffer before batadv_check_management_packet had any chance to
> reallocate it could lead to the following kernel panic:
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Do not get eth header before batadv_check_management_packet
      commit: eac27a41ab641de074655d2932fc7f8cdb446881

Kind regards,
	Sven

--nextPart2318948.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTDx3sACgkQXYcKB8Em
e0Y7nA//f+y3W/Key/lGHTIdz7e2o1AK1cskjKQSEK0MRZTG83aYw6UET5x70CSB
enh7GVx8/oVW5PJTRzgSevACLiY5TBmdVUsnvB15Jd/GjpgGR6+5d2qzlg3ljo7Y
qX9JkYEqCmbyaca0MrBooQJD0osnfI4Yp+06kaIlYPfhtM0D/Z+9vq2N6vt/6P78
iMR/aaRkMef9wsvCBF+Hqoo2fazSxb/4OBFsVS5HWvHHo0E30difswthoh794uO+
mnisBoitYzQAQ+EGbHM7rOGiymUl6KelZjOe7HCSlrhC0C6C6P5LWYUcegmW1B7w
Dnrni2OXXn2EurdjVVPLQWs9xOvUYbmf125e8aOwW/RAY7ZiTP4F+i1bYMe65TTW
UFCMUl86894QOo0aL7uZ+/aBV03M7kGUNQnLNWlpA9zlK5zr3dNtgpbJiOF1Z+NP
O/8+o5Ld7FjqaxAqK76xA8D5yY2BQMCW21n7M2CecoF4EeqngZ1gPOkq2KpIPFTC
AkEnhkUPa1nsvKUZRoBegYyHEzXqJQITmv5FtdihJLuFqHGS6WI7xEZ+zWJSJbIK
HEHyA6lfzzqK/hEPo5UcU8rKhdazz0rD8YqteDlVhB3g6jvAtFdLadOMU0qxL8qC
FoHL3B9xo8LU7SHEPufi8pLqfZLYeg49ix9Zx9ObzPfGl9v4Taw=
=Xu6Q
-----END PGP SIGNATURE-----

--nextPart2318948.iZASKD2KPV--



