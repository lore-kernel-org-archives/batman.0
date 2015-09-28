Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 28 Sep 2015 19:35:25 +0200
Message-ID: <1942201.vOz91KHqBg@prime>
In-Reply-To: <5609712B.6020308@gmail.com>
References: <5609712B.6020308@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5066842.veuVSLZoIU";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Suggestions to get extended jsondoc alfred output
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

--nextPart5066842.veuVSLZoIU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Monday 28 September 2015 18:56:11 Germano Massullo wrote:
> I created three Fedora virtual machines to get some alfred jsondoc
> format output. I followed [1] and [2] but I edited some commands because
> virtual machines obviously do not own wireless network interfaces. Since
> it is the first time I use batman+alfred I want to show you the entire
> list of commands (that have been runned on all the virtual machines.) I
> used before asking my question
> 
> # ip link set dev enp0s3 mtu 1532
> # batctl if add enp0s3
> # ip link set bat0 up
> # alfred -i enp0s3 -m
> 
> The    # ip addr     of all virtual machines is [3]
> Then I opened a new console
> 
> # cat /etc/hostname | alfred -s 65
> # alfred -r 65
> then I got [4] as the Examples paragraph [2] suggested

Yup this looks good. :)
> # batadv-vis --format=jsondoc
> and I got [5]

This looks kind of incomplete - there are no neighbor information at all.

> 
> Question: do you have any suggestion how I can extend the jsondoc
> output, to get an output similar to [6]?

I'd suggest to create a new output type (maybe call it netjson?) next to the 
existing ones. If you look in the source code [1] You'll find a couple of 
hooks which are prepared exactly for this purpose.

Thanks!
    Simon

[1] http://git.open-mesh.org/alfred.git/blob/HEAD:/vis/vis.c#l724

> 
> Thank you for your time
> 
> 
> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
> [2] http://downloads.open-mesh.org/batman/manpages/alfred.8.html
> [3] http://i.imgur.com/IR9pSJg.jpg
> [4] http://i.imgur.com/hEP4oV7.jpg
> [5] http://i.imgur.com/Tb1hRHl.jpg
> [6]
> https://github.com/ninuxorg/netdiff/blob/master/tests/static/batman-1%2B1.js
> on

--nextPart5066842.veuVSLZoIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlYJel0ACgkQrzg/fFk7axZBVgCdHlPoy/jnabSfvnC/bx4vdo6J
EYkAoISf2Ybdj2s0YISnKxwhM0DZHzgz
=YRKA
-----END PGP SIGNATURE-----

--nextPart5066842.veuVSLZoIU--

