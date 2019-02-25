Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Feb 2019 15:19:26 +0100
Message-ID: <6182329.DCpKyEnyDW@bentobox>
In-Reply-To: <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
 <1711580.CLzo8a4Rc7@sven-edge>
 <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6927204.24ZBchiv0l";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fwd: nodes start disappearing after a certain
 node count
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: umut deniz <umut.deniz@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart6927204.24ZBchiv0l
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 February 2019 15:06:21 CET umut deniz wrote:
[...]
> Thank your for your swift reply and advice. As you said TI supports limited
> number of peers with its driver and hardware in mesh mode. According to TI
> documentation it is 32 nodes.

I think this is the number of nodes in a complete 802.11s mesh. This doesn't 
mean that it supports these number of direct peers  the driver can't even 
represent more than 16 direct peers/links in its structures. I heard something 
of 10 peers supported by the firmware when running in AP mode. Most likely 
lower or equal in meshpoint mode.

And maybe it also needs some special peers to work correctly. Wouldn't be the 
first firmware which needs such kind of hacks.

> The question bogging my mind is how could the
> < :#iw dev adhoc0 station dump > command return 6 active and plink established
> nodes (with inactive times around 80ms) while batman-adv's last-seen is
> increasing till timeout occurs on all neighbors and after timeout iw station
> dump still reports the same active stations (with inactive times around 80ms).
> Am I missing something to debug or a log to look in to or a configuration
> tied with batman-adv needed to be made.

If the last time increases, this means that the lower link doesn't do correct 
broadcast anymore between the peers. The numbers you see in iw can be from any 
kind of frame (there might be exceptions - check the ieee80211 subsystem for 
details).

This can either be a bug in the TI firmware or driver or maybe this is their 
expected behavior when going over a specific number of entries. But there is
nothing batman-adv can do when the broadcast doesn't work correctly.
B.A.T.M.A.N. IV's metric is build around the broadcast frames and also 
B.A.T.M.A.N. V needs them for local discovery.

Kind regards,
	Sven
--nextPart6927204.24ZBchiv0l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxz+W4ACgkQXYcKB8Em
e0YQlw//Uv65KRQTJgOsUVDZU6j+bYu6XEPDQDTnyJcfI3PPpfRRAK189LIrv2ps
16EMYcypq5hYce+neaYYNGfSj6V1jA4HfSZESvRszCLf79qNwPLcNvJALEroTIPl
rQOobAFR5b/snc/jtNkBfq/GMRQRZYLu932SQqr4LVWlgxQcu1dew6okpKqtFlFR
xVXifNS1pQ9aykzIsIouPEArx4Oq+iv2kzNsBEEhHlmFwTTH7ACgM0KmHOGMb86z
VuVgHNfg4BXtPOJz2sH60zbJ+Ub7nDMxcB+ZJkyR8iyanUghuRapj7vrRbH0jwQr
iFnKGqqx9cLKB2FJ340ANqAtTH3d0we2A3j06/hknQb6BQuDtFJ4F0K7pkqWL45R
qpE03ovLnqmx16eTDA6LoJocnE7XUd6oyGcejEAtG5p1HIoZRw3+DOOcT5G57/nr
KnJlWToBTCuujYudVSKRYQtFfHBOpigEME6eGE18o0Q9XtSgOu6Ht8vWTL883Iez
93qJ+D3vCfdTOglAxDLLTwbpsfdWdaV/82zuUEfGH1+c5be25pyyiZ+Tt8Kqr9mD
GeJR5vIfUT75UsNkghg6cS8BQnFRzAExZwbKcBeOVidOgpHrpCz6KMenbrMBmDsG
Qe8Zs8FgWL9PdTpb0tH1OUbDOVBLV+ZzsQ1OWbX9Mkck0vEZ4D8=
=l3RL
-----END PGP SIGNATURE-----

--nextPart6927204.24ZBchiv0l--



