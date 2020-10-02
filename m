Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Does batman choose DHCP server by random?
Date: Fri, 02 Oct 2020 11:25:33 +0200
Message-ID: <1713150.I2ok1Jj7fX@ripper>
In-Reply-To: <4fc7de29-7692-58b1-994b-4a3d623c075a@kkk-web.de>
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de> <5095353.evS3lK4dNX@sven-edge> <4fc7de29-7692-58b1-994b-4a3d623c075a@kkk-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25840226.yh7FNJUltT"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: MK <mailing.m1@kkk-web.de>

 
--nextPart25840226.yh7FNJUltT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 2 October 2020 10:29:16 CEST MK wrote:
[...]
> $ batctl gwl
> [B.A.T.M.A.N. adv openwrt-2019.2-4, MainIF/MAC: fastd_mesh/ (bat0/
> BATMAN_V)]
>   Router            ( throughput) Next Hop          [outgoingIf]  Bandwidth
>    (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
>    (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
>    (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
>    (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
>    (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
> *  (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
> 
>  Star means choosen gateway?

Yes, this is the chosen gateway. And the "1.0" here means most likely that the 
throughput to this gateway is for some reason always the same - so it has no 
good way to figure out the best gateway.

Please make sure that you either only use links that provide an expected 
throughput for its peers - OR use the throughput_override [1] on interfaces
which cannot provide an automated expected throughput for its peers. Also
make sure that you don't forget this setting on one side of the connection.


And can you please explain how you were able to get this output without the 
router mac address? Because this is a bug and I cannot reproduce it at the 
moment.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#throughput_override
--nextPart25840226.yh7FNJUltT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl928g0ACgkQXYcKB8Em
e0bMGxAAwtjHSIQwPfuk+nPtQk1EqdzwrsHpU7+yBLVCUH3/FQ3dpZH53Nby83qM
HYSnbg0PWAJ6uf0YLkPmkH9S18mL6GGXAt20DojXKeykXBd3Ql2O2ZP55g8gPlC2
T4fMk4F7O9vHcT0j2mI/OSYC5EnrRDAagI+NoyUiUFufXR6m0LPAIV1vzzzJRIGr
gkJTqKLxoWRhwemdn+INUPn0nscXB4KkOgRijSSWKP6yz2qXL2Y1Dy1auqsxUm4g
FXZDEvjSjFJyHpZC0ONLwaN4hJ/GqVZB+im0AnV+6K2U5nKzSY3LtILIBBwF95Xn
mIXeJwmgHB/WH2wy4ce3aRYHyZybxaUbcSMlJ0WYts6ElJ+doZARxxSv1xyYU+ut
rTwuwi09KEtWEgm7RyL+8Tuyhkp1S/ByR7axkiaWGpNb5HZTHtTpBSTRQSTmdgUK
Shi2lWKjfVeUttAipcXkKT6WACKjuA6Mw6WwzokYsHAPe4QOgZM6O9VFs37rVInL
RATlsBszqTdC4qe+bSr8KztYTJ+i6l7xtr9xg/vPywcWm0U5DDinz1vanHvqlkqn
F19N2KYZMQXbj1Q8MUis3GpKfbpv7tMhL7o189MQOz6HV6Tx9Zsi5H5j8f0QqNkV
penggSMKN7bREyTamFclsW+H6r6CeED3ld6IKDE5fl9YHHNXPZY=
=hIxN
-----END PGP SIGNATURE-----

--nextPart25840226.yh7FNJUltT--


