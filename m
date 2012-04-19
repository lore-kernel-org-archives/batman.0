Return-Path: <ordex@autistici.org>
Date: Thu, 19 Apr 2012 07:41:14 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120419054113.GA8658@ritirata.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120418180837.GB6589@ZenIV.linux.org.uk>
	<20120418181058.GD6589@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20120418181058.GD6589@ZenIV.linux.org.uk>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman: don't bother flipping
	->tt_crc
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 07:10:58 +0100, Al Viro wrote:
> @@ -722,7 +721,7 @@ update_tt:
>  		tt_update_orig(bat_priv, orig_node, tt_buff,
>  			       batman_ogm_packet->tt_num_changes,
>  			       batman_ogm_packet->ttvn,
> -			       batman_ogm_packet->tt_crc);
> +			       ntohs(batman_ogm_packet->tt_crc));

If we don't need to flip tt_crc, wy are you introducing ntohs here? Am I
overlooking something?

> @@ -969,7 +968,7 @@ static void bat_iv_ogm_process(const struct ethhdr *e=
thhdr,
>  		ethhdr->h_source, if_incoming->net_dev->name,
>  		if_incoming->net_dev->dev_addr, batman_ogm_packet->orig,
>  		batman_ogm_packet->prev_sender, batman_ogm_packet->seqno,
> -		batman_ogm_packet->ttvn, batman_ogm_packet->tt_crc,
> +		batman_ogm_packet->ttvn, ntohs(batman_ogm_packet->tt_crc),
>  		batman_ogm_packet->tt_num_changes, batman_ogm_packet->tq,

The same here..I am not understanding..

Thank you for your patches!

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPj6V5AAoJEFMQTLzJFOZFkMYH+gPCKJiyXMLqf45E1a+S++Fo
cDGF7wSzZz3pJLGizy9MjFzY/AIrztUOms76GvILrNWC8jR+k0eWOmSjGUawDWuO
z5UR7KmBl4K1KWodHYc9ILZuqYmXrMIgFyo6hbOGNS4eKXrI3oEPl+urJPpbeB+2
MzgFyGs/W/0H7LNF4uvkbizRrMwrbznw+F/Vvp8Ag4tPxKyOHn89QTFEEZaq9x/J
8URATHNDh9Uqkf9AgLA/3qqwmDSb2KJygrmQSKVIVClchj1wNAs5ikTgEikZ6VB7
TCpJi29Z9rwtfP0ZWhAbv+re6Yl4oh3tup7ou6UiyeOCAdLCRcNDZtFXIDcxHGg=
=seRG
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
