Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 01 Aug 2012 12:19:10 +0200
Message-ID: <9467854.H6YUclFirY@bentobox>
In-Reply-To: <CAMVTf1iTYLNL9xAuXsRwiAexNAfXmf5zPXocv=qrcWYSVBmYhA@mail.gmail.com>
References: <CAMVTf1iTYLNL9xAuXsRwiAexNAfXmf5zPXocv=qrcWYSVBmYhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24001079.KQHbu9FGfb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Problems to add Batman-adv in wlan0 Nanostation
	M5
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


--nextPart24001079.KQHbu9FGfb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 31 July 2012 11:41:15 Esteban Municio wrote:
> Hi all
> 
> I`m working on a academic develop project for improve the networks in
> rural areas in Peru. We are doing some test with 6 Nanostation M5 for
> create a mesh network.
> 
> I tried Commotion software with OLSR and all was Ok. Now, we are
> testing BATMAN, with OpenWRT and batman-adv module, but I have some
> problems.
> 
> I have compiled OpenWrt Backfire r32751 (Load: 0.09 0.10 0.05) and
> installed batman-adv with opkg following this
> http://wiki.openwrt.org/inbox/mesh.batman

Why are you installing it with opkg? This sounds a little bit like you try to
load a kernel module that wasn't compiled for the kernel that is running on
the machine (which would be extreme bad when there are ABI differences). Also
this "pizza" link you showed at the bottom of the mail gives the impression
that you may have done something like that.

The best way is to include it in your image.

> When I put:
> lsmod | grep batman
> I get
> batman_adv             67936  0
> 
> and seems to be load in the kernel
> 
> But when I try to add the interface wlan0 for activate batman in it,
> the Nanostation remains locked and i need to reboot.
> I have tried this with:
> 
> echo bat0 > /sys/class/net/wlan0/batman_adv/mesh_iface
> 
> and
> 
> batctl if add wlan0
> 
> with the same bad result.
> What am i doing wrong?

Hard to tell with the information we got here. Are you using the serial console
on your device? Does it print a backtrace (can you create a backtrace with
symbol tables enabled)? Are you sure that the kernel and batman-adv module are
100% binary compatible? What version of batman-adv is it? Did you try the
newest openwrt devel package from
 http://downloads.open-mesh.org/svn/openwrt-feed/ (i think the package is
called kmod-batman-adv-devel)?

batctl: acd06db051419d3b323675ab2d7c897f2a5efc2a
batman-adv: 3fdeaa6bfb404311b73a689e984672161403a0c2

[...]
> I have noticed that i have not the bat0 interface created,is it normal?
> Do i need create another aditional interface like ath0?

bat0 (or any other name you choose for your batman-adv device(s)) are created
after you attach an interface to it (this is what you are doing when you say
that your node "freezes").

> I have been following that manuals:
> http://pizza.hskflashcards.com/index.php?page=B.A.T.M.A.N.+Advanced+on+OpenW
> rt+How-To

Uh, please don't use this one. It is outdated as hell and has nearly nothing
to do with the stuff you are using (or at least should use).

> Do you recomend me to change to batmand instead?

Just to give an impression:

Latest release of batmand:
 http://git.open-mesh.org/batmand.git/commit/3aeebaf87974a069278a3feee31345da664fc090

Latest release of batman-adv
 http://git.open-mesh.org/batman-adv.git/commit/b82d11e243ec144c515e7d04e8e8c31b111a060d

Commits in batmand in the last 6 months (master branch): 0
Commits in batman-adv in the last 6 months (master branch): ~250 (and this does
not include all the stuff that happens before a change is accepted)

Of course, this can also be a sign of perfection. But I can say for sure that
the most development in the last two years happened in batman-adv and not in
batmand.

> Do you know if there is any BATMAN implementation for a mesh network
> of Nanostation M5, easier to install and manipulate?

Um, even easier? At least I find it extreme easy to get it running:

$ modprobe batman-adv
$ batctl -m bat4 interface add eth0
$ ip addr add 192.168.3.11/24 dev bat4
$ ip link set dev bat4 up
$ batctl -m bat4 originators

And only step 1 and 2 are batman-adv relevant. The rest is just to configure the
usual stuff and step 5 to check for detected originators. And "-m bat4" is
optional. I just wanted to call my device bat4. Please let me know how this can
be made easier without restricting users.

And why are you refering to a specific product? I thought that you just use
OpenWRT.

Kind regards,
	Sven
--nextPart24001079.KQHbu9FGfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQGQKeAAoJEF2HCgfBJntGVcsQAMqGaZrbzFKXLZfjET0uphW4
hrsF2fIAL6rPmXhtMsxvSTHfGDGbXLKggJxWW5q10Va7viqUlmxygRdcbiGBuyfb
2pwhkaokdLja33z+wZKTiXwqa0GGAEmSuKDhm2NVBQuvrZ9rNGVd2fCqSGQgNYFb
PJ6j2beiz5quH/f8y2HaF2+usnVwdqD/zR+rHxIJYfVjR0nL7WXNDNIvYum/lldZ
nxA3++N7vSe5kAnKeuRNUyKKuv5Up7H/QITPtqnKh44jicflyNWwV7MlZC1tJHyg
Oabch3BUfh4tIceCSDRjMxDbqXcUB7qG3wZ8QLctFgMS4OEWeFmAkYlIsrxu+LLR
90ng0VFR9WLJwp8F1dGrhPuCXKoxaTQzaiy0RvQAlQyT4NPRgNdYDwwfTkWRDm/s
GM15+pzytCEk0JoYLshr1FAhoT7ljOZ795cBeAZqPn9myxrwCCzHDmzz+FRVAerS
AXJiqAVwDBA1iRyKZkK31x004vQKbTFWNSZ41inLqMfEfuiiExsV1GV2Dod1Jewo
pFShIZAVdWdN0+ZBIMQABLJYvx2lCHVPgNEUeG8Htdzvn8wn3Vwkjh3FEwKPaZ/C
91DbNtWfLMNRg0Hxt5jd3A8hPTWqtk/mLciSQLg8mpB+cyb0qlqbfLq2BVtZ7e+G
qdwVIJ7CqQzDiIU4ASw9
=vgWj
-----END PGP SIGNATURE-----

--nextPart24001079.KQHbu9FGfb--

