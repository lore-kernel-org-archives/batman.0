Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 29 Dec 2014 11:52:53 +0800
Message-ID: <1869722.k5Ufm3Cai9@diderot>
In-Reply-To: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
References: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2807509.uKbImGGr0F";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT
	client + orig-node memory leak
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


--nextPart2807509.uKbImGGr0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 13 December 2014 23:32:15 Linus L=FCssing wrote:
> This patch fixes a potential memory leak which can occur once an
> originator times out. On timeout the according global translation tab=
le
> entry might not get purged correctly. Furthermore, the non purged TT
> entry will cause its orig-node to leak, too. Which additionally can l=
ead
> to the new multicast optimization feature not kicking in because of a=

> therefore bogus counter.

So far, I am with you ..


> In the wild with larger mesh networks we saw this leak quite regularl=
y,
> resulting in routers to reboot or killed processes. This was because
> of a combination of two bugs: The bug fixed by commit
> "batman-adv: fix delayed foreign originator recognition" (8a2ad520467=
4)
> amplified this memory leak heavily. Since that commit I'd expect
> it to happen rarely, probably only in paused and resumed VMs and
> devices previously in stand-by.

This section shouldn't be part of the official commit message. It is ha=
rdly=20
relevant to the reviewer how often a memleak occurs and whether or not =
you=20
need a VM to trigger it. The provided commit id isn't valid in the Linu=
x tree.


> The issue this patch fixes is caused by batadv_orig_node_free_rcu()
> never being called because of not yet released references to the
> orig-node. References which were supposed to be released through
> batadv_orig_node_free_rcu()->batadv_tt_global_del_orig().

Could you please provide addition insight as to which references are st=
ill=20
held ? I did look around but nothing obvious jumped at me.=20

Generally, it wouldn't be bad if the commit message went into deeper de=
tail=20
describing the nature of the bug instead of the middle section above to=
 make=20
it easy to understand what is being fixed.


Cheers,
Marek

--nextPart2807509.uKbImGGr0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUoNAcAAoJEFNVTo/uthzApgYH+gLZdZIBNAJVr4fYKKx4aYf9
eLb2zkfmktUidf6iuqSbOk4Qx8RjRpqstMPkH0otSGm+GuzB2wL+nhkNIhfdWEki
htHmX/9HEKq9DpO/SWLaNjErb6tQzBbsiDjlI1X3M1CJETLw3yo/pahF6di7w+PN
xkzo17DHYpF/nXGS5F+tZ0usRl30RvQSzgOZBbzwtTRFNkFQ6pLo6cvI+cpspxb0
cPuPrLiILGEyp2/5pPihbxLIwEj4GEhxzfXIZxHDhMhw3NhmoVTVinqC1SiTzK5o
fBvQSuIdWVer/r0Lw82zxFn0pGiuwS2xsmNmJM+P7J9DhSgPTp89iDdadOSg/Uw=
=Ksju
-----END PGP SIGNATURE-----

--nextPart2807509.uKbImGGr0F--

