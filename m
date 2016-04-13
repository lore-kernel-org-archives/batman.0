Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Apr 2016 13:11:12 +0200
Message-ID: <2242031.raF8ugmCc9@prime>
In-Reply-To: <20160412204259.GK29895@lunn.ch>
References: <20160412204259.GK29895@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4537786.aK49jr9Sas";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] skb->priority and fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart4537786.aK49jr9Sas
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew,

On Tuesday 12 April 2016 22:42:59 Andrew Lunn wrote:
> Hi Folks
> 
> Does anybody remember the history for the follow and can explain why
> the code is as it is?
> 
> The soft interface transmit function, batadv_interface_tx() calls
> batadv_skb_set_priority(skb, 0) to set the skb->priority based on the
> TOS bits or 801.p.
> 
> If the packet needs to be fragmented because of MTU issues,
> batadv_frag_create() is used to create the fragments. It overwrites
> the skb->priority in the original skb to TC_PRIO_CONTROL, and leaves
> the fragment skb with the default priority.
> 
> This seems a bit odd to me. I would of expected the priority to of
> been copied from the original into the fragment.

I think this part could be improved. Right now, if I remember correctly, we 
set TC_PRIO_CONTROL by default and set another priority if we can parse the 
header (batadv_skb_set_priority()).

There are two cases:

1.) On the original sender, both fragments could adopt the priority as you 
suggest. The code probably doesn't take care of that yet, so that could be 
fixed.

2.) On routers on the way, the priority could only be set based on the first 
fragment, since the second fragment will not have a valid header to parse. And 
unless we remember the priority from the first fragment, we have no way to 
know to which priority we should set the second fragment.

I believe case 1 can be fixed easily, for case 2 I don't have an idea right 
now. :)

Cheers,
     Simon
--nextPart4537786.aK49jr9Sas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDilQAAoJEKEr45hCkp6hBQoQALe3FktUx23vrnugz0EKJ8Ul
geWmgHKarXoLQ5vCeeBEyVYRljrkmBztTH88X2Vrv1Fa8moHtFm4Sf56hQVlkE4T
YXgz0feoCCRw5gWheepMsbeZMhyBFK/K9b1vsMB/uejXJ6BOqJtTNBIKdKdbOLmt
dFK6QNB+N/O0l2B1Vqt4er+piLlm42iCCO77ub6HHcWCP8czzhkC+YW/8grk1qhR
o91AJ1jJaogUWPzf8MD76Pi/SQPLSI9bk/NfZyNhFVt/FZLQaS3BUeDtx3wVN7E3
3p8oY9/0WT9lG2r3T1Lm2JD/OQVE5W4nyitGewV3wnfT29J02vxMGeoWJXkdFabq
jKbU0z6DEVRAE5WTImgFfkeuTmEBWg/v8EYstw+ErAui6Xw3kxP7vDlX89yS/I2t
X3tp42fg8qEoJbWfTLIVVkk7CBfq4qiMk4NCeXj1IdoOSoB4nE7PdCta8ItwOW2o
Ip/AqzwYY3IL7gvTLWn9aY1C0UcNu8YlqX7LIoFUJr8Ga7ospa4uz5jif2zGdqTJ
OuWnJwUHnQhr4hIcQOhD0yq8/oy2KHhL8oOQOW7/BUxhTAKKAw9+tSUppiLksk/5
bUKM/psDMx1AiVc0SxVnOkAeTCmoACMV3rwW/Hsf9Rg6NdraxA/p87dp9LsvMQ8p
jLYQ5SN1rvnQlBdpD2vY
=moGy
-----END PGP SIGNATURE-----

--nextPart4537786.aK49jr9Sas--

