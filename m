Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Oct 2018 20:11:45 +0200
Message-ID: <2661988.k0dbZFdg2j@prime>
In-Reply-To: <CAPzaX0ic23YurEjexLgNq4x6aaAp38f4Nj=iMfNDbLXkHCwhXQ@mail.gmail.com>
References: <CAPzaX0ic23YurEjexLgNq4x6aaAp38f4Nj=iMfNDbLXkHCwhXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3057845.Wo0cIMTkef";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Version help
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
Cc: Corey Combs <combsca90@gmail.com>

--nextPart3057845.Wo0cIMTkef
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Corey,

there are some differences between batman-adv <2013.4 and after that. Please 
see here:

https://www.open-mesh.org/projects/batman-adv/wiki/Compatversion

In general, we would advise to update both Kernelmodule and batctl to 
something newer. 2012 is ... ancient.

Cheers,
     Simon

Monday, October 22, 2018 1:51:21 PM CEST Corey Combs wrote:
> Hello,
> 
> I'm currently working on a project that uses BATMAN for a mesh network
> across multiple Beagle Bone Blacks which are running a Debian version
> 7.9 at the moment.  They also are running batctl debian-2012.1.0-1
> [batman-adv 2012.5.0].  I would like to connect a laptop to the
> existing network either using Debian or Ubuntu, however I have run
> into issues with compatibility.  I configured everything identically
> with the laptop and I believe I'm connected to the network, but I
> cannot see any other devices on the network.  Is it advisable to
> upgrade the version of batctl on the 'bone or downgrade the version on
> debian or Ubuntu so that the versions align?  Or is there something
> else I am missing in my efforts?
> 
> My process for configuring the BBB and the laptop follow this
> construct, using appropriate hardware names when required.  I have it
> all in a script that runs on startup so it differs a little from the
> lines below.  Each node has it's own assigned IP address as well.
> 
> modprobe batman-adv
> batctl if add eth0
> ifup wlan0
> ifconfig wlan0
> ifconfig wlan0 down
> ifconfig wlan0 mtu 1532
> iwconfig wlan0 mode ad-hoc essid reynoldsplus ap CA:FE:C0:DE:F0:0D channel
> 11 batctl if add wlan0
> ifconfig wlan0 up
> ifconfig bat0 up
> ifconfig bat0 10.200.8.1
> route add default gw 10.0.99.1
> echo bat0 > /sys/class/net/eth0/batman_adv/mesh_iface
> echo 1 > /proc/sys/net/ipv4/ip_forward
> 
> Thank you.
> 
> Corey


--nextPart3057845.Wo0cIMTkef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvOEuEACgkQoSvjmEKS
nqF+ERAAwu1s7nm94pi37IMbgPvfxokl4tF2EihhXwSCtHLUkx/fzplcgVbUWDcF
3Cti6K9tvSJb+c/w+0ADzrul2TEwMPKN1+iNzZrIZsiobSRZADyI9x5rXj6DEMVj
1p62gJ/NbzaQiY8XmXsvOSYKFuRqcsUrk+ekT3FMSp6WZ4tianIuFJsSEukS0z+B
j+30958PV19aLuSzg7RVdFC5BykTtu+Pwo2q1eq3vo2/SJ6dqi8dWMOXWCfJ/8fx
OrF1BKbcWPbk6qFzInamJCrA9BJgQmp3oKH4NkzXhpGT/biovMIBvMiAbYJtWGeD
brWzh4NkZe+Yt/bsWEx1Y7jjK4kQ58gFdnscS7zKixrDUtAYkp9kLjc+bc5gI3Kv
MkgUALE2wipzVA0LLGp1kWn2enFqwViJvR0rEJGoUkMhCKIul/TusEGYS76GsSEj
GQ2465kuwsTXAq8kkDaqPVAiQPJr8Ox7fZyppiofTnufqZ43AyQew8/01L3pfJPq
eULhGBIopmE7C0XrUc3i6mQoEPUKSUQyOM+ijWFFAy5G/ydbY0w0WSc25ikHvrub
jw9sR+GE5DCnxgumCcfwD8TWAR0sH18VnbOmgEr08eaOVlwn83hh31asGXIlAnO9
F7+aU5P0V/lW5aTTFXZq+Jn6vQYk+mYvaJhnItdjDBi1giWLrn0=
=jj2h
-----END PGP SIGNATURE-----

--nextPart3057845.Wo0cIMTkef--

