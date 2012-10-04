Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Oct 2012 18:30:25 +0200
Message-ID: <16662960.TUJbz1tKdU@bentobox>
In-Reply-To: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7377690.dd9qgeKt03";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] mac address from packet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Dominic Follett-Smith <dominicfollett@gmail.com>


--nextPart7377690.dd9qgeKt03
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 04 October 2012 18:21:02 Dominic Follett-Smith wrote:
> Hi,
> 
> is there a way to get the mac address of the station that sent the
> bat_packet? We want to get hold of parameters such as signal strength. We
> could do this by using the radiotap header, or by looking at the iw station
> dump of a neighbour. The second option requires the use of the mac address.

Hm? What is a bat_packet? And the sender is encoded in the ethernet mac header 
before any batman-adv header fields.

Kind regards,
	Sven
--nextPart7377690.dd9qgeKt03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQbbmhAAoJEF2HCgfBJntGKJEP/0Nh363RYAToPZOt0u88Lqbf
z9TqPzbRPu8G1skkt0KrPF9fdBQh5SA8ay8kGdgTKdcxMsNGib8TDX45pCa8EIhr
3TotGaK905Z2HqoZVvnoIpLBfULcOXZSWcZ+TiZiV0Ck4aUpSyF4fAqztT7y3Jk6
gZ4K5HtIsfOajoKSygvdwwM3lxhoAoHU79QS9r/QAf6QHVVZuiXi7XeHg3tTeUwD
sE/viS4rqJ5jo4hZ/FmJBTYIopmq8AmtnlkbdS/vj1+yj10Ohp/hRpI3plj691yK
8BfDWaieV+LmyixPq6lApne4JCcsm2xBNcDRumNkY9OFB4F5apWL9Z6i54oJpQ/i
LFIMktZo9poMqMuKSvlQ+PTyedGh+MBkw+W2L7iDXceEIMmE6YcYN7XgTttbq/+Q
uoXW5z4ztwRpHzJ3CT8UEXKtjzB+SSlJbSfA+NWI6Yj8jEbDhM/eY4nKh9pps53+
PrKyTlrVydZ3PyCWp7Ul8eVaokO3pkDFFYTqYLtHNjm7aN6X7150lKxnettH09YS
qucfYXReIPAGq2PCWNeZ2NSg9wt17n/5HjMrXjKYfGxHTcVKUiusLD/MM5Hnho4i
9k9ED2v6zeKuOxv9csbah0PVKXKhi/RKu7PpExzoQzUKW9ksxVDUZLbgiWSZCbmo
Et/Jq4u1BXKLjvympBdb
=oTDQ
-----END PGP SIGNATURE-----

--nextPart7377690.dd9qgeKt03--

