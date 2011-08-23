Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Aug 2011 12:32:22 +0200
Message-ID: <30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
In-Reply-To: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1508196.1kQM9SBb4c";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] A case for batman-11s
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
Cc: devel@lists.open80211s.org, Clara Gnos <clara.gnos@googlemail.com>, Javier Cardona <javier@cozybit.com>


--nextPart1508196.1kQM9SBb4c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 22 August 2011 16:30:56 Javier Cardona wrote:
> Which brings me to the main point of my e-mail:  is anyone out there
> interested in porting batman's path selection algorithm into
> open80211s?

Which one? There are ~5 revisions of the algorithm (not implementations). The 
newest iteration is B.A.T.M.A.N. V and is currently in the research and 
prototyping phase. The algorithm described in the RFC draft was B.A.T.M.A.N. 
III

...but I am not interested in implementing it for 802.11s. Maybe there is 
somebody else. Most people are currently focused on batman-adv. So I will 
write this response with batman-adv in mind.

> The benefits:

I only see benefits mentioned by you, but were are the disadvantages? I don't 
think that a marketing mail is a good start for a serious discussion.

> 1. By being based on a standard, you'll know you won't be colliding
> with other layer 2 technologies (for instance, no need to define your
> own ethertype)

At least batman-adv is quite happy about the fact that it is based on a widely 
used standard technology. And defining another identificator instead of an 
ethertype doesn't make a big difference to me.

But why are we colliding with any other layer 2 technologies? It sounds like 
"uh, you are so bad. you kill cute bunnies", but I don't see the "colliding" 
problem here. Maybe you mean the missing ethertype registration (anyone got 
$2500 for us?).

> 2. You can leverage most of open80211s, from test tools to wireshark
> patches.

batman-adv also has wireshark integration (already upstream) and test tools.

> 3. By being integrated in the kernel's 802.11 stack, you can take
> advantage of the development that's taking place there, from encrypted
> management frames to HT support.

Aren't all those things part of the layer _below_ batman-adv? Why should we 
care about it when the stuff we use has to deal with it.

> 4. You can reach out to a larger development community and raise
> awareness about batman.

What larger development community? At least the open80211s community seems to 
be a lot more silent.

> 5. A big problem in mesh adoption on Linux is not the mesh protocol
> itself but the absence of simple to use configuration tools (e.g. no
> mesh support in ConnMan, NetworkManager, etc.).  By providing a
> unified wireless mesh framework we increase the likelihood of having
> some support at the distro level.

Hm, maybe we have a different target audience. batman-adv is made for 
routers/APs and not for desktop systems. Thats why it has client mac 
propagation, bridge loop avoidence and roaming announcements (and many more 
things with funny names). And we already have a relative good distro 
integration for our target group...

> and last, but not least...
> 6. You'll be able to say authoritatively that batman is X times more
> efficient than HWMP (pick any X greater than 1 :)

And this is important because... And can be measured by... And uses the normed 
scale...

Maybe you should visit a Wireless Battle of the Mesh and tell them how such a 
benchmark is correctly done.

Greetings,
	Sven
--nextPart1508196.1kQM9SBb4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOU4G2AAoJEF2HCgfBJntGObYP/1eoAiukZg1Z3HeYWaoiwb/T
/pwWY2VU97mZhDJdnfxb7ydpjLpeyNkTvw3pnpTG1y7Py9MVIqo3WfRSfwY+cvO1
gNTek0EjwgQBDir8tjze+U6xfyp3JjBpMPcYAPxerF11VBOpz871FX9sO61xdexM
g3qO8SAsF1Rna/dKpyBjyY0CAX2WykITSQosaXPemxOaw6MILoDT/kNyMkj+lnuj
iKZhJb3G3lWrqlIA+1iETy1+zGy7mloOBN/sxR2uBpjSlDP8+US+8pRQp5ZIcAtC
DTpVcjRbvLqXj49mk3bpnar8v0t9KPoIKJ6064mNQ2lA5csHh3bBmQpXsMy0ZbSF
V/pVf0ROSDH7ZwzgynToSfS/v2XbzdoyZr128NrWOrLv21ocgFSscxE+1MXp3tvA
QQmlKClOqEuGGF06X+H708OkFwqU3SgILgSgUtTLzhREGLifEtgoIy+YZZ9jX6D3
ofoh3t3G6XMQ757iyBUTCOLltvjig846SncCeGW7eEqiZ9eDEaL2GB7epvDgu+46
DhIjORPtPiVj4K12dEU2LSaFfbSV1/Rsb1t5YHmIEyS1JiaLTJVngue3dLbpD36+
Xx494IhjmWOwWNmFbAY1GuZEKH+hULhwnyfyiJ/jaRRVB6aFrxF6CuGkgciqhmwe
jkkneKFm9PzhCnD96OiU
=hqek
-----END PGP SIGNATURE-----

--nextPart1508196.1kQM9SBb4c--

