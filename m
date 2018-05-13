Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 May 2018 13:47:40 +0200
Message-ID: <1825510.S1p3h2ZCDE@sven-edge>
In-Reply-To: <fa4a5de8-9d10-11db-b758-745ce9f187e1@unstable.cc>
References: <20180512220223.3039-1-mareklindner@neomailbox.ch>
 <2624592.SrqEg3jeUP@sven-edge>
 <fa4a5de8-9d10-11db-b758-745ce9f187e1@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4289191.4oDlaLLeWm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: disable ethtool link speed
 detection when auto negotiation off
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart4289191.4oDlaLLeWm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 13. Mai 2018 11:19:52 CEST Antonio Quartulli wrote:
> Hi Sven,
> 
> thanks for your comment.
> 
> On 13/05/18 14:56, Sven Eckelmann wrote:
> > On Sonntag, 13. Mai 2018 00:02:23 CEST Marek Lindner wrote:
> >> If link auto-negotiation is disabled the exported link speed can
> >> not be relied on.
> > 
> > Why is a manual set speed less worth than a auto-configured one?
[...]
> For example, some people in the freifunk community have tested this
> patch because they wanted to see how the tp_meter would perform on VPN
> links. Unfortunately the tun.ko module sets 10Mbps/AUTONEG_DISABLE as
> default settings.
> 
> From there we thought that, after all, if the autonegotiation is
> disabled, we should just assume that the speed is likely to be bogus and
> it's better to measure it.
[...]

I saw the discussion with Matthias. But nothing about that wasn't mentioned in 
the commit message. Looks like Marek already addresses these things and just 
has to submit the patch again.

And he should not forget your Acked-by (in case it still stands).

Kind regards,
	Sven
--nextPart4289191.4oDlaLLeWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr4JdwACgkQXYcKB8Em
e0aErQ//ULOdM2FrMHNHWVOuikQiWN8cXX/hmFipLFboHflqmzafoD6I6MiehsL/
cjg79Q1Hw50pfUjQzKgqZHaxgEP96eWmlmjSAoUGwQA/yzkGfuQNf+Gxf3V2Pg+z
ToyJ8BQq93lXSGV2wRaTqodXY6aWFiQwr7+K4xkeDS2WtJQNMN1/tXRwQggbvHEk
DyBnpdo9Za+teVF2VCWgLsKL956TWjcF8XYsYBZA6YSMousTFyDS+Tm07tMj4AMe
Z2R1pcvyVvxORse78PwNaQu/gJNdsAZYmcpmDmsYqdQGWR5uriW28//2Wmp0khkG
LQeWSeWQFEJvHufDXVW8f2gEL5YgAvWh41F6q4bWObZLM2PWv937Id601uBlW2md
xykO40Br5Z7EcFGW/MZxlBXiyJxIdvz776RRaL568ijsjlWivC41p4T/aV04KBEr
Ktn/TTkNTcekz+sMjyu7c3cVEmXG8YbCSrLro6EBYVUJEGJGlT4+7sd9E4QP7mLh
6iOxWaKN90ymBqHLPQZBuK9sq3VDgODZiDkRK6yBDr1h5gywCUoN5z8HhJkGuzQs
M4enY9nx0bH4pJbOTq0IdwYke5oiQo7gA0kf+fuCMdckqa79p+jngAlLtQtPHCkb
xXwJepDchzjF/hp/UBbQ12Um1LDiDOHgaICO7pQb03fj/fsdDC8=
=zAO6
-----END PGP SIGNATURE-----

--nextPart4289191.4oDlaLLeWm--



