Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 02 Feb 2014 22:38:13 +0800
Message-ID: <36618596.ZToeit0aZU@diderot>
In-Reply-To: <52E98B7E.4000400@meshcoding.com>
References: <1391037144-2448-1-git-send-email-antonio@meshcoding.com>
 <52E98B7E.4000400@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1849367.MWGkPibpK4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: properly check
	pskb_may_pull return value
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1849367.MWGkPibpK4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 30 January 2014 00:15:10 Antonio Quartulli wrote:
> On 30/01/14 00:12, Antonio Quartulli wrote:
> > pskb_may_pull() returns 1 on success and 0 in case of failure,
> > therefore checking for the return value being negative does
> > not make sense at all.
> >
> > 
> 
> I should have added:
> 
> This way if the function fails we will probably read beyond the current
> skb data buffer.

Applied in revision eabdc31.

Thanks,
Marek

--nextPart1849367.MWGkPibpK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS7lhVAAoJEFNVTo/uthzAFqEH/RCEvEwV442aRptfbYF/iZk6
kgYEech3y73nvRsTqEaEcXwNhI0TaTWemypvOCNxrz6Nfbl5QJMBcZeomgU1vozA
dtPU0lC6xz7GhRSCYzv0ZMqOBPucymuMH6kFeqHHBlrP9sb+DMxw7+huQcTsXEHR
9AFxvmCEWnYyDdZ9CD6zI/P620iY15n2vxhwGX1fUf2C8S4QwNTN9LswrO5zRFF1
V+NtTZvtni5/diFVTaNTyiPRD1Q1GkfdBKLweGhYc6a23Tkrl47eQhmP6mk6Lxsz
hEDjDKvt2FXuFszkPB4dG0et0/MU6plHnehjqBz8h94N6uxqBFTe6RVveHOLWjM=
=oaTh
-----END PGP SIGNATURE-----

--nextPart1849367.MWGkPibpK4--

