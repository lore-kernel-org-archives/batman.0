Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 17 Jan 2014 03:06:31 +0800
Message-ID: <2800618.KaOgjtJPrA@diderot>
In-Reply-To: <1389832761-7914-1-git-send-email-linus.luessing@web.de>
References: <1389832761-7914-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3348340.BDD7omIL4W";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use eth_hdr() instead of
	skb->data in interface_tx path
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart3348340.BDD7omIL4W
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 16 January 2014 01:39:21 Linus L=FCssing wrote:
> +       if ((struct ethhdr *)skb->data !=3D eth_hdr(skb)) {
> +               pr_warn("Upper device did not set the ethernet header=

> pointer correctly - adjusting\n");
> +               skb_reset_mac_header(skb);
> +       }

How about using ratelimit or else we end up with many log messages ?

Cheers,
Marek

--nextPart3348340.BDD7omIL4W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS2C2+AAoJEFNVTo/uthzAP/EIAJIsex3D1+4WBiVntA8EF8RN
JCNe/TtR19ZaJ6VRcrAgdQFBSOSTYtdsp9YRMnbQLFFo17hK+3pNfsUJB4+IFQsk
P38iIuc0Zw1f8H1Ibq6R49/kNdYaLubeas7Y1MJlNlBcCXIFJyuhalOg9CsQJfOu
Ygt+7eRlPuuzC65fDnNlpzrTdKtLSrmqGqmuzouD0sQZlqPyTH8/rWNGDg00Bj1P
06QpKMrd82Qz21DRwvZYBHeQ5qJmJLEBFDDeyjWZ8VG3qG2040udFR52I9ylS0mc
aHWJs9clB2+1Se9AmI6Nuf83xYnqI0/vvG1h36hvvdDBcYdyGl8/NXsUHYRusvA=
=1acS
-----END PGP SIGNATURE-----

--nextPart3348340.BDD7omIL4W--

