Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 Jan 2017 08:51:02 +0100
Message-ID: <2739485.ZOxij8zM53@bentobox>
In-Reply-To: <CAPkwMUfc9K3J+0wwegZOuLCba5JY_5GP33jcykPa1etpWKkNsw@mail.gmail.com>
References: <CAPkwMUejbf31RfVY_nCJSVwe=_mGVO3y5PY9zzfkQk0eDc1HTA@mail.gmail.com>
 <20161219101024.GB8485@prodigo.lan>
 <CAPkwMUfc9K3J+0wwegZOuLCba5JY_5GP33jcykPa1etpWKkNsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1678598.RlGp2bNVnc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fail to create tunnels using br-lan
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
Cc: Francisco Javier =?ISO-8859-1?Q?Sim=F3?= Reigadas <javier.simo@urjc.es>, Andrei Buciulea <andreibuciulea@gmail.com>

--nextPart1678598.RlGp2bNVnc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 19. Dezember 2016 11:55:40 CET Carlos Rey-Moreno wrote:
> Dear Antonio, we will post it in the OpenVPN mailing list too, but I
> was hoping that someone in the list had been able to establish tunnels
> in between batmand-adv nodes using the br-lan interface.

Sorry, but we don't understand what your question has to do with batman-adv. 
In your example there is no actual reference to batman-adv. Only simplemux and 
OpenVPN is shown in the example. We don't know simplemux and cannot tell you 
why it may not work (is it the problematic tool? Not really clear in your 
question). The latter is known but seems to be used in L3 mode and therefore 
useless for bridges and batman-adv.

> The tunnels can be successfully created in OpenWRT, but it fails when
> assigning the physical interface the tunnel should use. It works when
> a physical interface is used,

So it fails and works at the same time with "physical interface"s? What 
exactly fails here? Is it batman-adv related? Doesn't look to me like it does.

Kind regards,
	Sven
--nextPart1678598.RlGp2bNVnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlht+uYACgkQXYcKB8Em
e0afxhAA1eMK2AMjIvfTknVAz5kEIrIu6VN58leToKOL57PtuaG22rJP+zoPbLKg
9hq+rONUUFk2fX2ly70kE7kCh9izZ8EqEIE6toKnoZey3WgMKvmlUCF4s1XEG9bD
YXtCA4twUYFsvwFFRQMnyVU6iUjS9tLAyU25gkX4IYYhm98kMm5ZP/7Z/jFnbyD9
Uskln2H4BjJn8Q6ohCFMtnBKe8rAcCLHjZNNWRVGu9UzYrYyZSHctT50EP6Vs+YH
LjWSXiS4yNnuzB85DHjGRHH/7wmVAraByj17qrGErwOjMU02dsNZJ5RHkoDBbpVN
rJujSKpKE5S2imcygX9ndNT4IxSPoVxz9kjecYZvlGY/7QnanT8OIj15PJFiCa3t
QEifmHJxb2Nnxbuy+topUuxB6V/3jlAqDH0/7hLNBPCFB6odLhaZI7lmmwDRDru5
xkl01tGzPey35IS1SFVAQTtLDMbPw8FPcURKyUTAxz3faftwrwa1aNDzthp4563a
sI/d7Arp77UyptGdzmZxV+MuF/UARxpQearmd9gwCRPhYsmP13PE4GeRT/Ak+8Ud
6CN4srk117bbvHi3lXWLzHDV4LKkSAmuj2KnFiWOMOfTYFTAqONTE2SCKOhAiZU8
uvBN5lRw7tZEnRPrkq9jMnByrjjAiqhvdsFjClf45y548wDugBo=
=JFaP
-----END PGP SIGNATURE-----

--nextPart1678598.RlGp2bNVnc--

