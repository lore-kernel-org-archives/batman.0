Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 0/8] net: batman-adv: delete duplicated words + other fixes
Date: Sun, 23 Aug 2020 08:45:53 +0200
Message-ID: <3515346.etltgSPTIo@sven-edge>
In-Reply-To: <37b82a77-fc58-9a7b-8996-a6bd030ee7ef@infradead.org>
References: <20200822231335.31304-1-rdunlap@infradead.org> <1676363.I2AznyWB51@sven-edge> <37b82a77-fc58-9a7b-8996-a6bd030ee7ef@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4310618.EFodLd8k5E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Stephen Rothwell <sfr@canb.auug.org.au>

 
--nextPart4310618.EFodLd8k5E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 23 August 2020 08:05:10 CEST Randy Dunlap wrote:
[...]
> > Please rebase to only contain the changes not yet in 
> > https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/batadv/net-next
[...]
> Is this git tree included in linux-next?

No, Stephen Rothwell isn't including the batadv/net + batadv/net-next branches 
of this tree [1] directly - only the netdev trees are included. And the batadv 
specific branches were not yet submitted for inclusion after net-next reopened [2]
after -rc1.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?id=c3d8f220d01220a5b253e422be407d068dc65511#n3135
[2] https://lore.kernel.org/netdev/20200818.002258.232165702420264020.davem@davemloft.net/T/#u

--nextPart4310618.EFodLd8k5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9CEKEACgkQXYcKB8Em
e0YLbxAApJz8wPlivbQR+Z9ArTfALZMyYK1we+BId3vMFGjjsc8FytGzRSCIOEEi
xzZnFb/LHN8aLJo1rAHV19WfIA6weHNZXxykhaRIcRaM5r7DpaoiSVqozaw0KurG
kIIZrY9Kc12o73ayuH8XdAb7Oiq1yQRKs3CkLc5xJ2NaEPz7rgJo2vMjFwlLspEN
rSqsILFfGNIrXIMCymDAetpHEsmmfJH51GAg29Y7S9Y+ZwToU9IzxwUGW3toPoJf
N6bo9L4f/mfEZJxSH9Mps5RILriQaubYorlemArixAspuhQeqzOXEog7OLDblDfO
axsruCudqNT3K/5Ni5QV0a+l5FOyZ91IVzt6zosxtamQ5aTaogEo5HBAZOHt1d/B
f78En0E+CpWWOgzcNSrtKDKdrPfTOyTRAxT2guhFyuWFlRemEJUhlxCr5IXZYPnU
yk8J7aoyuEWNUjB4Q6Qqstg9wXdzSRdB4MlLAHAqMnoT3QZQyoXJ3WdQkmdx4L5J
ka0k86mEE+XGStdH3Tisv7uihT4g/INi+OzhR+rXZj0VEWPlXl7frcqezAPLuWyg
fO0IR2zz6PzaChaysix3HxVHjgSwIt/nsGOxg18QlN8BKCbGSOZwjHt0bTt5p1wm
0VR6PVpDDt7jJELBv/gs7hH2ZbYRQHNTIdH+JCylPiBuUtJzcaM=
=nNIY
-----END PGP SIGNATURE-----

--nextPart4310618.EFodLd8k5E--


