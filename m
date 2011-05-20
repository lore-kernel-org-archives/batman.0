Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2011 09:55:26 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2047936.PbcKAP7UAn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105200955.27323.sven@narfation.org>
Subject: [B.A.T.M.A.N.] batman-adv bug 149: odd broadcast behavior --
	generated CRC errors
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
To: dbeberman@aicas.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2047936.PbcKAP7UAn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I would assume that you don't monitor the bug as you didn't answer the
questions on irc. So here the part of the IRC communication which needs
comments/answers from your side.

<T_X> dbeberman-away: hmm, weird. could be a batman specific bug. the first=
 thing I'd have in mind to narrow things down would be=20
to try changing that line: http://git.open-mesh.org/?p=3Dbatman-
adv.git;a=3Dblob;f=3Dsend.c;h=3D33779278f1b2bfe49155bb9dfadc421305c0c8d7;hb=
=3Drefs/heads/master#l485
<T_X> from skb_clone to skb_copy
<T_X> from looking at the kernel code it seems like skb_clone() is only cop=
ying the skb-header, but not the skb-headroom (which we=20
are modifying in send_skb_packet() )
=2D-> jn_ (~jonathan@dslb-084-060-236-250.pools.arcor-ip.net) has joined #b=
atman
<ecsv_> T_X: and that is a problem.... why?
<ecsv_> i don't see which crc is the problem
<T_X> ecsv_: you mean it should not be a problem because we for clones we a=
re writing the exact same data in the headroom again?
<ecsv_> we should... but yes, it might be a good idea to implement it diffe=
rently and to test it with skb_copy
<ecsv_> it didn't checked the bug report... just assumed that you guessed :)
<ecsv_> but still don't see what happened to which crc
<ecsv_> we only modify stuff which is related to us.... and not to the enca=
psulated data
<ecsv_> but maybe he meant the ethernet header/wifi stuff before the batman=
=2Dadv header
<ecsv_> but why does he see them?
<ecsv_> and why are udp broadcasts fragmented?
<ecsv_> we should only have fragmentation for unicast
<T_X> ecsv_: I think he's talking about the wifi fragmentation
<T_X> not the fragmentation in batman
<ecsv_> dbeberman-away: and the only reason why we reject mails on the list=
 is either that you are a known spammer or that you try=20
to send html mails
<ecsv_> did you get a reply?
<T_X> and I suppose he's doing the sniffing on another interface in monitor=
 mode
<T_X> ah, and missed that the "my_skb_head_push()" is in fact making the he=
adroom of the (cloned) skb writeable

Kind regards,
	Sven

--nextPart2047936.PbcKAP7UAn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1h5uAAoJEF2HCgfBJntGUvsP/R35+O86M7kQECNbk+VakxvI
l9GEFxQzduAFAg0h+8kqFyAfGlc7F4yepaMBQ0CMEpq6+rrzswXzatDKF74nS2Xu
TgeIDhQuGRvWHeTpe3XDqjQDbZwczW3khHp1ZeDof8TwJb7ua7mxXRfP2/gy7xKk
VGrt6UBbX1Qq1oxwScExnytJ6ajIbRO/F48f2xljnDc0f2Y3D6xEl86tcP/A5COB
zXRUmIzxE5XMyTvHAStseIqvIq9/HZi65HEGdU+dEXAXj600EWKJTGqWqI+x2OH3
sDfKzSBTi+eBdfnNteB+O4F8VyepULcxLV8yZlA/HxCuR8yofksxpF8kbVMuNG9W
DAj3a5WRZOcxZH60adQMJiHvn+ZNzyues49ra3VWDIDRELtmgWc7KGHd0ZBj0Vs0
2HKAovkiN0K58qbRt4VOAL1aZvV6ByrUCnJWgim4NOw1Kkpls/2DigcNKT0pGEKQ
3L/Wz9so5zgmDTL9B8lgGD+3yaRqh4ww8uREEtQGGZXDC26/p9hMfPliLtM4nopT
N2myNut0b2OX0SZb5ZxxykFDeVBfqONBhd+8TIAeADcPAJU0FpigrfLPuMt7042o
J78+k891z/k3WOHPmNftAPdjkZq/11T+CnYf82djv9oZVPZzBNSJvmmNvIf5GvYL
+3tv0vKshZXyBXkcldta
=QIR0
-----END PGP SIGNATURE-----

--nextPart2047936.PbcKAP7UAn--
