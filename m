Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Running multiple batman-adv namespaces on the same broadcast domain
Date: Wed, 09 Sep 2020 11:05:11 +0200
Message-ID: <7459754.hIpYFi07Vt@ripper>
In-Reply-To: <CADJ1cUSff_g-tB28HHeR5GrYHHtch7f+bdQQ85HdZx4dhLdTvw@mail.gmail.com>
References: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com> <34120415.8pMx1AJBNe@ripper> <CADJ1cUSff_g-tB28HHeR5GrYHHtch7f+bdQQ85HdZx4dhLdTvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2953339.uSJZPQ8N1e"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alessandro Bolletta <abolletta@netter.io>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2953339.uSJZPQ8N1e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 9 September 2020 10:50:24 CEST Alessandro Bolletta wrote:
[...]
> Great, this is exactly what I'm looking for! I'm running this for some
> experimental purposes. Are you running VXLANs in multicast modes?

I am using it between datacenters with handcrafted forwarding rules. And I am 
using gluon which uses link local "multicast" mode [1]. 

[...]
> > I don't like the word "namespaces" here. Because this reverse to a completely
> > different concept in the linux kernel.
> >
> 
> Yeah, I'm sorry but I didn't know how to call them. "Mesh clouds" is a
> more exact term to call our batX?

I would call them batadv interfaces. And the thing behind it - maybe mesh 
cloud.

> > And I don't know what you will end using - so I cannot say if this will work
> > or is tested.
> >
> 
> I will use them in a scenario where a have 3 hosts connected by an
> ethernet card each and a switch. Then, I have to connect at layer 2
> these hosts to batman, but I need to separate their traffic through
> different batman-adv "mesh clouds" (in my case I can't use VLANs, QinQ
> or stuff like that to do so)

I've already used both VLAN and VXLAN (and other things) for stuff like this. 
But there can always be problems with your kernel/driver/batman-adv/... 
version or even the hardware. And I can guarantee that all of them will 
create some kind of cost (overhead, performance, ...).

Kind regards,
	Sven

[1] https://github.com/freifunk-gluon/gluon/blob/dd76e0898d70a123d8e7f178384fec84890e5251/package/gluon-core/files/lib/netifd/proto/gluon_wired.sh#L39
--nextPart2953339.uSJZPQ8N1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9YmscACgkQXYcKB8Em
e0bOmA/9G5Wrx7A5XTe7397nwYXKk+TKLvUFOeYpCvFxS6HqBDl7auyTuMYD2X+J
CYw+CNM1zB8Rtw1eALEb3K3239WVLnDIG3BQrjCtFiwsuDOFdnxkEzFRltCGGZel
qe41gndQxg5wc5YPcEUh5n+haOquq3OzyBhts3VtUhHK/jRkPj6istUIbR27QSBi
ZCwhCyG5rnTYH5FAAMzLO7AKWef+nH2pFEoVp85fu04tmtAPIk6nF6v8Txdg1P53
Vo6QnHvE9OOU+BKUvK3M8SaYeSx39I9G6rTnJC1yLT/sKQFEnJ/X8fBLIPNVEXkS
jOi+D9UYcu6RDBMb3nt+17ahRjUcmFP06/ndGtO6ceQVS9MZpOZk3UmZ4UvS/zFa
Df52orFtVlumP6E3mhvMMVdETLtj36sG0TIYApH110KuZuD0VfLmXTylZCOM3Qx1
N+IuPPx/s3gfJXgHujRRgG1AF0D2MVfKHzNzgd4+BvFYwyiX1fMc30PdluCzeNKT
dLukOz/e1i6DOnFgdPtOgaUQSEzeZYc3Mnmv/m0k9LFiGYSEnwlIo5Rpw9UDhIM/
ZNppsPLwGhjF1MujkZQmcnUI4yZrp1FV5SLvvCasWzqZILym/Kt4g1kc8qvEFwpn
inOH7uGAr5eDlyqnbPrlp28Hxmd40Zka3S3+B9OihwZqsurLO2Y=
=5tcR
-----END PGP SIGNATURE-----

--nextPart2953339.uSJZPQ8N1e--


