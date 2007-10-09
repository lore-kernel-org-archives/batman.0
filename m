Message-ID: <470B45AE.40502@poelzi.org>
Date: Tue, 09 Oct 2007 11:11:10 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
References: <20070608201844.GM20739@localhost>	<200710021059.06583.axel@open-mesh.net>	<560c7c9a0710090025m4c69199dwe9759e46bae5e6ff@mail.gmail.com>
	<200710090953.43820.axel@open-mesh.net>
In-Reply-To: <200710090953.43820.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Axel Neumann wrote:

>> I have tested the OpenVZ livecd with a small window manager (consumes
>> 128MB in RAM), and with 10 instances running batman or olsr, it works
>> fine with 512MB of RAM, but my problem is that the livecd does not
>> supports ebtables it seems, which I need to configure for avoiding
>> bridge shortcuts between the nodes.
>>
>> Does anybody has experience with ebtables? Does it needs a kernel
>> patch? Or it is just user-space?
> 
> If you follow the link in the above lines, you will find a line like:
> 
> ... patched again to fix a bug in the ebtables part of the 2.6.18 kernel 
> extracted from patch-2.6.18.8 from 
> http://www.kernel.org/pub/linux/kernel/v2.6/ and downloadable here...

in openvz usuall all ebtables and iptables modules are supported in the
0 instance. modules that can be used inside of virtuall instances have
to be prepared for this. but this shouldn't be a problem for your setup,
so i guess the problem may be somewhere else.

by the way, if you use reiserfs + raid + lvm you have to switch off the
4k stack patch or your system will run instable :)

kindly regards
 daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHC0Wuy/mkIQp7AD0RAqK3AKC5sVgI7aNVn3+DST8EgbvqTrGOoQCeNTcj
SMjDi5igzJtn45LbA7F+w70=
=9F1u
-----END PGP SIGNATURE-----
