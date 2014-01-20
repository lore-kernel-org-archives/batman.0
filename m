Return-Path: <James.Hogan@imgtec.com>
Message-ID: <52DD0869.10803@imgtec.com>
Date: Mon, 20 Jan 2014 11:28:41 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
References: <52DA65F4.5070501@gmail.com> <52DA7B9E.4040202@meshcoding.com>
 <4915262.qEFumRrH4p@radagast> <52DB9B39.9090502@meshcoding.com>
In-Reply-To: <52DB9B39.9090502@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7Io76bbmjhjPP46d6rdkmNvaLnFt81GA6"
Subject: Re: [B.A.T.M.A.N.] [PATCH linux-next] net: batman-adv: use
 "__packed __aligned(2)" for each structure instead of "__packed(2)" region
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-metag@vger.kernel.org, David Miller <davem@davemloft.net>, Chen Gang <gang.chen.5i5j@gmail.com>

--7Io76bbmjhjPP46d6rdkmNvaLnFt81GA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On 19/01/14 09:30, Antonio Quartulli wrote:
> On 19/01/14 02:10, James Hogan wrote:
>> It appears that the following gcc patch adds support for #pragma pack:=

>> http://gcc.gnu.org/ml/gcc-patches/2006-10/msg01115.html
>>
>> I gave it a quick spin on metag gcc (which is unfortunately stuck on a=
n old=20
>> version) and it seems to fix my simple test case so that #pragma pack(=
2)=20
>> becomes equivalent to __packed __aligned(2) (for sizeof and __alignof_=
_).
>>
>=20
> Then I personally think that it is better to fix metag gcc instead of
> changing the kernel.

Indeed it makes sense to patch metag gcc to be safe in the presence of
unportable code like this.

> Actually there are many different spots where "#pragma pack" is used.
> batman-adv is just the only one having compile time checks for structur=
e
> sizes.

Well the only vaguely interesting one I can find outside of drivers is
in fs/udf, and even that seems specific to CD-ROMs and DVDs.

If you care about portability then Chen's patch looks reasonable to me.

Cheers
James


--7Io76bbmjhjPP46d6rdkmNvaLnFt81GA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJS3QhxAAoJEKHZs+irPybf8XUQALMq71nsIxtg+4blW6SX3b4D
/5+lIHezcn7fExlExW4LjnjJb3t1jfYNZGeAW6Ek9Y58EyXHmloPfytkJ+BM2saB
WTzRTGn0uKlxAITVvR52QH2pZp6mS/5J0hcVaABf/hq85iq+sSKjtveMiopdJKoY
vUr4hRdQH01r7nOVsM9hTJZKMxXmAvcr1tTaKv65pZD78GWvXSws+oscUqdSe8uw
koHAO0hroC8HYT5ZGthpIXFL4/WT3c0CyRvR2oFPdO0OB/zEj2X4RtkitBHL6B+Y
ps/66uTU/zkljqtQ7lxujGdZ4iFL65GmkFoHiTnEt2ulWneMt5FI3KWG1kMC9+rI
9QRFbpJauo93Gw/xzFBL3rQvRY+WWhh3gWiSJ+tL2Q9eNmjwCJfKRmIVXArVugSJ
a6s1lMhA8Wabk0mVx2tfFyKoB5kSymzNunDjjslo40jlTWyHIMtBGZeHw4/KLGzA
sX+zlv2bjWfkrXhIYctorbybQslbc8lXPtcZVdaQcZCO+r0eT66wIxOXoFNSzBh8
HY7T68URxz3Wm4bdbkExk9dZqyK2Db6ejEcApHUn1TOpscoeWWwtpyd2xM+6j1eR
+FVcujHzl3ReYA7RyQfnR3xkVUHkONfQzkrxSeNuvE1bdrY8qcz3dBjJlLC+GMhA
TWxGDvU610FPo7Dx85qo
=dYNL
-----END PGP SIGNATURE-----

--7Io76bbmjhjPP46d6rdkmNvaLnFt81GA6--

