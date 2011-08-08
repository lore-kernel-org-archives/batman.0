Return-Path: <drwho@virtadpt.net>
Message-ID: <4E403367.4060701@virtadpt.net>
Date: Mon, 08 Aug 2011 15:05:11 -0400
From: The Doctor <drwho@virtadpt.net>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>	<4E270F72.10900@virtadpt.net>
	<7izkk8zsr4.fsf@lanthane.pps.jussieu.fr>	<4E28392B.9020209@virtadpt.net>
	<7ibown8v2j.fsf@lanthane.pps.jussieu.fr>
In-Reply-To: <7ibown8v2j.fsf@lanthane.pps.jussieu.fr>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
Cc: b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/21/2011 12:20 PM, Juliusz Chroboczek wrote:

I am sorry this reply has been so delayed, work has been rough lately.

> Oh yeah, there should be no problem in a layer 2 mesh, if the mesh
> implements broadcast (or hacks in some ad hoc smarts related to DHCP).
> AHCP is only needed in a layer 3 mesh.

We also have a solution worked out for layer 3 meshes.  We will be using
DHCP to configure clients, and our control panel application can
pseudo-randomly choose RFC-1918 IP addresses for mesh interfaces if the
user selects it.  AHCP is still an option for configuring other mesh
nodes, we have not yet implemented that.

- -- 

The Doctor [412/724/301/703]

PGP: 0x807B17C1 / 7960 1CDC 85C9 0B63 8D9F  DD89 3BD8 FF2B 807B 17C1
WWW: http://drwho.virtadpt.net/

"Take back, take back, take back the dancefloor!"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5AM2cACgkQO9j/K4B7F8ERngCePSd8L2smWq5phMwX3ryy8ZFV
j9AAnjcCwcJuq+kcfOlyb8caXYLlUupn
=/kkF
-----END PGP SIGNATURE-----
