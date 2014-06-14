Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Jun 2014 09:40:27 +0800
Message-ID: <5635074.nDv1YWok5K@diderot>
In-Reply-To: <1401117699-24587-1-git-send-email-sven@narfation.org>
References: <1401117699-24587-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7384385.Lvem9W5VPT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix out-of-order
	fragmentation support
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart7384385.Lvem9W5VPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 May 2014 17:21:39 Sven Eckelmann wrote:
> batadv_frag_insert_packet was unable to handle out-of-order packets because
> it dropped them directly. This is caused by the way the fragmentation lists
> is checked for the correct place to insert a fragmentation entry.
> 
> The fragmentation code keeps the fragments in lists. The fragmentation
> entries are kept in descending order of sequence number. The list is
> traversed and each entry is compared with the new fragment. If the current
> entry has a smaller sequence number than the new fragment then the new one
> has to be inserted before the current entry. This ensures that the list is
> still in descending order.
> 
> An out-of-order packet with a smaller sequence number than all entries in
> the list still has to be added to the end of the list. The used hlist has
> no information about the last entry in the list inside hlist_head and thus
> the last entry has to be calculated differently. Currently the code assumes
> that the iterator variable of hlist_for_each_entry can be used for this
> purpose after the hlist_for_each_entry finished. This is obviously wrong
> because the iterator variable is always NULL when the list was completely
> traversed.
> 
> Instead the information about the last entry has to be stored in a different
> variable.
> 
> This problem was introduced in 9b3eab61754d74a93c9840c296013fe3b4a1b606
> ("batman-adv: Receive fragmented packets and merge").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch was only build-tested
> ---
>  fragmentation.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied in revision 4c525d3.

Thanks,
Marek

--nextPart7384385.Lvem9W5VPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTm6gPAAoJEFNVTo/uthzA0c8H/2lncK6OrfHq4ZKi+BtBEzic
r680rfLFqSWmaCGqOBKlcsuoP9IjQjm++RV5mPEH9x+xZkbjXG4hbSCrRr+HLTyl
n/tWx4COxGOx+rWOSvifE5zzFoBCe69IIYtJ90NbmgYLnAeRItwOR3LWas4ObKce
vymCnHE0iX1jCp1DiLXmm20ncKjB6+LpIecD3rwHm/yqhN2mDJSWLeTxVFAEnGcU
wNcN23umAHYzAjtOGy4Ar4mppb5bq5JToZTN4EjwhyjVhXpAEOG8towvtdjLZbkZ
rHl3mSXT4+dBKh9576oFflBAlvc6FBa6WohEAvENP4v8Ij8z76QDZczijyXZypg=
=tkuw
-----END PGP SIGNATURE-----

--nextPart7384385.Lvem9W5VPT--

