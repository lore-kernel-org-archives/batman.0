Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2018 07:25:04 +0200
Message-ID: <1997364.Zl644echhU@sven-edge>
In-Reply-To: <459d2f8e-6631-d616-9daa-a706c2878789@unstable.cc>
References: <20180605183131.4989-1-sven@narfation.org>
 <1581047.jmAOXYUeYu@sven-edge>
 <459d2f8e-6631-d616-9daa-a706c2878789@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4733706.VraSOCSPsM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Initialize memory for
 station_info
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: Thomas Lauer <holminateur@gmail.com>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart4733706.VraSOCSPsM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Juni 2018 06:44:32 CEST Antonio Quartulli wrote:
[...]
> This looks fairly reasonable and at a first glance I can confirm that
> even ieee80211_get_station() does not clear it up before filling it.
> 
> However, what do you think about zero'ing the sinfo object directly in
> cfg80211_get_station()?
> I think it is safe to assume that no user should store anything in this
> object before passing it to get_station().

I understand your point. But there is the potential problem that such a change 
requires more discussion with the Johannes/other wireless guys - while the 
early B.A.T.M.A.N. V adopters still suffer under this problem. I will ask him 
in IRC first about his opinion but send a second version of the patch to the 
batman-adv mailing list. We can later decide which route we take.

Kind regards,
	Sven
--nextPart4733706.VraSOCSPsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsXcDAACgkQXYcKB8Em
e0amERAAna3YvJsFjSmPFnr324hZ/MM/oGUe2imOodMGCdDh46iPkzUwoBj3zDE3
6NyZspGqtcCvmdgOWUmaUcD0TKFaJWzOBTShdU1xvmD8Qf0D/JhMepla4YAtIKIg
BSZK1iUB7VWZjV2ewbzx3mpUHuntocVVnkbZ1q1QlLLIYSKTgLkO5MlPCO8HIWrJ
s3AC/X9ILWJIFDnBU3eTYLBLhd0lVuSBDdgmgjVn710MqyJRw7/uHnMW4Zy5NXJU
A60widiNTD+Hu82zjz03p7QwR7zmTQE4rykqEidjY/v3Tpg1xvX4GMQqA1sNYSlr
CmqZ/z8msaBGBU//EOS076cBKDpZwzXm+oi8Cbooh9/h2OuAxCereKqlG3GRcaUX
ZSFcQck0PgnXYdlZOpJ5d5DlQ/s8xdNgJhOHYsNg7xPGggy3EwgXJwKxqEUcRfC2
sjTinbqSR04r81M0IxBHkiKbRZv4LjlitXfHpBosS6ha9ewAum66wGz21v6oeCnb
4vsNtNGd1aRpi505rqMKbBVOkrlA8Onyt0e6tnSOTK/FJh/zWwE9lnmZg7Wrwe04
60g8lzZ1o/WJOmwLh5D6fEA8CCApuM+NqnsE1wmG9pdT7EDh2dJe6nJ4X9voPtxa
uV9SQgXNHD4EG5eGPodndoylYJZz2w4uoVFWyhYFDKrBxXlCe64=
=1+t8
-----END PGP SIGNATURE-----

--nextPart4733706.VraSOCSPsM--



