Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF6BE77188
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 10:09:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C94783F6D
	for <batman@archiver.kernel.org>; Tue, 31 Dec 2024 11:09:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735639761;
 b=3p+knVp/HNNnX9Kxi/1wC/HcMN8akLNzQBgzDlJCkstKdfz9uLvN2RR2tValoEG0hkP7e
 uDu/rhN/H9t/jo6mL25BaBPgR+OYZqF+GTAyupeUc23oEE3vWWHbQ9lt4k+P0bje8hnNpOJ
 mfkpLDpqjfZypU9qHJyhTa7Lxg/0phc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735639761; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=upgbQ/wtK5DfvcZNP4GQxa4I5LKAJWgqHkQ2M+3VYGE=;
 b=snTRzJfoUmHnJ8hdFiOBSPBVXO97s6FOBu205t3drPJOAwtvjgH079VXybXR9DJN62j3B
 T5P7GphMoLBWKDL6wuNmohfV1TlShAbo6QY9LIRSeVZoIkcSjJ+o6TGUf0rhFlM68eLsXqu
 d0t0O6AxWoCuAEU3OQlmVPK+VcVPGPU=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EA03C82F33
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 31 Dec 2024 11:09:03 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735639744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=upgbQ/wtK5DfvcZNP4GQxa4I5LKAJWgqHkQ2M+3VYGE=;
	b=ifIGQVxw7stW/e4wVtOV4pkYqA/MCdHiUqIfD5v7ZnNnwnu8f+iq6sQKUqKFX+x47f+0hl
	6fMD7HGz03tNg8XFTzm4Wvs1IWLKJMHvvhGjKONjNXiN6ct1cXulNQTrOhepOqe9hir8wU
	Tyu72uDpBQVm5kxqApagQH2Xc4HxP0s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="HA/woGb2";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735639744; a=rsa-sha256;
	cv=none;
	b=pyzlshYDtoFxrZbQ++aluQ6hAAh0vjZV7QuKXH/zrN3XR2zhscZgM3FVxc4Mi/QjqUej1y
	xnX7SWrjrDsdszC6/DRshbnGnB5CH5DjsiEuhmvGtEWVT+wLWb+PHd00G9Ld1fqLNGnMFR
	XzKzRFUl+4Up7VSNEr0908wFLn1j5s8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735639743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upgbQ/wtK5DfvcZNP4GQxa4I5LKAJWgqHkQ2M+3VYGE=;
	b=HA/woGb2Y7AS0D6hsaEjp2zJIek3qudcqEGwJCQ1ACU+M8yLwGW/WYO7iDcuOR7Wqrp/Gm
	slquvpbVm3PYGYkda6UbBotCAap2oD/J6eAX08QvDSViLR2Nr4zAA/i4lsLPg+4Kk4RxRm
	kwknhHe27vUXqMjrazaQCtc0qXPSDtk=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: Re: [PATCH v2] batctl: ping: Add subsecond precision to ping interval
Date: Tue, 31 Dec 2024 11:08:59 +0100
Message-ID: <3856697.kQq0lBPeGt@sven-l14>
In-Reply-To: <20241225032724.29814-1-NoahBPeterson1997@gmail.com>
References: <20241225032724.29814-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3609184.iIbC2pHGDl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TFKZO7RZBYUSNM6HXXLBSUTLRF2KASZR
X-Message-ID-Hash: TFKZO7RZBYUSNM6HXXLBSUTLRF2KASZR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TFKZO7RZBYUSNM6HXXLBSUTLRF2KASZR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3609184.iIbC2pHGDl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Date: Tue, 31 Dec 2024 11:08:59 +0100
Message-ID: <3856697.kQq0lBPeGt@sven-l14>
In-Reply-To: <20241225032724.29814-1-NoahBPeterson1997@gmail.com>
References: <20241225032724.29814-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Wednesday, 25 December 2024 04:27:24 GMT+1 Noah Peterson wrote:
> Modify the batctl ping utility to accept both integer and floating-point
> values for the interval between sending pings. This enhancement allows
> specifying intervals with subsecond precision.
>=20
> For example:
> `sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`
>=20
> Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
> ---
> v2: Fixing use-after-free, adding a missing header file, noted by Sven
> <sven@narfation.org>

This patch doesn't apply:

$ git rev-parse HEAD
60ff59118fd7f007adae1cc77ce9b268e3c977ce

$ b4 shazam -s 20241225032724.29814-1-NoahBPeterson1997@gmail.com
Grabbing thread from lore.kernel.org/all/20241225032724.29814-1-NoahBPeters=
on1997@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
=2D--
  =E2=9C=93 [PATCH v2] batctl: ping: Add subsecond precision to ping interv=
al
    + Signed-off-by: Sven Eckelmann <sven@narfation.org>
  ---
  =E2=9C=93 Signed: DKIM/gmail.com
=2D--
Total patches: 1
=2D--
Applying: batctl: ping: Add subsecond precision to ping interval
Patch failed at 0001 batctl: ping: Add subsecond precision to ping interval
error: patch failed: ping.c:65
error: ping.c: patch does not apply
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config advice.mergeConflict false"



$ patch -p1 -i .git/rebase-apply/patch                                     =
     =20
patching file ping.c
Hunk #1 succeeded at 19 (offset -2 lines).
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 87.
Hunk #4 succeeded at 302 (offset 16 lines).
2 out of 4 hunks FAILED -- saving rejects to file ping.c.rej


$ cat ping.c.rej
=2D-- ping.c
+++ ping.c
@@ -66,14 +67,15 @@ static int ping(struct state *state, int argc, char **a=
rgv)
        struct bat_host *bat_host, *rr_host;
        ssize_t read_len;
        int ret =3D EXIT_FAILURE, res, optchar, found_args =3D 1;
=2D       int loop_count =3D -1, loop_interval =3D 0, timeout =3D 1, rr =3D=
 0, i;
+       int loop_count =3D -1, timeout =3D 1, rr =3D 0, i;
        unsigned int seq_counter =3D 0, packets_out =3D 0, packets_in =3D 0=
, packets_loss;
=2D       char *dst_string, *mac_string, *rr_string;
=2D       double time_delta;
+       char *dst_string, *mac_string, *rr_string, *end =3D NULL;
+       double time_delta, ping_interval, integral_part, fractional_part =
=3D 0.0;
        float min =3D 0.0, max =3D 0.0, avg =3D 0.0, mdev =3D 0.0;
        uint8_t last_rr_cur =3D 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
        size_t packet_len;
        int disable_translate_mac =3D 0;
+       struct timespec loop_interval =3D {0, 0};
=20
        while ((optchar =3D getopt(argc, argv, "hc:i:t:RT")) !=3D -1) {
                switch (optchar) {
@@ -87,9 +89,17 @@ static int ping(struct state *state, int argc, char **ar=
gv)
                        ping_usage();
                        return EXIT_SUCCESS;
                case 'i':
=2D                       loop_interval =3D strtol(optarg, NULL , 10);
=2D                       if (loop_interval < 1)
=2D                               loop_interval =3D 1;
+                       errno =3D 0;
+                       ping_interval =3D strtod(optarg, &end);
+                       if (errno) {
+                               fprintf(stderr, "Error - invalid ping inter=
val '%s'\n", optarg);
+                               goto out;
+                       } else {
+                               ping_interval =3D fmax(ping_interval, 0.001=
);
+                       }
+                       fractional_part =3D modf(ping_interval, &integral_p=
art);
+                       loop_interval.tv_sec =3D (time_t)integral_part;
+                       loop_interval.tv_nsec =3D (long)(fractional_part * =
1000000000l);
                        found_args +=3D ((*((char*)(optarg - 1)) =3D=3D opt=
char ) ? 1 : 2);
                        break;
                case 't'


It looks like you're changes were based on a version of batctl which was fr=
om=20
2024-10-19 or older.


> ---
>  ping.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/ping.c b/ping.c
> index 52bce4d..a69b6ac 100644
> --- a/ping.c
> +++ b/ping.c
> @@ -21,6 +21,7 @@
>  #include <stdint.h>
>  #include <sys/select.h>
>  #include <sys/time.h>
> +#include <time.h>
>  #include <netinet/if_ether.h>
> =20
>  #include "batadv_packet_compat.h"
> @@ -65,14 +66,15 @@ static int ping(struct state *state, int argc, char *=
*argv)
>  	struct bat_host *bat_host, *rr_host;
>  	ssize_t read_len;
>  	int ret =3D EXIT_FAILURE, res, optchar, found_args =3D 1;
> -	int loop_count =3D -1, loop_interval =3D 0, timeout =3D 1, rr =3D 0, i;
> +	int loop_count =3D -1, timeout =3D 1, rr =3D 0, i;
>  	unsigned int seq_counter =3D 0, packets_out =3D 0, packets_in =3D 0, pa=
ckets_loss;
> -	char *dst_string, *mac_string, *rr_string;
> -	double time_delta;
> +	char *dst_string, *mac_string, *rr_string, *end =3D NULL;
> +	double time_delta, ping_interval, integral_part, fractional_part =3D 0.=
0;
>  	float min =3D 0.0, max =3D 0.0, avg =3D 0.0, mdev =3D 0.0;
>  	uint8_t last_rr_cur =3D 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
>  	size_t packet_len;
>  	int disable_translate_mac =3D 0;
> +	struct timespec loop_interval =3D {0, 0};

This is one of the reasons why your patch doesn't apply. When you rebase it=
 on=20
the newest version, please try to use the reverse X-mas tree order and avoi=
d=20
multiple declarations per line.

Kind regards,
	Sven
--nextPart3609184.iIbC2pHGDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3PCuwAKCRBND3cr0xT1
y70YAP4lCgB7+PhFvTgzRGXHVN48HMaqWvkYcKOaCZE8Bj27ygD8CeidXf2cU5Am
OrgZn9MrCccOJTrW2AkGOuVhLtUtDgg=
=On8v
-----END PGP SIGNATURE-----

--nextPart3609184.iIbC2pHGDl--



