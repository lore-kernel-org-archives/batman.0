Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 8 Sep 2010 11:42:30 +0200
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<87sk1kiu5m.fsf@basil.nowhere.org>
In-Reply-To: <87sk1kiu5m.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25681580.NLbAIoH7hq";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009081142.31610.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
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
Cc: netdev@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, b.a.t.m.a.n@lists.open-mesh.net, davem@davemloft.net

--nextPart25681580.NLbAIoH7hq
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

here are some raw references without any judgment. Maybe Marek will send so=
me=20
more information about that topic later.

Andi Kleen wrote:
> Sven Eckelmann <sven.eckelmann@gmx.de> writes:
> > B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a routing
> > protocol for multi-hop ad-hoc mesh networks. The networks may be wired =
or
> > wireless. See http://www.open-mesh.org/ for more information and user
> > space tools.
>=20
> It seems rather unusual to have the complete routing protocol in
> kernel. And this is a lot of code. The normal way to do such things is
> to have the routing policy etc. in a user daemon and only let the kernel
> provide some services to this.
>=20
> Could you elaborate a bit why this approach was not chosen?
>=20
> I assume if it needs a switch it could have a switching "hot path" layer
> in kernel and the policy somewhere else.

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-July/003119.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-July/003120.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-July/003121.html

Just as note: the mentioned parts which move to the userspace or stays insi=
de=20
the kernel doesn't include the parts which must be added as interface for=20
other kernel modules/userspace daemon.

> You write
>=20
> > +Batman advanced was implemented as a Linux kernel driver  to  re-
> > +duce the overhead to a minimum. It does not depend on any (other)
>=20
> What overhead exactly?

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-June/003029.html

So the mentioned overhead was related to throughput and latency of the actu=
al=20
data packets send over the complete userspace implementation (receiving stu=
ff,=20
getting stuff from kernel, modifying it, putting it back in the kernel,=20
sending it).

Best regards,
	Sven

--nextPart25681580.NLbAIoH7hq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMh1qGAAoJEF2HCgfBJntGbuUQAKQH42AGEnoP03bTH4glCBHT
CkRtve5+l4PRnuaa17qkJzk3OykexHuykPUUIkmGTz6DPHVe6oagmpPX8+eok4qI
LE6tdOdX785DRTgL6nBjgEn4Po6r1o6W9/HQdG90kZTzQUAhzJSQvNGyDyDvnD3t
k50N0qZ0zwTKGen58FNf4rBGF6MU+aS9bFT59tFuv0L2qqfqDrDg+QOE5HeHSRLJ
wceQvocRsHM3r79UuxhWukBxJCJ8juaz951Y6mL0nxEmfqvnwCMqJT3JquulqKN7
LKDnZRhNLY9+8EhoWWqCQhguZBn3byfle9QgDd/2SwO9XRU2T1dqwVYmjcopG1Zs
z/2rolrpg9rt9QyJECfgS4KmNzHZEBmMel0Hol5dYzTgVPEWA3qufzoxz+9buZLv
nYDqaVrKcNKstc3NkWc5WZ72V+b1Em0qIE5WTrANQo80bKvMrfZZDdV8cLx8pV5p
hJNcrPXJdXTuGUhbCIa9U4i0eswk2uYTDD42IlrD7worZTb9/AETxxTfJRz9IOH8
rh/9HtKh4tQkBS9wa65nr9VcWLf5Yufpjbu/dr4GATmlanA8yEDN7MFkBKenQWUF
PDWmzbSIzp2YHQDsn4rS72xmU6lNansadlV+8j+k+uR7JAR7jaeSZ1KGQBhUSXSM
NE5nI+ZP1CFVjKCOH+KR
=oCfH
-----END PGP SIGNATURE-----

--nextPart25681580.NLbAIoH7hq--
