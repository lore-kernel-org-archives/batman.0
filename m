Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Wed, 12 Jun 2019 14:39:08 +0800
Message-ID: <3147211.nMDzSnZuI7@rousseau>
In-Reply-To: <CALYz8yoqh8X3hZcafrZAauFT4OZtQZ9r92G+9zW9__ir4m5How@mail.gmail.com>
References: <20190609101922.2366-1-treffer@measite.de>
 <4907494.lMUJSmCnaO@rousseau>
 <CALYz8yoqh8X3hZcafrZAauFT4OZtQZ9r92G+9zW9__ir4m5How@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3091147.e1IllxpMCp";
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

--nextPart3091147.e1IllxpMCp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> I have a working solution for this problem. It is not batman-related,
> but I decided to share it with you right here.
> Please let me clarify some  details.
> 
> 1) Some ath10k firmwares (10.2) do not export tx bitrate. So we can't
> rely on it.
> 2) Throughput estimation is better to inject from userspace, rather
> than make batman estimate it from unreliable sources.
> 3) Here is the patch for mac80211 We made for ath10k and such drivers
> that do not export expected throughput value.

you are very right about those issues. However, your patch only provides a 
quick way to push an arbitrary throughput metric into the batman-adv kernel 
module. The current discussion is about how such metric could be best derived 
in an automated fashion. 

Would you mind sharing your approach to obtaining such a metric that addresses 
the problems mentioned above ?

Thanks,
Marek


--nextPart3091147.e1IllxpMCp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl0Ang0ACgkQU1VOj+62
HMCwTQf/WZR01gzPUzbboQc1IfKbvFq1gIFtq4lqCHbE8njB3Wz3jkxlp7E9asSP
CZZwSH0XpK0lnKItMwjA6b3t7KtUC37VaSPhf0sovg98uLq1GelsyCAokctzV7Gd
yYyDMiiovVR66GFkDKOjgqfqhT/3ze+6YKK8+ni41q/TrjCiWmaJipI8ZI6+YYbf
Mla0O6GgX3wld1BjT58XbJu8ls1tMLNFdfbexbFbVZBdpBFtRktiiCtiMJvnoJZY
dNOp3rL8WRnbE8R+9QpGMoWTzyokgsS3LlE4nQekPk1soenBPaYUfaep/lWUjzBw
PKRUt2dGS8QUnMXdnhWtxnRRD5qEUA==
=B4qw
-----END PGP SIGNATURE-----

--nextPart3091147.e1IllxpMCp--



