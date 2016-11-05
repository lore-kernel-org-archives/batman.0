Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Nov 2016 09:31:10 +0100
Message-ID: <2647191.IP1m5t5WQf@sven-edge>
In-Reply-To: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5498253.02ksB0TNvq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
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

--nextPart5498253.02ksB0TNvq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 4. November 2016 22:37:24 CET Jean-Jacques Sarton wrote:
> Hello,
> 
> I have take a look to the configuration of our gateways.
> Inho there are some points which are not OK,
> Broadcasts are rebroadecasted on a wired connection,
> this seem for me to be an issue.

No, this is even required on some "wired" connections. For example Matthias 
Schiffer was against a change to remove rebroadcasts from the incoming 
interface when it is not a wifi interface. He requires it because his fastd is 
using non-wifi (so it basically a wired) interfaces. But it doesn't take care 
of any broadcast distributions for data which is incoming. He is relying on 
the fact that broadcast/multicast data he sends from a client to the fastd 
server is automatically rebroadcasted back once to the incoming interface. 
This will then force fastd to send this data to all its clients.

You also don't know what is actually behind the wireless device. So you can 
easily build a setup (yes, I have already seen this) which has a non-
transitive ethernet to ethernet-like bridge device which attaches via a second 
ethernet to the unit running batman-adv. Not rebroadcasting here would again 
create missing broadcast problems like with the standard wifi hidden node 
setups.

Kind regards,
	Sven
--nextPart5498253.02ksB0TNvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHZjOAAoJEF2HCgfBJntGXXYP/1jxsQxB2JEPFicYC8pF2KCF
MiXhJpkrZwQIMkXLOpzFmQKpDD3KvF4GyP15+iJb0L5Y1ohp5h82+0T/P9qpxsit
j2jEpXq6E5rOx5qC5pjNmQn/BbovHSdmPrQxzzvmmT7mc0NQGcp5w5tZE22vcGAk
kETTLcpAjBQqRWnoMLxPcb4c9GkEfNYUmYyGDxtzLLgqwItXIXw+82L+tawJbatP
i02PKvLHw5GCsVvjVfCdcnGzQ1CwUgCwJvRrKRkVP06XdsxW6eB/niAQ3tykcQCe
qSHASuxAtJlIeaVh34fFrx9v7Ahdg1gJBcc2kJ1jqB1EXGPsoi9ygRvdFw2zcdwN
5wf1Nxx8hW2MYP1BfwVfzS5W8gOfltMBXHjQUFMV24PZhWjh54VX00dWYd7M4rjP
Iv5Z7UKy+c7qv4iJGX0uXQ0AttyxPwinCtteGLMezrW0gU+/X/nGw95V2XWTxYzJ
KxgEVTAlpXi+2r1x8oXh1HkOqCeuM/FQiqXyu/ZW89X8cYBokJQG7xPlh+VUq8f7
Yblt1Qhr4Bd5kTn1aayxl+okssz6Eyh1lEZQQoQE+DpZ/bBMOmtp7bm3uF4Tq9Jp
pkxBiY4ld7K1HTdxkUKAJrOhL4yb7Av/J4EoEHC5xHTPGtgkhhhUsK+gekn4nJRu
DWYszXt9RzV25QSZOeei
=zIWy
-----END PGP SIGNATURE-----

--nextPart5498253.02ksB0TNvq--

