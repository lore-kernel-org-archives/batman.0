Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jun 2016 23:31:44 +0800
Message-ID: <2127638.bt5QICn59H@voltaire>
In-Reply-To: <23629568.LZ3uSEMMIu@sven-edge>
References: <20160602230044.GM7555@decadent.org.uk>
 <23629568.LZ3uSEMMIu@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2326842.sjDJUD7SHO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix double-put of vlan object
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
Cc: Ben Hutchings <ben@decadent.org.uk>

--nextPart2326842.sjDJUD7SHO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 03, 2016 02:06:10 Sven Eckelmann wrote:
> On Friday 03 June 2016 00:00:44 Ben Hutchings wrote:
> > Commit a33d970d0b54 "batman-adv: Fix reference counting of vlan object
> > for tt_local_entry") makes each batadv_tt_local_entry hold a single
> > reference to a batadv_softif_vlan.  In case a new entry cannot be
> > added to the hash table, the error path puts the reference, but the
> > reference will also now be dropped by batadv_tt_local_entry_release().
> > 
> > Fixes: a33d970d0b54 ("batman-adv: Fix reference counting of vlan object
> > ...") Cc: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > This is untested; I just spotted this apparent oversight while trying
> > to backport the previous fix.
> 
> Yes, you are completely right. I've missed this line in the error handling
> path for hash_add in batadv_tt_local_add
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 22bb8b8.

Thanks,
Marek

--nextPart2326842.sjDJUD7SHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVZdgAAoJEFNVTo/uthzAZscH+wbmBHFM7RmGTygY8dMUCSFM
V+E+N8CB6g+Om/WSTeDin7IVmjUud2IHZstqbVi0Bapt4c2fqDBoqfRfR4odeEox
cqWPqL7dJlGKl5Jz6efmVbgSInqreJjZ9rp+Sko45VVyZA/CODbIgf4OqOU1UtWs
MscKD4HhSgGefDvuuhmQ3oNECvLgDiUkb5i2WfWS7ozNRb1+NUcLSrTeOttEaANe
UFsc+2TinXcuG3+Ev6kck50EHLO2GNVCUkMrPZW6mt3hZKmrTQdDeALhjvwE6CSE
LrYyjZ+NsXRVPoxRMzXND6dG4/WkiRAOAlOda/uvH3ZVZDEVj4Xy/mUUAaSYxf4=
=506X
-----END PGP SIGNATURE-----

--nextPart2326842.sjDJUD7SHO--

