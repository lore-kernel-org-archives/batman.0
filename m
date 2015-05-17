Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 11:49:43 +0200
Message-ID: <3626619.uHAxS8eyu2@sven-edge>
In-Reply-To: <20150517113726.47de614d@i3.local>
References: <20150517113726.47de614d@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24688842.CSkVY4FZ7A";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] fix algorithm,
	which was unintentional changed on update from  2013 to 2014
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


--nextPart24688842.CSkVY4FZ7A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 17 May 2015 11:37:26 Ruben Wisniewski wrote:
> This patch restores the unintentional change on commit
> 
> http://www.open-mesh.org/projects/batman-adv/repository/revisions/0853ec7faf
> e0a195754454832993c6b35e22b842/diff/gateway_client.c

Please use a format more like in the commit I've showed in the last mail about 
this patch and not such a link. The relevant documentation about it can be 
found in https://www.kernel.org/doc/Documentation/SubmittingPatches under "2) 
Describe your changes."

Also the patch subject is... see the other mails and the mentioned 
documentation in it.

> Original the algorithm uses kbit for calculation, now the values are
> stored as "mbit*10" so we have to multiply it with 100 to restore the old
> behavior.

Things I miss in the commit message: why is the old behavior better? What 
problem was introduced because of the missing " * 100".

Kind regards,
	Sven
--nextPart24688842.CSkVY4FZ7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVWGQ3AAoJEF2HCgfBJntG/iMP/An+C0sgqXVGpMemijDPaDz6
6Jz9XQOjl0aGv3jLVwzeycUqul0HbDymem3iBDWDR3Hyr0rXfYu58qdF+rAdQx/Z
ZnAtfdbkx1yH+Ej9Fz3v8Vh/CWHH1GPUAuRPELiDAO2L1Z1L4ATVqMKO59hImex6
IeD0OAia4tDNwQYFvNL1gtad/R1CfswE5EXSIQ5rCxMGUxGGBBaNO7oX4hGUWZm0
n7mrh4lp8YFwpaayGbFgm1yeWdxOBdXy9KA9hrIPQbe7vXnTqSLYh49k9BOJJgfo
6rYa8PPX3oK91kcz5Exx7A55I6qNwl0EzvVwubapQEMTRZ9RalTiBY4/29A2OBgp
C9P/rdTe2TSxgeKAcjuqEF/prHqJYfOdHPhQk6wbDuznaEwfeF1SAGwnxL+dJHct
QeTDNA1JalLZe3KbBhtgydW2DLuJh7dd+NMhcvc01zO3QSziaIriNwqPZL+e4u33
k/Rz3wXBqcIQ6ix1k+vP7rYJZfVRKqThfA/q0szqA9EALBjZlCkPAoumzZ1scJkR
Ni0sb9IRSDvHXUrKf5/jkXjqQJNyfODwugIOQfzNoNCG4hhQIqSPjaxlnXiOjnFO
ng6R3gwA+1cfplwcvzdJGafig8QkEJHzbn1mViIsJLnjp3Jw+zGhagEWfC2iiwIu
WbZA3LkmXSnQgnkafvVL
=clh9
-----END PGP SIGNATURE-----

--nextPart24688842.CSkVY4FZ7A--

