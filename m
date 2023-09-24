Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4D6CE7A88
	for <batman-adv@archiver.kernel.org>; Sun, 24 Sep 2023 10:48:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2855683424
	for <batman-adv@archiver.kernel.org>; Sun, 24 Sep 2023 12:48:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695552484;
 b=nzT4KtCcnHMomhh7sHR8gb0dZDyqP+UrGGJAbCQJNO+Di+xtE6CoWjDUCmGktFA5wQYf0
 6+DNJHkIfeGNbRWouqx7dFMA9ddIBct8+Cmdp0eO1BahtApoOdBW2lSsDrGdmBcBpOjPdnN
 hav1YB/CP8ozAJ7JS42aYJPzSWsH8Gg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695552484; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gizk12ouwe087JBHyZZ5ngnI8Z6KrN+ve/BJqlO87W8=;
 b=aR7Q/6Bl0CgTpWNwA41n9kQPC+mlvK74dwmq1/vOFIHpE8koFAL+ATQUrbNNfpXlJ+GoK
 pBF/IExDYPE+9baS81bsjrn9IuTdPQ3kPANO1hUY7peeIgNTXEKpm+ry/jIlYD6y12UzHu/
 K1Rf+ymi7WJnqaPrHzd+yh+2QVzsDPs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A6AF780EAA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 24 Sep 2023 12:47:44 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695552464; a=rsa-sha256;
	cv=none;
	b=bucOIdwAYg1kD22dL001+NNugary4u2a0yBU7TxdVdPrcE8kHE1QJtwbShxLSiR1ySs0ma
	UCNzSGneie+Rl4OImPzqMosMfYpW6f+ySnPebqODcDee0rxXLrXbzTYsFI1yOwhpTpNXC3
	ngO9/dIvyUczP5uJ/UFUOSAybn+p5ys=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0CagPa9U;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695552464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gizk12ouwe087JBHyZZ5ngnI8Z6KrN+ve/BJqlO87W8=;
	b=xspM2PovHlqo+2cQJOyqYjviPJkUJCSEOzy+4vkbT+6Ge2vn5AomId6EK78LbMEkYAgFpw
	H4NXKSJHI/RZwq0OSNEF3gvND2DL8XBCCwPPwl15aWcr6c0kKpxHKoqQkE1f8g78xCqOdD
	3ENZiWqMYpbRT3/gE2/yLaVJzGYy9SU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1695552464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gizk12ouwe087JBHyZZ5ngnI8Z6KrN+ve/BJqlO87W8=;
	b=0CagPa9UoGUrqejRCekJSWoGLfXOpL+DY3/ApyzR3H+KdOWYUmIdoHMUXc2asQUXlXo2Es
	yLj+hwLIJuLoPPzTyDyn/MHso+/CbwzOJ8Gm9XHI35Df+T2+NOhXijI2/WkC6fwUy70kR/
	Atvy0Pquj0qN4+QKL0/MwUplpRJeppc=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v7 0/3] Implementation of a Stateless Multicast Packet Type
Date: Sun, 24 Sep 2023 12:47:34 +0200
Message-ID: <2193621.Icojqenx9y@sven-l14>
In-Reply-To: <20230907010910.22427-1-linus.luessing@c0d3.blue>
References: <20230907010910.22427-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart113064995.nniJfEyVGO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: Q67AEORAZIRBIPHSGDIF7OSJVP3D3YBE
X-Message-ID-Hash: Q67AEORAZIRBIPHSGDIF7OSJVP3D3YBE
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q67AEORAZIRBIPHSGDIF7OSJVP3D3YBE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart113064995.nniJfEyVGO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 24 Sep 2023 12:47:34 +0200
Message-ID: <2193621.Icojqenx9y@sven-l14>
In-Reply-To: <20230907010910.22427-1-linus.luessing@c0d3.blue>
References: <20230907010910.22427-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, 7 September 2023 03:09:07 CEST Linus L=FCssing wrote:
[...]
> Changelog v7:
> * PATCH 1/3:
>   * rebased to current main/master branch (resolved net/multicast/routing=
=2Eh)

Are you trying to take over batman-adv and make it the *multicast* mesh=20
protocol? :D

>   * renamed batadv_mcast_forw_orig_to_neigh() to
>     batadv_orig_to_router() and moved it to originator.c, for
>     reuse in fragmentation.c

=46or this, you should also remove routing.h from fragmentation.c in patch =
1.=20
Same for multicast_forw.c

I have already queued it up in linux-merge with these changes


> * PATCH 3/3:

@Simon, can you please also check the remaining code changes? To quickly=20
identify modifications, you can use

    pipx install b4
    # in you batman-adv repo
    b4 diff -- 20230907010910.22427-2-linus.luessing@c0d3.blue

>   * simplified batadv_mcast_forw_shrink_pack_dests():
>     moved parts to new sub function batadv_mcast_forw_shrink_fill(),
>     removed keeping track of filler over the whole function
>     (might be slower, as we might check+skip the same zero
>      MAC entry multiple times, for each slot, but a lot easier
>      to read - and we don't prioritize performance with this
>      patchset yet)


Independent of the outcome for this patchset, something like this would oft=
en=20
be implemented by starting the search on one side of an array and get the=20
replacement from the other side of the array - and when start and end
overlap then the algorithm stops. At least for me, it is easier to
comprehend than some filler which needs to be pushed forward and is influen=
ced=20
by a variable which is (unexpectedly) modified inside a macro:

    #! /usr/bin/env python3

    from random import randint


    # initialize test array
    def random_array():
        slots =3D []
        for i in range(100):
            slots.append(randint(0, 5))

        return slots


    # searches from the end towards the empty slot for fillers (non-zero)
    #
    # returns a non-zero entry if return value > empty_slot
    def find_filler(slots, empty_slot, end):
        while end > empty_slot:
            if slots[end] !=3D 0:
                break

            end -=3D 1

        return end


    # searches from the front for empty entries and replaces them with
    # non-empty entries from the end
    #
    # returns number of non-empty entries
    def move_empty_to_end(slots):
        non_empty =3D 0
        start =3D 0
        length =3D len(slots)
        end =3D length - 1

        # replace empty entries at the beginning with non-empty from end
        while start < end:
            # ignore non-empty entries at the start
            if slots[start] !=3D 0:
                start +=3D 1
                non_empty +=3D 1
                continue

            # find replacement at end
            new_end =3D find_filler(slots, start, end)
            if new_end <=3D start:
                # no replacement found
                break

            # move non-empty entry from end to start
            slots[start] =3D slots[new_end]
            end =3D new_end - 1
            slots[new_end] =3D 0


        # count remaining non-empty
        for i in range(start, length):
            if slots[i] =3D=3D 0:
                break

            non_empty +=3D 1

        return non_empty
       =20

    slots =3D random_array()
    count_non_empty =3D move_empty_to_end(slots)

    # just to make sure that everything is empty
    print(slots[count_non_empty:])

    # memmove simulator :)
    slots =3D slots[:count_non_empty]

    # just to see the non-empty entries
    print(slots)


While the natural way would actually be to move non-empty entries to the en=
d=20
(and then only move the header), your implementation needs them at the star=
t.=20
So I did it similar in this PoC.

Kind regards,
	Sven
--nextPart113064995.nniJfEyVGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmUQE8cACgkQXYcKB8Em
e0ZBcxAAubkBY5SpWaAorbDA/iooStyoooiPip1ebznQxR8wmegWtbNYwbEti4by
9upU0FsBR8SSNDsd1Lx/3uqBAcC73li1EDCFzq+DaBBL3E1UGCvK1XGm1OZ2sBrO
LCn3cMzpHDlCNEyG5dfo2mBhqBqK92gll8UyeWrY6F8iD7Fi9bTMpsURZON3xJmK
jfL/EMCeyHZvgT/yumxsaXIaLUPT/H88qDhopFrfiXxS0032JbV8ehpuA3g48FkF
VhAU4LtyupLkxB0sI+omzs9LVBo/+qhkzpo1w+NewUf01EdfEz1Oc3XT0F748OCY
pCGxGvGbU2pmj1qAxdhi6s6dpRG8jTtoIo490xKtWq2q9aO+8A4ywvda4sRjWJNm
1CF7R/R0WCsyA7i42GQXXofy0unWtKDTCM3UrMpF1z0i37bsUQPnip147Z7vCTFp
2Fln6SHTBFacmdfxAI/hjSCNlThP5K+vbKIrZIbyITqJj92Ky5IKqZEfRQnmielW
Ob8FIsnGI5U7KQbPM5tk+MWFLoaw8ovq01wAWDkVTMEbFwDpcG5vNBtEMBT6ZwKp
ZrE0mQ8E1fDHqB1ede3bzcpAL341ChGMmTVnOpAiFKjuTe4qW7iRBq5F+XP3Q1rD
IQSLDdeHjGbpwzAoCze48xUUEXKOxHffbMs1poJyUjD/xJ+pY0U=
=JWI6
-----END PGP SIGNATURE-----

--nextPart113064995.nniJfEyVGO--



