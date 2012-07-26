Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <5010BC32.5050606@codigosur.org>
Date: Thu, 26 Jul 2012 00:40:34 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAHD-aqLxF0HHXbW0YtZa700qbUytyv3Gd40FC6E7nRWLMD-=Ew@mail.gmail.com>
 <20120724070603.GI3610@ritirata.org>
In-Reply-To: <20120724070603.GI3610@ritirata.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] avahi broadcasts over two-radio batman.. dropped?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/24/2012 04:06 AM, Antonio Quartulli wrote:

> I trust you on this because there are too many rules :) (have you
> tried a 'iptables -F' just in case?)

Antonio, I tried iptables -F today but nothing changed. Tried iptables
- -F along the whole route, and still no difference.

> is BLA2 enabled on czuk?

yes BLA2 is enabled on every node by default. I've also tried
disabling in every involved node but it made no difference.


I'm testing now on a different route (see Guido's graphic on first
mail for reference): from a computer connected through ethernet (no
batman) at nicoyjesi to one connected the same way to marisa-mr. The
same thing happens: when I run avahi-resolve it gets to the computer
at marisa's, which responds as it should, but the response never gets
to the other end.

this is what the setup looks like:

pc1===nicoyjesi==b==nogal - - - - marisa-blt==b==marisa-mr===pc2

==b== is bat-enabled ethernet
=== ethernet
- - - - bat-enabled adhoc link

I'm out of ideas here... but I'll sleep it over and chat again with
Guido tomorrow to try to find out some way to at least reduce this to
the smallest possible setup to reproduce the problem.

On a side-note, avahi is not completely broken, it actually works
(from user experience) as if there were no batman on the net, those on
the same phisical portion of the net can see and interact with each
other just fine; it does not even always fail when more nodes are
involved I just can't seem to find a pattern just yet.


cheers,
Nico


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJQELwyAAoJEElSmZeKi74/O9IH/1Kphkl2oghN8f9YkDGczeOV
L/8nTVFXlDftfHPgcSZfNieLLZwK/hL9cieGZ4+vrpEPSw5gv3qDq3dKeEEkAVdG
1DTWl77dEgvz9B9uHkKUq3HEbPlEQiPGbISJlsxhKvtyWZcNfimFzggjU23DahKC
ptGymL44cTX0JijvEnHPBsAV59dhYg7EsbQv+/nNqfSKhiif2XANIFxqQoae8wr2
fAdoH2huhUx5ze8UqYmjZwXGXPOo75UgqViE2DLsw98p4urre8FvqYRD682xiEb1
9pxIO68WyQanf/Gk0VQXa9Wp/DVEU398pnvkTaarvxC34yRumkmyBDB8dD9WQDE=
=n3fu
-----END PGP SIGNATURE-----
