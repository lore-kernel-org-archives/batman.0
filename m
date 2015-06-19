Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 16:53:48 +0800
Message-ID: <1600539.cQqiUDHWci@voltaire>
In-Reply-To: <5583D6B5.7050706@meshcoding.com>
References: <1434698334-9399-1-git-send-email-mareklindner@neomailbox.ch>
 <5583D6B5.7050706@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2648147.IgLpcKBT4r";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect
	tt_local_entry from concurrent delete events
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


--nextPart2648147.IgLpcKBT4r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 19, 2015 10:45:41 Antonio Quartulli wrote:
> On 19/06/15 09:18, Marek Lindner wrote:
> > The tt_local_entry deletion performed in batadv_tt_local_remove() was
> > neither protecting against simultaneous deletes nor checking whether the
> > element was still part of the list before calling hlist_del_rcu().
> >
> > 
> >
> > Replacing the hlist_del_rcu() call with batadv_hash_remove() provides
> > adequate protection via hash spinlocks as well as an
> > is-element-still-in-hash check to avoid 'blind' hash removal.
> >
> > 
> >
> > Fixes: 2443ba3 ("batman-adv: roaming handling mechanism redesign")
> >
> > 
> >
> > Reported-by: alfonsname@web.de
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision af912d7.

Regards,
Marek

--nextPart2648147.IgLpcKBT4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg9icAAoJEFNVTo/uthzAXN8H/RzywNFDCl5RJuGEICgBKaQf
8cIkYQMfBVKeVfbsdvJS7LE+BvIOTtglgT+BrKWnyirKItHgOPE91DdvIzXw43Is
ZjedaPmHFcUGw9xZFAeTp3EMoGzZEizSANIwmGU9wMIG2QT5UuiIqsvEekpPeDqL
gM2NRarUBJcuyOujdc1s7DKezQXkojnGLL6YBuIGMRo3SdY1mhqyGpSUfMkb0ZBA
NGc8jxNuZETpK+4Q3tve90TPv+ReueLqDqE2IAQSclB3P0G/0q+bUE4OIDjNFCIm
2aKguMQpAhdIf6Z4vze8YEyFqys8JFn4OnEjVbjgab7pFfC4awcaYvVHdBjBhpo=
=7Qd/
-----END PGP SIGNATURE-----

--nextPart2648147.IgLpcKBT4r--

