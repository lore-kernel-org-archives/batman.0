Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Scientific research
Date: Sun, 16 Aug 2020 22:52:22 +0200
Message-ID: <5875846.8nX1ehlX3a@sven-edge>
In-Reply-To: <159663455103.1225.17359938306185241419@diktynna.open-mesh.org>
References: <1533568759.456734.1596634544852.ref@mail.yahoo.com> <159663455103.1225.17359938306185241419@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6242944.YmMhbTAbEu"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Venceslas Ngounou <venceslas_2008@yahoo.fr>

 
--nextPart6242944.YmMhbTAbEu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

to be honest, the documentation needs an overhaul. There were some ideas to 
move it to sphinx and to have a more coherent structure. I've started with the 
conversion to restructuredText [1] some years ago but the person interested(?) 
in doing more work on the documentation in sphinx didn't continue the work. 
Maybe I have to lure Linus and Simon with some ice cream and discuss some 
ideas with them.

On Wednesday, 5 August 2020 15:35:44 CEST Venceslas Ngounou via B.A.T.M.A.N wrote:
> - An up to date documentation on Echo Location Protocol (ELP). On open-mesh.org, the dedicated page has the mention OUTDATED.

Yes, I've added the "outdated" because this documentation describes some ideas 
various people had. But they were not synced when the actual protocol was 
implemented. Things (most likely not complete) which don't line up:

* actual packet format is completely wrong
* not neighbors are announced but the "own" originator
* padding is not used for broadcast ELPs
* unicast ELPs are completely valid (for rate control probe packets)

Would be nice if the page could be checked and fixed by someone more familiar 
with ELP.

> - An up to date documentation on the different packet types

What do you have in mind here? Best documentation for the actual binary format 
is the uapi file batadv_packet.h [2]

> - Scientific papers (if any) related to the design or the modeling of the actuel version of BATMAN-adv.

Since batman-adv was never a traditional academic project, there were no 
papers written about it by the original authors during the development.

But there are two pages with pointers to various papers [3,4] but there 
weren't updated in the last 3 years. So you might find more interesting things 
on Google Scholar [5].

Kind regards,
	Sven


[1] https://git.open-mesh.org/doc.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/batadv_packet.h
[3] https://www.open-mesh.org/projects/open-mesh/wiki/Experience#Papers
[4] https://www.open-mesh.org/projects/open-mesh/wiki/New_papers
[5] https://scholar.google.com/scholar?q=batman-adv
--nextPart6242944.YmMhbTAbEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl85nIYACgkQXYcKB8Em
e0ZyMg//W9l9QQbus+spMs37Gz107OqOdHE9WJyHTUqBBFtom2HIIFxheeQFwQiZ
YMONxpV09Teu250JxVNmoCCjtjAD0ajUMq8EzaiZzof86PL6DOx4Gk6m1UXyR3H6
TuQqXaziCooFGGk4OKX2an9kVdGdqJSwgA/cPc2dER2IQH239h53cGkeqwG5BoH2
cG2lYwiNB6EBRb8SMg0/3KnmbFzBM66m4f/5sPpwKkMegLg0eyOo939NgHHG1MTm
Wu8HVH0+lUpP04ncl1TizMHA6WMA09CUtK3NfgVQOzYRUZFCpOruEevJ30ijoLTB
I9OeZ1GGiZMBllrBEUFDM03WShKtvqUV9UQ5UboNhR3j4mzLtnlCr3p05BW4pAY7
JKadecLHoprTlIY8xmLHbUf0K5JUzVkqTYINQpdOqd0qK32tHzlGpgshUFvsR8I5
4tEbGGEzaI7epgThWp/DaxYF0GIK7Z2xieoSg8Vpoq9RNhDym96U8uvwLXM0pVHO
DD63RISVWygnmqj71FPf9Sqx3dC+naZX6Ac0KHjCt4qAuo6FSD8v+kooB5yppO0l
FRA27Obe2mTXtdIo8kni6hkPoT0INh1sknuMYZpuN39jD2LIvD+Sof58dA4Sh2Hq
BXhZhTKrHLjhPijOHkUt0EtO0htEnVOFljDEh4lwzgN7tNThT6A=
=FWEI
-----END PGP SIGNATURE-----

--nextPart6242944.YmMhbTAbEu--


