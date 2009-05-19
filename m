From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 May 2009 21:21:03 +0200
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
In-Reply-To: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1884861.j2vUPNCexQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200905192121.08028.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Kernel crashes with batgat installed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--nextPart1884861.j2vUPNCexQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
thanks for your report. I am currently running some stress tests on x86 and=
=20
mips and couldn't reproduce any such problems. So I have some questions=20
regarding your configuration.

On Tuesday 19 May 2009 16:27:25 Nathan Wharton wrote:
> I am using batman 1256 on a very recent openwrt (linux version
> 2.6.28.10) as well as a bit older one (linux version 2.6.26.8).
What is your target architecture in openwrt?  Have you tried to reproduce t=
hat=20
problem on another architecture?

> With batgat installed, I have problems with the kernel crashing when
> turning the gateway on and off.  I start batman with -r 2.  If I
> detect an uplink, I issue -c -g 11000.  If I lose the link, I issue -c
> -r 2.  It is this final -c -r 2 that causes the kernel to either crash
> with a bad page on the next process that is created, have a null
> pointer error, or have a recursion error.
Can you create a readable kernel backtrace with ksymoops?

> If I run batman without batgat, I don't get any crashes.
>
> Everything works fine otherwise.  Except one thing that just came to
> mind, I had to remove -DDEBUG_MALLOC -DMEMORY_USAGE because batman
> wouldn't do anything without crashing because of magic number
> problems.  Could this be because I am on Big Endian hardware?
I am running it also on big endian hardware and it seems to work. Does it=20
happen right after the start or were extra interaction needed? What was the=
=20
error output?

> Could anyone else see if they have the same problem?  All you have to
> do is have batman running with batgat installed, start issuing batmand
> -c -g 11000 ; batmand -c -r 2 multiple times and see if their system
> stays stable.
I am running it in a while true loop since an hour on x86 and mips on isola=
ted=20
and non isolated (single partner) nodes and didn't get such problems.

Regards,
	Sven

--nextPart1884861.j2vUPNCexQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKEwagAAoJEF2HCgfBJntGtXMQAIclaQu/JlBrhSgByxI0EfWM
X3xWLuhzOjnfcBt1DSF7QdUHMNVsrHMWgIU9NLwhsPMtQ/JxGF+RqSveEuw7mv16
w6BYE76nc5IBicu8VtyV9V/pksCuAcEtzPO6ztzkWdJDkLftX3O+f5xBQNgUi4Vt
DB+ROKVh9l/aYUEgkOpJAWHIeGL9vCY0wlAycJHa2rvVy/jrZVJz4Atux8jpKKCP
LwBs2S0+7Ln535h710CFVJJlI9AanbOoT4y+t9s4BOxj87o9AL2spDQWeub7/n4p
Qzdm6rEjgBDaZJnyxiJDZrDiXAUSLt7Lld1JQqqf+48LjjspbyctKdydO9h4dgg6
z2u9jXWgd95MVh4REKa54+8YutDuPkP1otF+jMlVaFvIWHXXZYOJ63aHRMokirHm
kJ/IgEBp9Cw5NFRlXqY3watYxNbY460Xzau3dNKcgkZdEel18vU0T6Ux4MxNd0PM
oQ8114ZZztnB8XRTTVGTZt8N+fFTo6igHPRX/oSD6XbKmITbzhuJEgk61uu3C9c6
Kl00YfiZG2ShwmVJs2hlWV5dutZxEjQqcYPeco3gmcY+at0Zy8zxJCcX1nLVXuXr
IEEDmEEhv99S77s3u8UnipxAq5frjViBP4a9EyQy+ZRgaLuMExGxsvo8g5/5M4iY
0toU2azr/fjeK/TCP108
=EgP9
-----END PGP SIGNATURE-----

--nextPart1884861.j2vUPNCexQ--
