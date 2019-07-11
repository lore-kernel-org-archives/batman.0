Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: How to run batman-adv on interfaces in AP / Station mode?
Date: Thu, 11 Jul 2019 08:48:03 +0200
Message-ID: <10085991.EQm6kMviFh@bentobox>
In-Reply-To: <CAH-WULkD2g8KvzWT0=CxcvF5ja54p3qW_OZukM52gtoTkQXb_w@mail.gmail.com>
References: <CAH-WULkD2g8KvzWT0=CxcvF5ja54p3qW_OZukM52gtoTkQXb_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3128887.gB2OOD8Nas";
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

--nextPart3128887.gB2OOD8Nas
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 11 July 2019 05:44:07 CEST Ricardo Cerrato wrote:
> I recently configured a mesh with two nodes running Debian and
> batman-adv and two wireless adapters TP-LINK TL-WN422G configured in
> IBSS mode, and to allow non-mesh clients (like my cellphone) to use
> the mesh I had to use another wireless adapter (same TL-WN422G)
> configured in AP mode and bridged to the mesh interface (bat0).
> Recently I found in the FAQ:
> 
> "Can batman-adv run on interfaces in AP / Station / etc mode ?
> Q: Can BATMAN advanced run on interfaces in AP / Station mode?
> A: Yes, because batman-adv doesn't know anything about stuff below the
> ethernet interface. So you could also use it over layer 2 ethernet
> tunnels, wifi ap, wifi sta, wifi adhoc, ethernet or even write a
> virtual interface which prints everything on paper and scans the paper
> on the remote machine (but you should be fast or increase the ogm
> interval)."
> 
> I guess it is possible use the same adapter as AP and mesh client..

Yes, but this is a question for the linux-wireless folks. And the FAQ entry 
doesn't talk about this at all. You want to run AP and IBSS (which most likely 
doesn't work with your adapter; search for vif and interface combinations) in 
parallel and the FAQ entry talks about running batman-adv on top of something 
which is not IBSS.

> I my tests I found the AP mode and IBSS modes are mutually exclusive,
> but I didn't find examples on how to create a mesh without IBSS...

There are plenty of examples out there which for example use 11s/meshpoint 
(with mesh_fwding set to 0) as an actual useful way to run batman-adv without 
IBSS. Just create the AP as normal and then create the the secondary vif for 
the mesh. It seems like most adapters today support meshpoint better than IBSS 
and thus you can just try to switch your underlying mode from IBSS to 
meshpoint. I also posted the commands to create a meshpoint interface on this 
mailing list a while back [1].

You can then just add the meshpoint interface to batman-adv and use it like 
IBSS (just with the difference that it is NOT IBSS).

But this doesn't seem to be batman-adv related question but questions for the 
linux-wireless community.

[...]
> valid interface combinations:
>  * #{ managed, P2P-client } <= 2, #{ AP, mesh point, P2P-GO } <= 2,
>    total <= 2, #channels <= 1

Here you can see that you can for example run an AP interface and mesh_point 
(just make sure that you disabled mesh_fwding) at the same time. batman-adv 
would run on top of the meshpoint interface.

Btw. you will most likely observer some odd behavior when you try to scale the 
mesh - these are most likely caused by the limitations [2] of the usb wifi 
stick.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-December/013924.html
[2] https://wireless.wiki.kernel.org/en/users/drivers/ath9k_htc
--nextPart3128887.gB2OOD8Nas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0m26MACgkQXYcKB8Em
e0YDMhAAnQ3LkUyhX6+mODgmyEZj0wy8BmXwWn7krOzGBE8thbiEm+aoaWOfcSxY
4qNmB5tKFSF1ZSvn/9s3VjYZmhZ+miLQ8ZMJNFvN3/8QmTbvXX82pQWGqLdTLu0p
0vCy06VDHB0VO7ECGTP/X6jZcN8VsjoYv8hcjRUK/xWYVbFIH9cGqkto7fIYRW3p
gWeMpUtlyG8htNRrwCp62phIw4sXb3f9AgpC8w+gNloQLC+T84NIm0tzPQ3adGte
+ZICX9jZ1G7is7+Iqr2yfrNji2lR8u/oZQFV1OyU2dzoypwQBW7bOo9WG/hpydnZ
bCN25cri6G8PkZCBx6DKns8kv13JuNZc9ygG/r5rR9vpa6CnNwCPE4AOf5Arkzlk
6SrLZfC/1mKx+HO2zzrshgAIhb1cqVdRrBlqj+YhSkARz3lj6CdZcK54alfdtw7z
u0gHLs0M57sa9dxCOyKRIQKSRLpcWms2tIYb20MHyVuRq3BB65TRjZXWc9WWp4ka
43zh4cbVpQP2YIg5JiNLUfRZsZysrr6EAN9eJdXo7gb3tf79s+P9MiFEDk5+DWyG
zbwUkOOgHqXyvhANnxmLz5YYnV3AMNEYozAxtwjzVMgRJRaNCRCXxB5DTZVewg1I
aTNrb7V2W0mb4lcdyxovN+EZHfsYeVE2r7JBOH4QQEHREiimxPo=
=FmLG
-----END PGP SIGNATURE-----

--nextPart3128887.gB2OOD8Nas--



