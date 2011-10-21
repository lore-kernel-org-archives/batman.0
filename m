Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2011 11:54 +0200
Message-ID: <1973945.TpfzAqhZAM@sven-laptop.home.narfation.org>
In-Reply-To: <CAFevQmNZGZi4DWjA3-HXcFP3wNFbdEW1ZQpQ5MHdEY6h-qh5Qg@mail.gmail.com>
References: <CAFevQmNZGZi4DWjA3-HXcFP3wNFbdEW1ZQpQ5MHdEY6h-qh5Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2028467.2NAjC86aLq";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Warning - packet contains unknown ether type:
	0x86dd
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


--nextPart2028467.2NAjC86aLq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Thursday 20 October 2011 21:29:44 Filippo Sallemi wrote:
> Hi,
> I dont understand why but some time my nodes show msg:
> 
> Warning - packet contains unknown ether type: 0x86dd
> 
> when exec batctl td wlan0.
> 
> Can anyone tell me what mean? and if it is as problem how to fix.

This is not a real problem, but a warning about a functionality which is not 
implemented (yet) in batctl. The minimal tcpdump-like functionality of batctl 
is just not able to decode all common packet types. It will only assist you 
during smaller debugging sessions, but is not meant to be a full tcpdump 
replacement. You should use wireshark whenever you need better (and more) 
dissectors for your work.

Kind regards,
	Sven
--nextPart2028467.2NAjC86aLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOoUE4AAoJEF2HCgfBJntG2PoQAMXmDsQ/ltSgkeqZxbvyn7wI
kjKMfN11jwznsJtOaYhUtelNN7nKnCdLS1nkBnP2xHJfA55VJGJnuz6uWbLh3cpM
h/v47ZhGQaLGJU+9uKprvetyggPXLOU5ZjtjHeVS0UxxpWJ4m040qy3XlKn3rHLT
zcsQ2gq3hrMdqf2aIfcOt5f58L9zgDHg/fF4hFgy1Nggo3YtzThy5gsBtPheBpVD
b6RJAEUKLSDLGu6Y7KR23VIP2ogWQraON636t1it54S39OFzdZ5tuf8xvNn5+QUi
KRbS2xauD0urGkW1CYrI0tSzgtUchgBvwsqDPhqqqypInwGrEQ6xw/OsP3PA2Ppo
IHNUM5b57hgv3uVKdvDwAdwi5oRs5/5LiO1bW/d3tSwl2BguPAuwGbR7VZUQetQ/
SZgq6OQ0D/HAFFRN15z4cnvY8mtzGn2vuZCHlAI2z5UlPs8l9mhAuymurQFXGQYu
Hck8aL20HruKIs05zyMdARPGIndEqJm7idpUMfT+VWxet8dCpQgqD/ZjukzZMZ8D
kQCMq+gjneduPkjOQlIjpNFV7M/GkTxKyb6tyf5K0ravKy6UOh0sH2fWFBuOnERz
its/+ypvqdCcYce28Q3VbG3R3OygagQsKRr+vPYKT7AZPmnxDyptCG59VQ4+bQAI
6dlWnwz68Yipg2xL8dGT
=Kglv
-----END PGP SIGNATURE-----

--nextPart2028467.2NAjC86aLq--

