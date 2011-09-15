Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Sep 2011 16:17:19 +0200
Message-ID: <1618735.6vzXCZcuLY@sven-desktop.home.narfation.org>
In-Reply-To: <d477c5ac8b5c4fea9529957152699501.squirrel@clownix.net>
References: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
	<14791148.Lch9XMektA@sven-desktop.home.narfation.org>
	<d477c5ac8b5c4fea9529957152699501.squirrel@clownix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3609636.MI55ZY7X7W";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] lxc and batman
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
To: clownix@clownix.net
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3609636.MI55ZY7X7W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 15 September 2011 08:40:15 clownix@clownix.net wrote:
> So, for the multiplication of machines in a big network, you confirm that
> batman-adv is not compatible with lxc.

I never said that it is not compatible with lxc

> However something is still not clear: with one batman-adv per namespace,
> would it be possible to have what you have with kvm but with lxc?

No, this is not possible by definition. kvm == multiple batman-adv instances, 
batman-adv in lxc == one instance with interfaces in different namespaces.

> The gain for this work would be only performance, the useful scenario
> being no other than what you have with kvm: big (independant) networks.

No, by definition those networks aren't independent as they share resources 
inside batman-adv (and many other resources).

As far as I understand: You want to create batman-adv interfaces in different 
namespaces without having colliding names. Feel free to submit patches for it 
(or enthuse some developers with spare time).

But I am still waiting for an actual usage scenario. KVM is mostly used for 
debugging purposes... something were we want to have separate instances which 
don't crash the developer machine. And I don't see the reason for having the 
overhead of batman-adv in all namespaces instead of a single entry/exit point.

Kind regards,
	Sven
--nextPart3609636.MI55ZY7X7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOcgjvAAoJEF2HCgfBJntGoG4P/jgRg37vz7yrZTzt6kp9jgES
rTuaKXjHIrhGT4wPxvs8nZtzX8p1jBNB23AuOvkft2INCxzHwTjY1zgBtOwRTwHI
NYkWV+M9ADJwS4A9mY6ynHHpkq+qzsxNSGpfSQX3fNrBKw4FxVIhaoQ9QVP7uATT
O1zXhX0kCEFamJwW1dZLNYBnSsd8yvZHCQzTg+gRAeQZbHDeWHScNCaBDJy2SYWJ
fuuYfPAnyLX1caOCM6FylKff7j2crm7HSGeHy9vAvhZ/LvbhoEEM0gWoxvNHZtQQ
xZlI+gKrA3RHqmY537FEgbNUAz+p4xBJg7gHJH9MqDgPFxE2C4kqP/kZFOma6EX9
+MIiM4dLUnBGH3dbz+9lYUO6/DvNPF9Mio+deJKImw+SYmkDVkDBSD7kYZ+UV3hm
UOgnorihE2hrXSVHXi6ZH9aceM6vigFk/2PyaaYv4ZEmdHogqzQTa+B0W2hLyi2O
jB7Da+eqFTQMjBp5id8K91/gtELhlHHfcw15XT8xufbMl/X2rBERCFb2GRHcqLee
fcuipq36jpwpJSpLT56Oa2+vHbWT2+nD0Pim/LNxMx92sQ3rLhNhWm09HSJhQKKF
H7aeOAAbfcFuMKg68H7FvDU2t3VZ9ZqesMKsI7/3XKcac6hCmvkJHRKbxSfLqSpk
dEns0z58oMBzLutV4EPA
=5mHb
-----END PGP SIGNATURE-----

--nextPart3609636.MI55ZY7X7W--

