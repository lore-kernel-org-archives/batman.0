Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 5 Feb 2011 04:51:52 +0100
References: <1296827833-27595-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296827833-27595-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3416543.U6rxE7vuly";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102050451.54192.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove duplicate types.h
	inclusions
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>

--nextPart3416543.U6rxE7vuly
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 04 February 2011 14:57:12 Linus L=FCssing wrote:
> types.h is included by main.h, which is included at the beginning of any
> other c-file anyway. Therefore this commit removes those duplicate
> inclussions.

Both:

Acked-by: Sven Eckelmann <sven@narfation.org>

--nextPart3416543.U6rxE7vuly
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNTMlZAAoJEF2HCgfBJntGtJYQAMp8ntM4Ds6cGN36ZuwPWddq
7/ICR/mTTtMPrer5LfVx6l6yv1BMR4dAwCy6OdYUbe4R40mUMlsVHY/KUGwivzGc
vqS7Qkv1m5uLFv7iZIrO5HJSbQh6ohpaATm8SGaoOAlzHdTNp/j9xf7LPxeiuJli
l0YLdt58kw3Am0sZt2I9C97gulI5arATtoqUmXdOgz0Gw6UKbV6D/9cuE6NxyDnP
ZAFsuGMrmTp9aADUQv781oErwRT1S5+P4ruo2qqEyjKgl8H3uIt5nICIhaWsusTB
GfEkV/rIQ34VfUIZJRWeKT5C7QFZgjzDLA3BOsfDRo1d/9xathOVa2vDBb/MmQZv
6k3Q6EmEf8zaXCC3x0iuovbkJ68uHCVqQILoaBJyXARLxcnB9sJodx8HhbnaVJoV
SCTTbixXmGtYxRL2GO0dp06YgF0b3DFo5VMsUflf46ziyfG1ado7qMaGAmNXjTfZ
MZYNHS1KGX6YWmvic6k+JxRQrpKAmp0VKTxkDuQQTr2L2527hxtwdfPatEZY2xw+
Ru0A+WThzcKvBWS6dy6U0VM7nIZmqvxNTeIgc8MSLlfQywIDStkyT8gyBMBYYDLt
Gd1vHpefme8VnK+zW/0JKPA8RR9p5aN11CLJuzKgK/28yFl/Y3d/2KbcZMZZgdbH
Gkq4a/RDhz+Q0Hj77QsE
=U7g9
-----END PGP SIGNATURE-----

--nextPart3416543.U6rxE7vuly--

