Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Revert "disable ethtool link speed detection
 when auto negotiation off"
Date: Mon, 25 Nov 2019 11:25:15 +0100
Message-ID: <1631671.f41PytLLIL@sven-edge>
In-Reply-To: <21004470.HqcN17L5CA@rousseau>
References: <20191125094650.12435-1-sven@narfation.org>
 <21004470.HqcN17L5CA@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2526777.iMxG8KPp3J";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2526777.iMxG8KPp3J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 November 2019 11:02:17 CET Marek Lindner wrote:
[...]
> > Drop the patch again to have more default values for various net_device
> > types/configurations. The user can still overwrite them using the
> > batadv_hardif's BATADV_ATTR_THROUGHPUT_OVERRIDE.
> 
> I am not quite clear on how reverting this patch will get us better default 
> values. In the case reported by Matthias the autoneg detection was working as 
> intended by this very patch you are reverting. As Antonio had originally 
> outlined:
> 
> The problem with autonegotiation disabled is that the advertised speed
> is likely to be a random number set by default by the driver.

It is also not reliable with auto negotiation. And disabled auto negotiation
is also used rather often in complete valid setups with fixed links.

And I never said "better" - I said "more". And the other cases can be solved 
the same way as described in the original patch - override them.

> This patch was the main reason why Matthias (or Gluon users) even realized 
> that there was an issue with certain Ethernet ports & BATMAN V. Without the 
> patch BATMAN V may have created routing loops and Gluon users would complain 
> about those instead.

Routing loops? Are you sure? If this is the case than we have a major flaw in 
B.A.T.M.A.N. V and should think about disabling it again. This should never 
happen - because bad measurements can always happen. And who says that it is
not a common case (even without ethernet).... maybe because it will be rather 
normal in the wild due to the various intepretation what 
get_expected_throughput should represent. Every non-minstrel based driver 
seems to have its own idea of what get_expected_throughput should return.

The only thing I am aware of are the invalid looking throughput values. But as 
outlined before, ethtool's link_ksetting are a rather bad source for neighbor 
specific throughput measurements. But it is the only thing which we have 
without a neighbor specific measurement for neighbors.

> There is no disagreement that the situation needs improving but why is 
> reverting this autoneg patch the best course of action ?

"auto negotiation has nothing to do with the validity of the retrieved
values"

And gluon users/developers noticed that a lot of ethtool's link_ksetting
were not used because of this patch.

Another option would be to completely drop the usage of ethtool's
link_ksettings without having automatic measurements. But I think no
one will be happy with it.

Kind regards,
	Sven
--nextPart2526777.iMxG8KPp3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl3brAsACgkQXYcKB8Em
e0bGrxAAw30OrAZBBtcKjroYxidVEtIqrhG5/+IfIolp53V1hpWuPKeEavvOMPtb
TVFfWuL83cP5aA2wv9Mt511kANG1bPcYByyWSAtBe69VPDDDa9+Af9Zded8/iQVu
UpnfjP0p6ptiIiMgChkAXO7Eqife0LzJkmbfq9ZnvR3zG/fKfEl8eH2f+t8bDAeY
Q5Ok7Ujq7EDXbm6Zlwp1EznO/zJcTzYw7jhlnfBJ8RVIyb54sV5U7WPPP+fC3Vcs
T2s2S5m/DOGJsU21MQCPEp01xj5WXr1Ws3NLN9HRHxcPdIcxIy1EIxTXidaS+lqu
NBAx0CAec5FF+h8IJz6mo5gZFCRIQVplOMf7ubVw+1WETHDgPsw8XUtTREMVyx67
QLRCwrnvbIjnXoxcOx5tWvWK9/NnNWSG7dZgMyNqCnpaUS6fNkY07ddDTzjlCwIz
Z00EbJNso9IZa/bSGyYiK7ThScfBfeLWL+tkwRm8CeLqbUugeVvqA1QLlGNAlICK
hKyRnUO5Snn6LQeCVwI9isE9b59e3LIxOSqF6eoj0CVaHB/OJAnUTGFU9M2mccYw
Uv5MhS4wOG0sIyMzOPj+AcosRDwkW0Bn2wAPMNTvdR8sxj3+cKZMA1sb6XXbg2mJ
0lyXwTUJvjNK+6a9YBxK38rxmp4VQgPADvuvTUcu/KB3Usn0dH0=
=Frju
-----END PGP SIGNATURE-----

--nextPart2526777.iMxG8KPp3J--



