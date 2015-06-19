Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 16:51:51 +0800
Message-ID: <2911241.LlF8i4O7m1@voltaire>
In-Reply-To: <5583D639.2070403@meshcoding.com>
References: <1434698174-8899-1-git-send-email-mareklindner@neomailbox.ch>
 <5583D639.2070403@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14066816.RekGx64co1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: fix kernel crash due
	to missing NULL checks
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart14066816.RekGx64co1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 19, 2015 10:43:37 Antonio Quartulli wrote:
> Signed by antonio@meshcoding.com.	Show Details
> 
> On 19/06/15 09:16, Marek Lindner wrote:
> > batadv_softif_vlan_get() may return NULL which has to be verified
> > by the caller.
> >
> > 
> >
> > Fixes: 9729d20 ("batman-adv: fix TT VLAN inconsistency on VLAN re-add")
> >
> > 
> >
> > Reported-by: Ryan Thompson <ryan@eero.com>
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 2c2dfd8.

Regards,
Marek

--nextPart14066816.RekGx64co1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg9grAAoJEFNVTo/uthzA/kgH/3HikYlhl2Ykb1lEUmR8ij95
MhSiK7Rhu3zzWWsm/12isYwyaLhpV+mTlSQqN8/evtT1j3OXkUwqV029+PS5mZcZ
+ZUmgvoXSHmKnnwhD0DKIp0f2lwDkKVqqk84sEvmdlRj9Qh9sp6lKRrVB3OW8qQF
UAyUxNfSuQbNv08pItpP2MNomBs0+OzQ4ymYjgYWAqsDU8ISCloU/z0T2XO554Gn
KByffBorr9ksUTQBa7IrhtWD4W+24C0YyhFJgkMW1A5r3Y6Comixwngfl3s0UWCk
LTZAXvPVd9aSug7wUYf1KeN1BwmDFtn9S0nL+U7Xz1fhh8nrXCoqPp2imj+A1qA=
=F+7B
-----END PGP SIGNATURE-----

--nextPart14066816.RekGx64co1--

