Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 17:36:03 +0200
Message-ID: <1567863.zhc03RTn8V@sven-edge>
In-Reply-To: <20160806044244.GA13676@otheros>
References: <1468793741-4606-1-git-send-email-sven@narfation.org>
 <20160806044244.GA13676@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2267471.pgcOrpn3rl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't allow zero and
	multicast sender address
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

--nextPart2267471.pgcOrpn3rl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 06:42:44 CEST Linus L=FCssing wrote:
[...]
> For data packets, I'm not quite sure, though. Could be interesting
> to not restrict that now to still allow enhancements regarding
> privacy, I think. And zero-source MAC addresses shouldn't harm
> anything in the case of data packets, should they?

I have now changed it but I personally think that this will not work. Many=
=20
filters/firewalls go crazy when they see zero mac addresses, the first bcas=
t=20
batadv_is_my_mac check is not working anymore and it should not be possible=
 to=20
send over IBSS or Sta-to-AP with a zero mac source address. From AP-to-Sta =
is=20
not a problem because it can use 4 addresses in its header. But the other w=
ay=20
around is problematic because only 3 address are in the wifi header. A=20
transfer with zero mac address as source address from Sta-to-AP with ath9k/
mac80211 should end up in an Ack back to 00:00:00:00:00:00 and a=20
deauthentication frame to 00:00:00:00:00:00.

Kind regards,
	Sven

--nextPart2267471.pgcOrpn3rl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpgPkAAoJEF2HCgfBJntG21kP/RxVzT1ieAZfwwqBRQp1j0+n
0gROsyePo/8p9YrsCWp48obXTy8gZ/3yJJ5jIgqnGdt8weAz5ORvopXTqXRaWRv4
Hm+VICYLBRAJ0bGYovk+1zRxIV05HiTFcRqh0lAmTsC+NMQ00TAM3DP36lENmr2e
OzWaCHPD2unpy+P5JyLlnytwZK3Bizwy2gvMH16ObFayuRIoGWkZTLZNlw1xEQpx
/VQIRfCYOfRsPBWqaHqO50DnV/xZ6wE+hUurI1m1hpJwKgEGVTk18NbENHDWQkj4
noKYVtpiT8c1u8MHhOz5SDVgPeYl1LkpKVikUud/7tKnFdiluukREMEYCFa9ZAoT
ZIKGYTGKAuC8g31XVwyDozvANXNja8gnzQAOea94Kx0dZTB8LFOYyshXz+uhu2DC
wUI7wTG1tj6iL/lodqsOyMZeIHI2KzfMqeOzJG5j7tYrR+3V+rTf79Zo6HkI+6JK
sww/OJKHYmsT47NfHK1U0h9awt4wi04e3obzC5WITkwMHC3C/diQbTWknkd6lYPb
Yv0w7vzGM4Cb9esb/24RrDs0TNKBejPX56+qe27ugsEH6wkMJAgDpO8/R0Mmmod9
CHrbzjqXQdS2L5FR1mx/y9NWHihvZ38yQw43AGyQNttGXw8AH1MOHc90/cVcTVq6
dOHITfKGBMQC0RGX9a2/
=ncAM
-----END PGP SIGNATURE-----

--nextPart2267471.pgcOrpn3rl--

