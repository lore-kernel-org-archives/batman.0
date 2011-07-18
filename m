Return-Path: <drwho@virtadpt.net>
Message-ID: <4E24703D.9090000@virtadpt.net>
Date: Mon, 18 Jul 2011 13:41:17 -0400
From: The Doctor <drwho@virtadpt.net>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>
	<201107161734.59403.lindner_marek@yahoo.de>
In-Reply-To: <201107161734.59403.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Battlemesh-like experiment in Washington, DC
Reply-To: drwho@virtadpt.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/16/2011 11:34 AM, Marek Lindner wrote:

> I fail to see the misunderstanding - just because DHCP does not work with 
> $your_protocol does not mean it never works. DHCP is the recommended IP 
> configuration tool in a batman-adv mesh network.

We found that DHCP works well to configure clients of the mesh, but a
possible problem of using it to configure other mesh nodes is too many
nodes running DHCP servers and potentially handing out conflicting
information.  For mesh /nodes/ we have two options on the table: AHCP
(every node will come with ahcpd pre-installed but not running) and
generating pseudo-random RFC 1918 addresses for the network interfaces
done by the control panel, and working fairly well at this early date).

- -- 

The Doctor [412/724/301/703]

PGP: 0x807B17C1 / 7960 1CDC 85C9 0B63 8D9F  DD89 3BD8 FF2B 807B 17C1
WWW: http://drwho.virtadpt.net/

"My mom thinks I'm cool..." --Milhouse

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4kcD0ACgkQO9j/K4B7F8HXGACfeNTfdZKPhp081ISOtR47/y6O
ZCYAoMI9iCw+lt95hVGI5zIqg4aTVFuC
=IMrn
-----END PGP SIGNATURE-----
