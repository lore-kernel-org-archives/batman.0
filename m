Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 14 May 2014 20:27:09 +0800
Message-ID: <1718357.L1GdmN95yh@diderot>
In-Reply-To: <1399561995-10066-1-git-send-email-antonio@meshcoding.com>
References: <1399561995-10066-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1957990.PQMRXeykOV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 maint] batman-adv: fix TT VLAN
	inconsistency on VLAN re-add
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1957990.PQMRXeykOV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 08 May 2014 17:13:15 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When a VLAN interface (on top of batX) is removed and
> re-added within a short timeframe TT does not have enough
> time to properly cleanup. This creates an internal TT state
> mismatch as the newly created softif_vlan will be
> initialized from scratch with a TT client count of zero
> (even if TT entries for this VLAN still exist). The
> resulting TT messages are bogus due to the counter / tt
> client listing mismatch, thus creating inconsistencies on
> every node in the network
> 
> To fix this issue destroy_vlan() has to not free the VLAN
> object immediately but it has to be kept alive until all the
> TT entries for this VLAN have been removed. destroy_vlan()
> still removes the sysfs folder so that the user has the
> feeling that everything went fine.
> 
> If the same VLAN is re-added before the old object is free'd,
> then the latter is resurrected and re-used.
> 
> Implement such behaviour by increasing the reference counter
> of a softif_vlan object every time a new local TT entry for
> such VLAN is created and remove the object from the list
> only when all the TT entries have been destroyed.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Changes since v4:
> - improved code in add_vid()
> - don't leak TT entries in case of vlan re-add failure
> 
> Changes since v3:
> - always re-add NO_PURGE local entry on add_vid()
> 
> Changes since v2:
> - remove cleanup_work member that is not needed anymore in this approach
> - reword commit subject
> - reword commit message (Thanks Marek!)
> 
> Changes since v1:
> - destroy and create vlan sysfs folder within softif_vlan_destroy/create()
> to avoid lock troubles with soft-interface destruction and delayed jobs.
> 
> 
>  soft-interface.c    | 60
> ++++++++++++++++++++++++++++++++++++++++------------- translation-table.c |
> 26 +++++++++++++++++++++++
>  types.h             |  2 ++
>  3 files changed, 74 insertions(+), 14 deletions(-)

Applied in revision 9729d20.

Thanks,
Marek

--nextPart1957990.PQMRXeykOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTc2EhAAoJEFNVTo/uthzA9BEIAKm/iiVnEu/UHId7dqRxfWFc
nfmVcjLBiIxMZIhCOve/i5WXUG6a65aH6ylfYWePXAFR7mLQ1J52xwXOavKmYSc8
a4UWnQa6OXTcfFA4eKkZMSvR0AZ5wClXY0W81Y1WmVmnZNbST+c97zILQKOLHEkB
60NIvlHywxk2ch3Dy+AjwB6+kw2bHj6y6PoMEp/8blTdQAQylXmOYZz1xW7zu7YQ
xNErAHiIckBzaPxCYUl+t7eyc/AbDvdgMKSDVuzjLbrcbHrckhWgaf/trcvNXkzb
a6j4m9hzyNuWKrWIjjSJm4SK9l4BZbP+PjI7KtrPR7oVRNo7L/Xi4hDCb3T4U4I=
=r3ia
-----END PGP SIGNATURE-----

--nextPart1957990.PQMRXeykOV--

