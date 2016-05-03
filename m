Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 03 May 2016 13:28:16 +0100
Message-ID: <5437772.flAExnCRQc@prime>
In-Reply-To: <1894217.a7ufKNXfSr@bentobox>
References: <1894217.a7ufKNXfSr@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4328060.oCiueURKrN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v3] Add throughput meter support
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart4328060.oCiueURKrN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 03 May 2016 10:59:07 Sven Eckelmann wrote:
> Hi,
> 
> here is the third version of the throughput meter support. It is just a
> rebased version of the patchset with two little bugfixes. Both problems were
> detected and reported by Antonio:
> 
>  * batctl didn't check if the test_time is > 0 before doing a division
>  * batman-adv wasn't returning an error to batctl when dst was not reachable
> 
> 
> I am currently unsure how we should proceed regarding the ICMP packet type
> used to communicate to the userspace ([PATCH 2/3]). Andrew+Matthias already
> prepared a netlink patchset which looks quite good and which should be
> tested+applied. The consequence for this patchset would be that patch 2
> should be completely dropped and instead the tp_meter should become its own
> command in the netlink interface of batman-adv. Any opinions about that
> (order in which patches should be applied/netlink interface should be
> handled) by the Simon, Antonio, Marek, Matthias or Andrew?

Thanks for preparing the patchset! Antonio, Marek and me discussed and agreed 
that we should adopt the patchset as it is, and have the netlink support 
additionally at a later point.

Thanks,
    Simon
--nextPart4328060.oCiueURKrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKJlgAAoJEKEr45hCkp6hNCEP/2AZcc3jNAtIYxWv8rh2Nt92
7Y1ZdlhZOUUFiWHj2DbWQTI+aF1/fwoPa95PGHOJC7OldIAYP96pAXNRpyhh3qXV
cezcZ1fc71o6hvKaN21zjVpUZi0naZl/v3ZifYboS7DIsZ1HyyuxbALHNNkurv7n
KrbCkOlE7Q6vxbAZzUhOfwNzm5IYHrHMYBY42Cpb38Tho2xXP+MYrhMevu4uBGt+
Mf4N64HHjTXDTGwDADvxLTX3I+fVKnqnjUqjomwKF4ZQnY9PTq2WC1LaZh+EtpsB
nPBpB/AzeymtiwU+Hsxxbs8DVw/2gTdWPl18PqEgy9qCH6tE880DQCJXDvj8f2Kk
Y7Niv66CrZtxYzXbATz6VuoDLJdTclcIp5vocj6mHnIfNuD1gulqqtG1VsB3f68Q
ENjH0VzI+m/AntUbbL2KMtp4hV+PQUYh6ankJIsxSG8Uz9Jykl3zuaU4vtr0AYtS
Rc2yMdNik/BqUaHMalV0I7UYVp3/wBsmfevBDtms0PGK4s9SLvxNNtQABQK9+MX/
zsigA6lZ5jiYaKN+xuKTIsmWMgpp92AWrKAhOS5X1q9yXdI26Fc+s5P0sR5XKDZr
ic9oXwBw3H3WWVqdHb2asI3g75OSbLmURPpbZGXDLZ3XvQ1hzjdPU0k765getqxT
7EeDLGk7saTuuDD7xMxX
=v4Lj
-----END PGP SIGNATURE-----

--nextPart4328060.oCiueURKrN--

